import { ethers } from "hardhat";

async function main() {
    const nftContractFactory = ethers.getContractFactory('MyEpicNft');
    const nftContract =  (await nftContractFactory).deploy();
    (await nftContract).deployed();
    console.log("contract", nftContract);
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