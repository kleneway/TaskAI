// This script removes the agent resource from an account in the TaskChain.
//
// Parameters:
// - agentAddress: The address of the account to remove the agent from.

import AgentDeployment from "../../contracts/AgentDeployment.cdc"

transaction(agentAddress: Address) {
    let agent: @AgentDeployment.Agent

    prepare(acct: AuthAccount) {
        self.agent = acct.load<@AgentDeployment.Agent>(from: /storage/TaskAIAgent)
            ?? panic("Could not load agent from storage")
    }

    // Note: There's an assumption here that the account removing the agent has the necessary permissions to do so. If you want to handle cases where this may not be the case, you would need to add some kind of access control or permission system to the AgentDeployment contract.
    execute {
        destroy self.agent
        let capability = getAccount(agentAddress).getCapability(/public/TaskAIAgent)
        capability.unlink()
    }
}
