import { ethers } from "hardhat"
import { MyEpicNft } from "../typechain-types";

const main = async () => {
    const nftContractFactory = await ethers.getContractFactory("MyEpicNft");
    const nftContract = await nftContractFactory.deploy() as MyEpicNft;
    await nftContract.deployed();
    console.log("Deployed in testnet", nftContract.address);
    
    let txn = await nftContract.makeNft();
    await txn.wait();
    console.log("Minted Nft 1");
    txn = await nftContract.makeNft();
    await txn.wait();
    console.log("Minted Nft 2");
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error, "error");
        process.exit(1);
    }
}

runMain();