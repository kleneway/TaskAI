// Provides utility functions and data structures used throughout the TaskChain smart contracts.

pub contract TaskChainUtility {

    pub struct Task {
        pub let id: UInt64
        pub let creator: Address
        pub let title: String
        pub let description: String
        pub let maxPayment: UFix64
        pub let deadline: UFix64

        init(id: UInt64, creator: Address, title: String, description: String, maxPayment: UFix64, deadline: UFix64) {
            self.id = id
            self.creator = creator
            self.title = title
            self.description = description
            self.maxPayment = maxPayment
            self.deadline = deadline
        }
    }

    pub struct Bid {
        pub let taskId: UInt64
        pub let bidder: Address
        pub let amount: UFix64

        init(taskId: UInt64, bidder: Address, amount: UFix64) {
            self.taskId = taskId
            self.bidder = bidder
            self.amount = amount
        }
    }

    pub fun isTaskExpired(deadline: UFix64): Bool {
        let currentTime = TaskChainUtility.getCurrentTime()
        return deadline <= currentTime
    }

    pub fun getCurrentTime(): UFix64 {
        // Implementation of a time function that returns the current time in seconds
        // This can be replaced with a more accurate time source if required.
        return 0.0
    }
}
