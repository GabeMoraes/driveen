const { ethers } = require("hardhat");

async function main() {
    const rentContract = await ethers.getContractAt(
        "Rent",
        "0x5FbDB2315678afecb367f032d93F642f64180aa3",
        await ethers.getSigner("0x90F79bf6EB2c4f870365E785982E1f101E93b906")
        );

    await rentContract.registerDriver(
        "17/02/1998",
        "27.995.057-0",
        "Gabriel Moraes Ferreira",
        [
            "(21)98177-6545"
        ]
    );

    console.log(await rentContract.getSelf());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});