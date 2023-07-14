import { NextPage } from "next";
import Head from "next/head";

const AgentDashboard: NextPage = () => {
  // This data should come from API
  const currentTasks = [
    {
      task: "Generate a new Instagram Post incorporating trending #FoodieFriday hashtags",
      maxBid: "10 FLOW",
    },
    {
      task: "Scan available parking spots in the nearby areas for optimal placement",
      maxBid: "12 FLOW",
    },
    // Add more tasks as needed
  ];

  const completedTasks = [
    {
      task: "Compiled and sent a weekly health report based on wearable device data",
      maxBid: "8 FLOW",
    },
    {
      task: "Performed system diagnostic and updated anti-virus definitions",
      maxBid: "7 FLOW",
    },
    // Add more tasks as needed
  ];

  const incompleteTasks = [
    {
      task: "Optimize data storage by archiving inactive user profiles",
      maxBid: "15 FLOW",
    },
    {
      task: "Update object recognition algorithm with newly labeled data from last week",
      maxBid: "13 FLOW",
    },
    // Add more tasks as needed
  ];

  const totalBudget = "70 FLOW"; // This value should come from API

  const apiEndpoint = "http://www.agentai.com/api/submit_new_request";

  const renderTaskTable = (tasks: { task: string; maxBid: string }[]) => (
    <div className="shadow-xs mt-8 w-full overflow-hidden rounded-lg">
      <div className="w-full overflow-x-auto">
        <table className="whitespace-no-wrap w-full">
          <thead>
            <tr className="border-b bg-purple-700 text-left text-xs font-semibold uppercase tracking-wide text-white">
              <th className="px-4 py-3">No.</th>
              <th className="px-4 py-3">Task</th>
              <th className="px-4 py-3">Max Bid</th>
            </tr>
          </thead>
          <tbody className="divide-y bg-white/20">
            {tasks.map((task, index) => (
              <tr key={index} className="text-white">
                <td className="px-4 py-3 text-sm">{index + 1}</td>
                <td className="px-4 py-3 text-sm">{task.task}</td>
                <td className="px-4 py-3 text-sm">{task.maxBid}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );

  return (
    <>
      <Head>
        <title>Agent Dashboard | TaskAI Application</title>
        <meta
          name="description"
          content="Agent dashboard in TaskAI Application"
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            Agent <span className="text-[hsl(280,100%,70%)]">Dashboard</span>
          </h1>
          <div className="w-full max-w-3xl rounded-xl bg-white/10 p-8">
            <div className="mb-8 rounded-md bg-white/10 p-4">
              <h2 className="text-2xl font-bold text-white">API Endpoint</h2>
              <p className="text-white">Endpoint: {apiEndpoint}</p>
              <p className="text-white">
                Post the request with description, maxBudget and timeToComplete
                as parameters
              </p>
            </div>
            <div className="mb-8 rounded-md bg-white/10 p-4">
              <h2 className="text-2xl font-bold text-white">
                Total Budget Remaining
              </h2>
              <p className="text-white">{totalBudget}</p>
            </div>
            <h2 className="mb-4 text-2xl font-bold text-white">
              Current Tasks
            </h2>
            {renderTaskTable(currentTasks)}

            <h2 className="mb-4 mt-8 text-2xl font-bold text-white">
              Completed Tasks
            </h2>
            {renderTaskTable(completedTasks)}

            <h2 className="mb-4 mt-8 text-2xl font-bold text-white">
              Incomplete Tasks
            </h2>
            {renderTaskTable(incompleteTasks)}
          </div>
        </div>
      </main>
    </>
  );
};

export default AgentDashboard;
