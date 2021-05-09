// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Swappair is IERC721Receiver, IERC721 {
    bytes32[] public override allMarkets;

    mapping(bytes32 => address) public NFTHashToOwners;
    mapping(string => bytes32) public tokenURIsToHash;
    mapping(bytes32 => uint256) public hashToTokenIds;
    // mapping(string => uint256) public tokenURIsToTokenId;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    function depositNFT(
        address NFTOwner,
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) external {
        safeTransferFrom(msg.sender, address(this), tokenId);
        bytes32 memory nfthash = keccak256(abi.encodePacked("tokenURI"));
        NFTHashToOwners[nfthash] = msg.sender;
        hashToTokenIds[nfthash] = tokenId;
        emit Transfer(msg.sender, address(this), tokenId);
    }

    // function _createPair(string memory tokenURI1, string memory tokenURI2)
    //     internal
    //     returns (bytes32[])
    // {
    //     bytes32[] memory path = new bytes32[](2);
    //     path[0] = keccak256(abi.encodePacked("tokenURI"));
    //     path[1] = keccak256(abi.encodePacked("tokenURI2"));
    //     return path;
    // }

    // function _determineNFTOwner(bytes32[] memory _path)
    //     internal
    //     returns (address)
    // {
    //     for (uint256 i = 0; i < _path.length; i++) {
    //         require(NFTHashToOwners[_path[i]], "Not the owner");
    //         address nftOwner = NFTHashToOwners[_path[i]] == true;
    //         return nftOwner;
    //     }
    // }

    //exchanging an NFT
    function swapNFTMarket(string memory tokenURI1, string memory tokenURI2)
        external
    {
        bytes32[] memory path = new bytes32[](2);
        path[0] = keccak256(abi.encodePacked("tokenURI"));
        path[1] = keccak256(abi.encodePacked("tokenURI2"));
        require(
            NFTHashToOwners[path[0]] == true | NFTHashToOwners[path[1]] == true,
            "msg.sender shd be owner of one NFT"
        );

        if (NFTHashToOwners[path[0]] == msg.sender) {
            uint256 newNFT0 = hashToTokenIds[path[1]];
            safeTransferFrom(address(this), msg.sender, newNFT0);
            uint256 nftToOtherParty = hashToTokenIds[path[0]];
            address otherAddress = NFTHashToOwners[path[1]];
            safeTransferFrom(address(this), otherAddress, nftToOtherParty);
        } else {
            uint256 newNFT1 = hashToTokenIds[path[0]];
            safeTransferFrom(address(this), msg.sender, newNFT1);
            uint256 nftToOtherParty1 = hashToTokenIds[path[1]];
            address otherAddress1 = NFTHashToOwners[path[0]];
            safeTransferFrom(address(this), otherAddress1, nftToOtherParty1);
        }
    }
}
