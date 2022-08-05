const main = async () => {
  const beerContractFactory = await hre.ethers.getContractFactory(
    "BeerPortal"
  );
  const beerContract = await beerContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.01"),
  });
  await beerContract.deployed();
  console.log("Beer Contract deployed to:", beerContract.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    beerContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  const beerTxn = await beerContract.buyBeer(
    "This is beer #1",
    "Francis",
    ethers.utils.parseEther("0.001")
  );
  await beerTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(
    beerContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allBeer = await beerContract.getAllBeer();
  console.log(allBeer);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();