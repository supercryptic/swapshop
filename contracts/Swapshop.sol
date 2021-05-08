// pragma solidity 0.8.4;
// // SPDX-License-Identifier: MIT
// import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
// import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';

// contract Swapshop is IERC721Receiver {

// // MINIMUM_EXCHANGE_FEE == 0.001 ether;
// // mapping(address=> NFT)public ownersToNFTs;

// mapping(bytes32=> NFT) public nftNameToNFT;

// mapping(bytes32=>bytes32)public exchangeNftToNFT;

// //store various information about the NFT
// struct NFT{
//     bytes32 NFTName;
//     uint tokenId;
//     address ownerAddress;
// }

// constructor(){

// }

// //limit order
// function depositNFT(bytes32 calldata _NFTName, bytes32 calldata _NFTToExchange, uint256 _tokenId)public payable{
//     require(msg.value>=MINIMUM_EXCHANGE_FEE, 'Inadequate funds');
//     require(msg.sender == ownerOf(_tokenId), "Not NFT owner");
// safeTransferFrom(msg.sender, address(this),tokenId);
// // struct storage nftToTrade = NFT(_NFTName, _tokenId, msg.sender);
// // ownersToNFTs[msg.sender] = nftToTrade;
// nftNameToNFT[_NFTName] = nftToTrade;
// }

// function defineNFTToTrade(bytes32 calldata _NFTName, bytes32 calldata _NFTToExchange)public{
// require(msg.sender ==ownerOf(nftNameToNFT[_NFTName].ownerAddress), "Not the owner");
// //define NFT you want to trade for
// exchangeNFTToNFT[_NFTName] = _NFTToExchange;
// }

// function changeNFTToExchange(bytes calldata _NFTName,bytes calldata _newNFTName)public{
// require(ownerOf(_NFTName)==msg.sender, "Not the owner");
// exchangeNFTtoNFT[_NFTName]=_newNFTName;
// }

// function swap(bytes32 calldata _nftNameA, bytes32 calldata _nftNameB) public {
// require(ownerOf(_nftNameA) == msg.sender || ownerOf(_nftNameB) == msg.sender, "Invalid owner");
// //confirm both NFTs have been updated they want to swap for eachother
// require(nftNameToNFT[_nftNameA] == _nftNameB && nftToNFTName[_nftNameB]==_nftNameA, "NFTs not tradeable");
// address memory ownerA = nftNameToNFT[_nftNameA].ownerAddress;
// address memory ownerB = nftNameToNFT[_nftNameB].ownerAddress;
// // ownersToNFTs[ownerA] = nftNameToNFT[_nftNameB];
// // ownersToNFTs[ownerB] = nftNameToNFT[_nftNameA];
// nftNameToNFT[_nftNameA].ownerAddress = ownerB;
// nftNameToNFT[_nftNameB].ownerAddress = ownerA;
// exchangeNFTToNFT[_nftNameB] = null;
// exchangeNFTToNFT[_nftNameA] = null;
// }

// function withdrawNFT(bytes32 calldata _nftName)public{    
// require(msg.sender == nftNameToNFT[_nftName].ownerAddress, "Invalid owner");
// safeTransferFrom(address(this), msg.sender, tokenId);
// exchangeNFTToNFT[_nftName] = null;
// }

// }
