import FungibleToken from "./FungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"
import TaskAIAccount from "./TaskAIAccount.cdc"
import TaskQueue from "./TaskQueue.cdc"

// Handles the bidding process for tasks, including bid submissions, bid selection, 
// and time-based auction mechanics.
// This is WIP and will be updated to include more functionality.
pub contract TaskBidding {

    pub event BidPlaced(taskID: UInt64, bidder: Address, amount: UFix64)

    pub resource Bidding {
        pub fun placeBid(account: &signer, taskID: UInt64, amount: UFix64) {
            let taskQueue = TaskQueue.getTask(taskID: taskID)

            let vaultRef = account.borrow<&FlowToken.Vault>(from: /storage/TaskAIVault)
                ?? panic("Could not borrow reference to the account's TaskAIVault")

            let balance = vaultRef.balance
            if balance >= amount {
                let bidVault = vaultRef.withdraw(amount: amount)
                taskQueue.placeBid(bidder: account.address, amount: amount)
                emit BidPlaced(taskID: taskID, bidder: account.address, amount: amount)
                bidVault.deposit(from: <-vaultRef)
            }
        }

        pub fun updateBid(account: &signer, taskID: UInt64, newAmount: UFix64) {
            let taskQueue = TaskQueue.getTask(taskID: taskID)
            
            let vaultRef = account.borrow<&FlowToken.Vault>(from: /storage/TaskAIVault)
                ?? panic("Could not borrow reference to the account's TaskAIVault")

            let balance = vaultRef.balance
            if balance >= newAmount {
                taskQueue.updateBid(bidder: account.address, newAmount: newAmount)
                emit BidUpdated(taskID: taskID, bidder: account.address, amount: newAmount)
            } else {
                panic("Insufficient balance to update the bid")
            }
        }
    }

    init() {}

    pub fun createBidding(account: &signer): @Bidding {
        let bidding <- create Bidding()
        account.save(<-bidding, to: /storage/TaskAIBidding)
        return account.link<&Bidding>(/public/TaskAIBidding, target: /storage/TaskAIBidding) ?? panic("Could not link Bidding")
    }

    pub fun getBidding(account: &AnyResource{TaskAIAccount}): &Bidding {
        return account.borrow<&Bidding>(from: /storage/TaskAIBidding)
            ?? panic("Could not borrow reference to the account's Bidding resource")
    }
}
