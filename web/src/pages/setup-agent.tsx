import { NextPage } from "next";
import Head from "next/head";
import { useRouter } from "next/router";
import { useState } from "react";

const SetupAgent: NextPage = () => {
  const [agentName, setAgentName] = useState("");
  const [budget, setBudget] = useState("");
  const router = useRouter();

  const handleSubmit = (event: React.FormEvent) => {
    event.preventDefault();
    // Here you can call the API to setup the agent
    console.log("Agent Name:", agentName);
    console.log("Budget:", budget);
    router.push("/agent-dashboard");
  };

  return (
    <>
      <Head>
        <title>Setup Agent | TaskChain Application</title>
        <meta
          name="description"
          content="Setup a new agent in TaskChain Application"
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            Setup <span className="text-[hsl(280,100%,70%)]">Agent</span>
          </h1>
          <form
            onSubmit={handleSubmit}
            className="w-full max-w-lg rounded-xl bg-white/10 p-8"
          >
            <div className="mb-4">
              <label
                className="mb-2 block text-lg font-bold text-white"
                htmlFor="agentName"
              >
                Agent Name
              </label>
              <input
                className="focus:shadow-outline w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none"
                id="agentName"
                type="text"
                placeholder="Agent Name"
                value={agentName}
                onChange={(e) => setAgentName(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <label
                className="mb-2 block text-lg font-bold text-white"
                htmlFor="budget"
              >
                Budget
              </label>
              <input
                className="focus:shadow-outline w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none"
                id="budget"
                type="text"
                placeholder="Budget"
                value={budget}
                onChange={(e) => setBudget(e.target.value)}
              />
            </div>
            <div className="flex items-center justify-between">
              <button
                className="focus:shadow-outline rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700 focus:outline-none"
                type="submit"
              >
                Submit
              </button>
            </div>
          </form>
        </div>
      </main>
    </>
  );
};

export default SetupAgent;
