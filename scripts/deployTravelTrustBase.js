

const hre = require("hardhat");

async function main()  {
    const TravelTrustBase = await hre.ethers.getContractFactory("TravelTrustBase");
    const travelTrustBase = await TravelTrustBase.deploy();

    await travelTrustBase.deployed();

    console.log("TravelTrustBase deployed to:", travelTrustBase.address);
}
    main()
        .then(() => process.exit(0));
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });