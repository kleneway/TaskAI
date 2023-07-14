// This script updates a bid on a specific task in the TaskChain.
//
// Parameters:
// - bidderAddress: The address of the account that placed the bid.
// - taskID: The ID of the task for which the bid is placed.
// - newAmount: The new amount for the bid.

import TaskBidding from "../../contracts/TaskBidding.cdc"

transaction(bidderAddress: Address, taskID: UInt64, newAmount: UFix64) {

    prepare(acct: AuthAccount) {
        if acct.address == bidderAddress {
            let biddingRef = acct.borrow<&TaskBidding.Bidding>(from: /storage/TaskAIBidding)
                ?? panic("Could not borrow reference to the account's Bidding resource")

            biddingRef.updateBid(acct, taskID, newAmount)
        } else {
            panic("Only the bidder can update the bid")
        }
    }
}
