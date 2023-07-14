import { NextPage } from "next";
import Head from "next/head";
import Link from "next/link";

const BidderDashboard: NextPage = () => {
  return (
    <>
      <Head>
        <title>Bidder Dashboard | TaskAI Application</title>
        <meta
          name="description"
          content="Bidder Dashboard in TaskAI Application"
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            <span className="text-[hsl(280,100%,70%)]">Bidder Dashboard</span>
          </h1>
          <div className="w-full max-w-xl space-y-6 rounded-xl bg-white/10 p-8">
            <div>
              <h3 className="mb-4 text-2xl font-bold text-white">
                Your Models
              </h3>
              <div className="grid grid-cols-1 gap-4 sm:grid-cols-1 md:gap-8">
                <div className="flex w-full flex-col gap-4 rounded-xl bg-white/10 p-4 text-white">
                  <h4 className="text-xl font-medium">
                    Instagram Text-to-Image Creator
                  </h4>
                  <p>Bids accepted: 5</p>
                  <p>Bids denied: 2</p>
                  <p>Total earned: 100 FLOW</p>
                </div>
                {/* Repeat above div for each model */}
              </div>
            </div>
            <Link
              href="/setup-bidder"
              className="block w-full rounded-md bg-[hsl(280,100%,70%)] py-2 text-center text-white hover:bg-[hsl(280,100%,80%)]"
            >
              Add a new model
            </Link>
          </div>
        </div>
      </main>
    </>
  );
};

export default BidderDashboard;
