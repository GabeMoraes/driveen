const { ethers } = require("hardhat");

async function main() {
    const [companySigner, signer1, signer2] = await ethers.getSigners();
    const rentContract1 = await ethers.getContractAt(
        "Rent",
        "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9",
        companySigner
        );

    const rentContract2 = await ethers.getContractAt(
        "Rent",
        "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9",
        signer1
        );

    /* await rentContract2.registerDriver(
        "12/12/1992",
        "12.345.678-8",
        "Mary Smith",
        [
            "(21)93344-5566",
            "(21)95566-7788"
        ]
    ); */

    console.log(await rentContract1.getSelf());

    // console.log(await rentContract2.getSelf());

    console.log(await rentContract1.getDriver("0x90F79bf6EB2c4f870365E785982E1f101E93b906"));

    await rentContract1.registerCar(
        "123456789",
        "ABC-1234",
        "Fiat",
        "Uno",
        "2005"
    );

    console.log(await rentContract1.getCar("ABC-1234"));

    await rentContract2.rent("ABC-1234");

    console.log(await rentContract2.getSelf());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});