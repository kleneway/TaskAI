// This script returns the list of bids for a specific task in the TaskChain.
//
// Parameters:
// - requesterAddress: The address of the account that requested the task.
// - taskID: The ID of the task to check.

import TaskBidding from "../../contracts/TaskBidding.cdc"
import TaskQueue from "../../contracts/TaskQueue.cdc"

pub struct Bid {
    pub let bidder: Address
    pub let amount: UFix64

    init(bidder: Address, amount: UFix64) {
        self.bidder = bidder
        self.amount = amount
    }
}

pub fun main(requesterAddress: Address, taskID: UInt64): [Bid] {
    let bidding = getAccount(requesterAddress)
        .getCapability<&TaskBidding.Bidding>(/public/TaskAIBidding)
        .borrow()
        ?? panic("Could not borrow a reference to the bidding resource")

    let taskQueue = bidding.getTaskQueue(taskID: taskID)

    return taskQueue.getBids().map { bid in
        return Bid(bidder: bid.bidder, amount: bid.amount)
    }
}
