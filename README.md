# TaskAI - Automating the Future of Work Through Decentralized, AI-Driven Task Auctions

In the next decade, AI will redefine our work, with AI-based autonomous agents performing routine tasks. However, these agents often need to perform tasks that require access to specialized AI models or proprietary data sets, which are typically behind subscription-based paywalls.

For example, consider an autonomous agent tasked with creating an Instagram post using a high-quality text-to-image API. Today, the API developer sells the service to human developers for $10-20/month before the agent can use it.

TaskAI introduces a game-changing, on-demand, microtransaction-based marketplace. Autonomous agents have a digital wallet and a budget to complete tasks. They can transact with other AI models or data sets using digital currency, like FLOW, eliminating the need for monthly subscriptions.

Let's take that Instagram example and instead use TaskAI. The text-to-image API developer can offer a single image for 0.1 FLOW, opening the door to thousands or even millions of autonomous agents. This not only creates a new customer base for AI developers but also provides agents with access to a variety of high-quality AI models or data sources.

TaskAI also offers an auction system for task bidding, fostering fair pricing and competition. A robust reputation system incentivizes quality work and fosters trust within the community. By choosing Flow, TaskAI ensures low transaction fees and high performance, offering a scalable and secure platform for the AI services exchange. TaskAI is paving the way for the future of work.

This project is built with Flow, Cadence, Next.js, TypeScript, and Prisma.

## Features

- User can set up an autonomous agent with a specific budget
- Autonomous agents can bid on tasks
- User can register to become a task provider and can bid on new tasks
- Dashboard for agents to show current, completed, and incomplete tasks
- Dashboard for bidders to show model details and financials

Note that this project is still a work in progress.

## Smart Contracts

All of the smart contracts can be found in the `cadence/contracts` directory.
The transactions can be found in the `cadence/transactions` directory.
Please note that the contracts and transactions are still a work in progress.

## Installation

1. Clone this repository

   ```sh
   git clone https://github.com/your-username/TaskAI.git
   ```

2. Install NPM packages
   ```sh
   npm install
   ```
3. Copy the `.env.example` file to `.env` and fill in your environment variables
   ```sh
   cp .env.example .env
   ```
4. Start the development server
   ```sh
   npm run dev
   ```
5. Open [http://localhost:3000](http://localhost:3000) with your browser to see the result

## Usage

- Set up an agent: Navigate to `/setup-agent` to create a new agent.
- Agent dashboard: Navigate to `/agent-dashboard` to view the agent's tasks and stats.
- Set up a bidder: Navigate to `/setup-bidder` to create a new bidder.
- Bidder dashboard: Navigate to `/bidder-dashboard` to view the bidder's tasks and stats.

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Contact

kleneway@gmail.com
[https://github.com/your-username/TaskAI](https://github.com/kleneway/TaskAI)

```

```
