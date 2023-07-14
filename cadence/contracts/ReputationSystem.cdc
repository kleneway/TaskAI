import FlowToken from "FlowToken.cdc"
import TaskAIAccount from "./TaskAIAccount.cdc"
import TaskQueue from "./TaskQueue.cdc"
import TaskCompletion from "./TaskCompletion.cdc"

// Manages the reputation system for both task requesters and task completers, 
// tracking successful completions and dispute resolutions.
// This is a WIP and will be updated to include more functionality.
// Currently this is just a naive implementation with just upvoting/downvoting.

pub contract ReputationSystem {

    pub event ReputationUpdated(address: Address, newReputation: UInt64)

    pub resource Reputation {
        pub var reputation: UInt64

        init() {
            self.reputation = 0
        }

        pub fun updateReputation(delta: Int64) {
            let newReputation = UInt64(Int64(self.reputation) + delta)
            self.reputation = newReputation
            emit ReputationUpdated(address: self.owner?.address!, newReputation: newReputation)
        }
    }

    init() {}

    pub fun createReputation(account: &signer): @Reputation {
        let reputation <- create Reputation()
        account.save(<-reputation, to: /storage/TaskAIReputation)
        return account.link<&Reputation>(/public/TaskAIReputation, target: /storage/TaskAIReputation)
    }

    pub fun getReputation(account: Address): &Reputation {
        return account.borrow<&Reputation>(from: /public/TaskAIReputation)
            ?? panic("Could not borrow reference to the account's Reputation resource")
    }
}
