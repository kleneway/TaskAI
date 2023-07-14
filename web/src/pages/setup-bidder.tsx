import { NextPage } from "next";
import Head from "next/head";
import Link from "next/link";
import { useRouter } from "next/router";

const SetupBidder: NextPage = () => {
  const router = useRouter();
  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    const formData = new FormData(event.currentTarget);

    // Call your API endpoint here
    // const response = await fetch('/api/your-endpoint', {
    //   method: 'POST',
    //   body: formData
    // });

    // After successful API call, redirect to the bidder-dashboard page
    // if (response.ok) {
    router.push("/bidder-dashboard");
    // }
  };

  return (
    <>
      <Head>
        <title>Setup Bidder | TaskChain Application</title>
        <meta
          name="description"
          content="Setup Bidder in TaskChain Application"
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            Setup <span className="text-[hsl(280,100%,70%)]">Bidder</span>
          </h1>
          <div className="w-full max-w-md rounded-xl bg-white/10 p-8">
            <form className="space-y-6" onSubmit={handleSubmit}>
              <div>
                <label
                  className="mb-2 block text-sm font-medium text-white"
                  htmlFor="info"
                >
                  Your Name
                </label>
                <input
                  id="info"
                  name="info"
                  className="w-full rounded-md px-3 py-2 text-gray-900 placeholder-gray-500 focus:outline-none"
                  placeholder="Enter name..."
                ></input>
              </div>
              <div>
                <label
                  className="mb-2 block text-sm font-medium text-white"
                  htmlFor="wallet"
                >
                  FLOW Wallet ID
                </label>
                <input
                  id="wallet"
                  name="wallet"
                  type="text"
                  className="w-full rounded-md px-3 py-2 text-gray-900 placeholder-gray-500 focus:outline-none"
                  placeholder="Enter FLOW Wallet ID..."
                />
              </div>
              <div>
                <label
                  className="mb-2 block text-sm font-medium text-white"
                  htmlFor="manifestFile"
                >
                  Upload Manifest File
                </label>
                <input
                  id="manifestFile"
                  name="manifestFile"
                  type="file"
                  className="w-full px-3 py-2 text-gray-900"
                />
              </div>
              <div>
                <button
                  type="submit"
                  className="w-full rounded-md bg-[hsl(280,100%,70%)] px-3 py-2 text-white hover:bg-[hsl(280,100%,80%)]"
                >
                  Submit
                </button>
              </div>
            </form>
          </div>
        </div>
      </main>
    </>
  );
};

export default SetupBidder;
