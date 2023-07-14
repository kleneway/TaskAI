import FungibleToken from "./FungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"

pub contract TaskAIAccount {

    pub let TokenReceiverPath: CapabilityPath

    init() {
        self.TokenReceiverPath = /public/FlowTokenReceiver
    }

    pub resource AccountManager {

        pub fun depositTokens(account: &signer, amount: UFix64) {
            let sender = account.borrow<&FungibleToken.Vault>(from: /storage/FlowTokenVault)
                ?? panic("Could not borrow reference to the sender's Vault")

            let receiver = account.getCapability<&AnyResource{FlowToken.Receiver}>(TaskAIAccount.TokenReceiverPath)
                .borrow()
                ?? panic("Could not borrow reference to the receiver's Receiver")

            receiver.deposit(from: <-sender.withdraw(amount: amount))
        }

        pub fun withdrawTokens(account: &signer, amount: UFix64): @FungibleToken.Vault {
            let vault = account.borrow<&FlowToken.TokenVault>(from: /storage/FlowTokenVault)
                ?? panic("Could not borrow reference to the account's Vault")

            return <-vault.withdraw(amount: amount)
        }
    }

    pub fun createAccount(): Capability<&AnyResource{FlowToken.Receiver}> {
        let newAccount = AuthAccount(payer: getCurrentAccount())
        return newAccount.getCapability<&AnyResource{FlowToken.Receiver}>(TaskAIAccount.TokenReceiverPath)
    }
}
