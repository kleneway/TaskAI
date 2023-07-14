// This script returns the outstanding bids for a specific bidder in the TaskAI.
//
// Parameters:
// - bidderAddress: The address of the bidder account.

import TaskBidding from "../../contracts/TaskBidding.cdc"
import TaskQueue from "../../contracts/TaskQueue.cdc"

pub fun main(bidderAddress: Address): {UInt64: UFix64} {
    let bidder = getAccount(bidderAddress)
    let bidding = bidder.getCapability<&{TaskBidding.Bidding}>(/public/TaskAIBidding)
        .check()
        ?? panic("Could not borrow reference to the bidder's bidding resource")

    let taskQueue = TaskQueue.getQueue()
    let taskIDs = taskQueue.getTaskIDs()
    let outstandingBids: {UInt64: UFix64} = {}

    for taskID in taskIDs {
        let task = taskQueue.getTask(taskID: taskID)
        let bid = task.getBids().filter({(address, amount) in address == bidderAddress})
        if bid.length > 0 {
            outstandingBids[taskID] = bid[0].1
        }
    }

    return outstandingBids
}
