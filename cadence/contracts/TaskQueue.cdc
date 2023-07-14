import FungibleToken from "./FungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"
import TaskAIAccount from "./TaskAIAccount.cdc"

// Manages the queue of tasks, allowing agents to create and post tasks, 
// and other agents or users to bid on and complete them.
pub contract TaskQueue {

    pub event TaskCreated(taskID: UInt64)
    pub event TaskBid(taskID: UInt64, bidder: Address, amount: UFix64)
    pub event TaskCompleted(taskID: UInt64, winner: Address)

    pub resource Task {
        pub let id: UInt64
        pub let creator: Address
        pub let description: String
        pub let maxBid: UFix64
        pub var currentBid: UFix64
        pub var winner: Address?
        pub var isCompleted: Bool

        init(creator: Address, description: String, maxBid: UFix64) {
            self.id = TaskQueue.nextTaskID()
            self.creator = creator
            self.description = description
            self.maxBid = maxBid
            self.currentBid = 0.0
            self.winner = nil
            self.isCompleted = false
        }

        pub fun placeBid(bidder: Address, amount: UFix64) {
            pre {
                amount <= self.maxBid: "Bid amount exceeds the maximum allowed"
                !self.isCompleted: "Task has already been completed"
            }
            if amount > self.currentBid {
                self.winner = bidder
                self.currentBid = amount
                emit TaskBid(taskID: self.id, bidder: bidder, amount: amount)
            }
        }

        pub fun completeTask() {
            pre {
                !self.isCompleted: "Task has already been completed"
            }
            self.isCompleted = true
            emit TaskCompleted(taskID: self.id, winner: self.winner!)
        }

        pub fun hasBeenCompleted(): Bool {
            return self.isCompleted
        }
    }

    access(contract) var taskCounter: UInt64
    access(contract) var tasks: @{UInt64: Task}

    init() {
        self.taskCounter = 0
        self.tasks = {}
    }

    access(contract) fun nextTaskID(): UInt64 {
        self.taskCounter = self.taskCounter + 1
        return self.taskCounter
    }

    pub fun createTask(account: &signer, description: String, maxBid: UFix64): UInt64 {
        let accountManager = account.borrow<&TaskAIAccount.AccountManager>(from: /storage/TaskAIAccountManager)
            ?? panic("Could not borrow reference to the account's AccountManager")

        let task = Task(creator: account.address, description: description, maxBid: maxBid)
        let taskID = task.id
        self.tasks[taskID] = task

        emit TaskCreated(taskID: taskID)

        return taskID
    }

    pub fun getTask(taskID: UInt64): &Task {
        return &self.tasks[taskID] as! &Task
    }

    pub fun placeBid(account: &signer, taskID: UInt64, amount: UFix64) {
        let task = self.getTask(taskID: taskID)
        task.placeBid(bidder: account.address, amount: amount)
    }

    pub fun completeTask(account: &signer, taskID: UInt64) {
        pre {
            self.tasks[taskID]?.creator == account.address: "Only the task creator can complete the task"
        }
        let task = self.getTask(taskID: taskID)
        task.completeTask()
    }

    // This is called by the task creator to verify the result of the task
    pub fun verifyResult(account: &signer, taskID: UInt64) {
        let task = self.getTask(taskID: taskID)
        pre {
            self.tasks[taskID]?.creator == account.address: "Only the task creator can complete the task"
        }
        let accountManager = account.borrow<&TaskAIAccount.AccountManager>(from: /storage/TaskAIAccountManager)
            ?? panic("Could not borrow reference to the account's AccountManager")
        accountManager.deposit(amount: task.currentBid)
    } 
}
