import FungibleToken from "./FungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"
import TaskAIAccount from "./TaskAIAccount.cdc"
import TaskQueue from "./TaskQueue.cdc"

// Manages the process of task completion, ensuring that results are submitted 
// and verified before releasing the payment to the winning agent.

pub contract TaskCompletion {

    pub event TaskCompleted(taskID: UInt64, agent: Address)

    pub resource Completion {
        pub fun submitResult(account: &signer, taskID: UInt64, result: String) {
            let taskQueue = TaskQueue.getTask(taskID: taskID)
            taskQueue.submitResult(agent: account.address, result: result)
        }

        pub fun verifyResult(account: &signer, taskID: UInt64, isVerified: Bool) {
            let taskQueue = TaskQueue.getTask(taskID: taskID)
            let paymentVault = taskQueue.verifyResult(verifier: account.address, isVerified: isVerified)
            if isVerified {
                let TaskAIVault = account.borrow<&FlowToken.Vault>(from: /storage/TaskAIVault)
                    ?? panic("Could not borrow reference to the account's TaskAIVault")
                TaskAIVault.deposit(from: <-paymentVault)
                emit TaskCompleted(taskID: taskID, agent: account.address)
            } else {
                paymentVault.deposit(from: <-paymentVault)
            }
        }

        // Get a reference to the TaskQueue for a given task
        pub fun getTaskQueue(taskID: UInt64): &{TaskQueue.Task} {
            return TaskQueue.getTask(taskID: taskID)
        }
    }

    init() {}

    pub fun createCompletion(account: &signer): @Completion {
        let completion <- create Completion()
        account.save(<-completion, to: /storage/TaskAICompletion)
        account.link<&Completion>(/public/TaskAICompletion, target: /storage/TaskAICompletion)
    }

    pub fun getCompletion(account: Address): &Completion {
        return account.borrow<&Completion>(from: /public/TaskAICompletion)
            ?? panic("Could not borrow reference to the account's Completion resource")
    }
}
