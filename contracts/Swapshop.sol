pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT
import '@openzeppelin/contracts/token/ERC721/IERC721.sol'
import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';

contract Swapshop is IERC721Receiver {

MINIMUM_EXCHANGE_FEE = 0.001 ether;
mapping(address=> NFT)public ownersToNFTs;

mapping(bytes32=> NFT) public nftNameToNFT;

mapping(bytes32=>bytes32)public exchangeNftToNFT;

struct NFT{
    bytes32 NFTName;
    uint tokenId;
    address ownerAddress;
}


//limit order
function depositNFT(bytes32 calldata _NFTName, bytes32 calldata _NFTToExchange, uint256 _tokenId)public payable{
    require(msg.value>=MINIMUM_EXCHANGE_FEE, 'Inadequate funds');
    require(msg.sender == ownerOf(_tokenId), "Not NFT owner");
safeTransferFrom(msg.sender, address(this),tokenId);
struct memory nftToTrade = NFT(_NFTName, _tokenId, NFTToExchange, Counter, msg.sender);
ownersToNFTs[msg.sender] = nftToTrade;
nftToNFT[_NFTName] = _NFTToExchange;
nftNameToNFT[_NFTName] = nftToTrade;
}

function changeNFTToExchange(bytes calldata _NFTName,bytes calldata _newNFTName)public{
require(ownerOf(_NFTName)==msg.sender, "Not the owner");
nfttoNFT[_NFTName]=_newNFTName;
}

function swap(bytes32 calldata _nftNameA, bytes32 calldata _nftNameB) public {
require(ownerOf(_nftNameA) == msg.sender || ownerof(_nftNameB) == msg.sender, "Invalid owner");
require(nftNameToNFT[_nftNameA] == _nftNameB && nftToNFTName[_nftNameB]==_nftNameA, "NFTs not tradeable");
address memory ownerA = nftNameToNFT[_nftNameA].ownerAddress;
address memory ownerB = nftNameToNFT[_nftNameB].ownerAddress;
ownersToNFTs[ownerA] = nftNameToNFT[_nftNameB];
ownersToNFTs[ownerB] = nftNameToNFT[_nftNameA];
nftNameToNFT[_nftNameA] = 

}

function withdrawNFT(bytes32 calldata _nftName)public{
    
require(msg.sender == ownersToNFTs[_nftName], "Invalid owner");
safeTransferFrom(address(this), msg.sender, tokenId);

}

}
