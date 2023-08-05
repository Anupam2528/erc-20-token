const hre = require("hardhat");

async function main() {
  const NevermoreToken = await hre.ethers.getContractFactory("NevermoreToken");
  const nevermoreToken = await NevermoreToken.deploy(100000000, 50);

  await nevermoreToken.waitForDeployment();

  console.log("Deploying contract...");

  console.log("Nevermore Token deployed: ", nevermoreToken.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
