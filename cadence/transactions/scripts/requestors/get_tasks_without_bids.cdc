// This script returns the list of tasks without any bids in the TaskAI.
//
// Parameters:
// - requesterAddress: The address of the account to check for tasks.

import TaskBidding from "../../contracts/TaskBidding.cdc"
import TaskQueue from "../../contracts/TaskQueue.cdc"

pub struct Task {
    pub let taskID: UInt64
    pub let requester: Address
    pub let description: String

    init(taskID: UInt64, requester: Address, description: String) {
        self.taskID = taskID
        self.requester = requester
        self.description = description
    }
}

pub fun main(requesterAddress: Address): [Task] {
    let bidding = getAccount(requesterAddress)
        .getCapability<&TaskBidding.Bidding>(/public/TaskAIBidding)
        .borrow()
        ?? panic("Could not borrow a reference to the bidding resource")

    let tasks = bidding.getAllTasks()

    return tasks.filter { task in
        return task.getBids().length == 0
    }.map { taskWithoutBid in
        return Task(
            taskID: taskWithoutBid.id,
            requester: taskWithoutBid.requester,
            description: taskWithoutBid.description
        )
    }
}
