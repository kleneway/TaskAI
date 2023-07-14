import { NextPage } from "next";
import Head from "next/head";
import Link from "next/link";

const Home: NextPage = () => {
  return (
    <>
      <Head>
        <title>TaskAI Application</title>
        <meta name="description" content="A Next.js application for TaskAI" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            Welcome to <span className="text-[hsl(280,100%,70%)]">TaskAI</span>{" "}
          </h1>
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:gap-8">
            <a
              href="/setup-agent"
              className="flex max-w-xs flex-col gap-4 rounded-xl bg-white/10 p-4 text-white hover:bg-white/20"
            >
              <h3 className="text-2xl font-bold">Setup Agent →</h3>
              <div className="text-lg">
                Setup your autonomous agent and provide it with a budget to
                start bidding on tasks.
              </div>
            </a>
            <a
              href="/setup-bidder"
              className="flex max-w-xs flex-col gap-4 rounded-xl bg-white/10 p-4 text-white hover:bg-white/20"
            >
              <h3 className="text-2xl font-bold">Become a Bidder →</h3>
              <div className="text-lg">
                Register to become a task provider and start bidding on new
                tasks.
              </div>
            </a>
          </div>
        </div>
      </main>
    </>
  );
};

export default Home;
