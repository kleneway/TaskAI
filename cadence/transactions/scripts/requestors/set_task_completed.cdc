// This script verifies a task and marks it as completed in the TaskChain.
//
// Parameters:
// - verifierAddress: The address of the account that will verify the task.
// - taskID: The ID of the task to be verified and completed.

import TaskCompletion from "../../contracts/TaskCompletion.cdc"

transaction(verifierAddress: Address, taskID: UInt64) {
    let verifier: &signer

    prepare(account: &signer) {
        self.verifier = account
    }

    execute {
        let completionCapability = self.verifier.borrow<&{TaskCompletion.Completion}>(from: /public/TaskAICompletion)
            ?? panic("Could not borrow a reference to the completion resource")

        completionCapability.verifyResult(account: verifierAddress, taskID: taskID, isVerified: true)
    }
}
