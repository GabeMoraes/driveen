const { ethers } = require("hardhat");

async function main() {
    const rentContract = await ethers.deployContract("Rent");
    await rentContract.waitForDeployment();
    console.log(`Contract "Rent" deployed to ${rentContract.target}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});