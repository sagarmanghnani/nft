// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNft is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string[] firstWords = ["Naruto", "SpyX", "One punch Man", "Attack on titan"];
        string[] secondWords = ["Naruto Uzumaki", "Sasuke Uchiha", "Itachi Uchiha", "Orochimaru"];
        string[] thirdWords = ["Fireball Jutsu", "Rasengan", "Sharingan", "Amatarasu"];
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    constructor() ERC721("SagNft", "SNFT") {
        console.log("Nft Constructor called");
    }

    
    
    function random(string memory _input) internal pure returns (uint) {
        return uint256(keccak256(abi.encodePacked(_input)));
    }

    function pickRandomWord(uint _tokenId, uint8 _arrNumber, string[] memory arrToProcess) public pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(_tokenId, _arrNumber)));
        uint index = rand % arrToProcess.length;
        return arrToProcess[index];
    }

    function makeNft() public {
        uint256 newItemId = _tokenIds.current();
        // Actually mint the NFT to the sender using msg.sender.
        // getting random words from the array
        string memory firstWord = pickRandomWord(newItemId, 1, firstWords);
        string memory secondWord = pickRandomWord(newItemId, 2, secondWords);
        string memory thirdWord = pickRandomWord(newItemId, 3, thirdWords);

        console.log("first word %s, second word %s, third word %s", firstWord, secondWord, thirdWord);
        string memory finalSvg = string(abi.encodePacked(baseSvg, firstWord, secondWord, thirdWord, "</text></svg>"));
        string memory combinedWord = string(abi.encodePacked(firstWord, secondWord, thirdWord));
        string memory json = Base64.encode(bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        ));
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");
        _safeMint(msg.sender, newItemId);
         // Set the NFTs data.
         _setTokenURI(newItemId, finalTokenUri);
         _tokenIds.increment();
         console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}