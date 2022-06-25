import { ethers } from "hardhat";
import {MyEpicNft} from '../typechain-types/contracts/MyEpicNft'

async function main() {
    const nftContractFactory = await ethers.getContractFactory('MyEpicNft');
    const nftContract = await nftContractFactory.deploy() as unknown as MyEpicNft;
    nftContract.deployed();
    console.log("contract", nftContract.address);
    let txn = await nftContract.makeNft();
    await txn.wait();
}

const runMain = async () => {
    try{
        await main();
        process.exit(0);
    } catch(err) {
        console.log(err, "error");
        process.exit(1);
    }
}

runMain();