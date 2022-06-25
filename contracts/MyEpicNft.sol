// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNft is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    constructor() ERC721("SagNft", "SNFT") {
        console.log("Nft Constructor called");
    }

    function makeNft() public {
        uint256 newItemId = _tokenIds.current();
        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

         // Set the NFTs data.
         _setTokenURI(newItemId, "https://jsonkeeper.com/b/8L8C");
         _tokenIds.increment();

    }
}