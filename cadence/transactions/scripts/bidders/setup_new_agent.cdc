// This script sets up a new agent on an account in the TaskAI.
//
// Parameters:
// - pluginManifest: The manifest of the plugin to deploy as the agent.

import AgentDeployment from "../../contracts/AgentDeployment.cdc"

transaction(pluginManifest: String) {

    prepare(acct: AuthAccount) {
        if acct.borrow<&AgentDeployment.Agent>(from: /storage/TaskAIAgent) == nil {
            let agent <- AgentDeployment.createAgent(pluginManifest: pluginManifest)
            acct.save(<-agent, to: /storage/TaskAIAgent)
        } else {
            panic("An agent is already deployed on this account")
        }
    }
}
