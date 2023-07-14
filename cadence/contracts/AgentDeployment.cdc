import FungibleToken from "./FungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"
import TaskAIAccount from "./TaskAIAccount.cdc"
import TaskQueue from "./TaskQueue.cdc"
import TaskCompletion from "./TaskCompletion.cdc"
import ReputationSystem from "./ReputationSystem.cdc"

// Facilitates the deployment of agents using a standardized format 
// that is a superset of the ChatGPT Plugin format, ensuring compatibility with OpenAI plugins.
// More info on ChatGPT Plugin manifests are available here: https://platform.openai.com/docs/plugins/introduction

pub contract AgentDeployment {

    pub resource Agent {
        pub var pluginManifest: String

        init(pluginManifest: String) {
            self.pluginManifest = pluginManifest
        }

        pub fun updatePluginManifest(newManifest: String) {
            self.pluginManifest = newManifest
        }
    }

    init() {}

    pub fun createAgent(account: &signer, pluginManifest: String): @Agent {
        let agent <- create Agent(pluginManifest: pluginManifest)
        account.save(<-agent, to: /storage/TaskAIAgent)
       return account.link<&Agent>(/public/TaskAIAgent, target: /storage/TaskAIAgent)
    }

    pub fun getAgent(account: Address): &Agent {
        return account.capabilities.borrow<&Agent>(from: /public/TaskAIAgent)
            ?? panic("Could not borrow reference to the account's Agent resource")
    }
}
