// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Swappair is IERC721Receiver {

bytes32 [] public override allMarkets;

mapping(bytes32 => address) public NFTHashToOwners;
mapping(string => bytes32) public tokenURIsToHash;
mapping(string => uint) public tokenURIsToTokenId;

event Transfer(from, to, tokenId);

function depositNFT(address NFTOwner, address to, uint tokenId, string memory tokenURI)external {
safeTransferFrom(msg.sender, address(this), tokenId);
bytes32 memory nfthash = keccak256(abi.encodePacked('tokenURI'));
NFTHashToOwners[nfthash] = msg.sender;
emit Transfer(msg.sender, address(this), tokenId)
}

function createPair(string memory tokenURI1, string memory tokenURI2) internal {
    bytes32 [] memory path = new bytes32[](2);
    path[0] = keccak256(abi.encodePacked('tokenURI'));
    path[1] = keccak256(abi.encodePacked('tokenURI2'));
    }

//exchanging an NFT
    function swapNFTMarket( path, string memory tokenURI)
        external
           {
        require(keccak256(abi.encodePacked(tokenURI)) == path[0]|path[1], "NFT not in path");
        bytes32 memory senderHash = keccak256(abi.encodePacked(tokenURI)); 
        senderNFT = HashToTokenURI[senderHash] 
if (senderHash == path[0]){
    NFTHashToOwner[path[1]]
safeTransfer()
}
{

}

if!(keccak256(abi.encodePacked('tokenURI')) == NFTHashToOwners[msg.sender]){
  address memory otherParty = nftHashToOwners[]
}
    }
}
