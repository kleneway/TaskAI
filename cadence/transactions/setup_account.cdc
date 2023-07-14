import TaskBidding from "../../contracts/TaskBidding.cdc"
import AgentDeployment from "../../contracts/AgentDeployment.cdc"

transaction {
    prepare(acct: AuthAccount) {

        // Setup Bidding Capability
        if !acct.capabilities.get<&TaskBidding.Bidding>(/public/TaskAIBidding).check() {
            let bidding <- TaskBidding.createBidding()
            acct.save(<-bidding, to: /storage/TaskAIBidding)
            acct.link<&TaskBidding.Bidding>(/public/TaskAIBidding, target: /storage/TaskAIBidding)
        }

        // Setup Agent Deployment Capability
        // Note: The pluginManifest string should be replaced with the actual manifest of the AI agent.
        if !acct.capabilities.get<&AgentDeployment.Agent>(/public/TaskAIAgent).check() {
            let agent <- AgentDeployment.createAgent(pluginManifest: "manifest string")
            acct.save(<-agent, to: /storage/TaskAIAgent)
            acct.link<&AgentDeployment.Agent>(/public/TaskAIAgent, target: /storage/TaskAIAgent)
        }
    }
}
