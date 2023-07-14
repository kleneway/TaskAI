// This script returns the status of a specific task in the TaskAI.
//
// Parameters:
// - requesterAddress: The address of the account that requested the task.
// - taskID: The ID of the task to check.

import TaskCompletion from "../../contracts/TaskCompletion.cdc"
import TaskQueue from "../../contracts/TaskQueue.cdc"

pub fun main(requesterAddress: Address, taskID: UInt64): Bool {
    let completion = getAccount(requesterAddress)
        .getCapability<&TaskCompletion.Completion>(/public/TaskAICompletion)
        .borrow()
        ?? panic("Could not borrow a reference to the task completion resource")

    let taskQueue = completion.getTaskQueue(taskID: taskID)

    return taskQueue.hasBeenCompleted()
}
