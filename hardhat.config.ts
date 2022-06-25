import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

dotenv.config({path:__dirname+'/.env.example'});

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: "0.8.4",
  networks: {
    ropsten: {
      url: process.env.ROPSTEN_URL || "",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    hardhat: {
      chainId:1337
    },
    goerli: {
      url:process.env.GOERLI_API_KEY,
      accounts: [process.env.METAMASK_PRIVATE_KEY ?? '']
    },
    rinkeby: {
      url:process.env.RINKEBY_API_URL,
      accounts:[process.env.METAMASK_PRIVATE_KEY ?? '']
    }
  },
  // typechain: {
  //   outDir:"src/types",
  //   target:"ethers-v5"
  // }
};


export default config;
