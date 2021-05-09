// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Swappair is IERC721Receiver, ERC721 {
    bytes32[] public allMarkets;

    mapping(bytes32 => address) public NFTHashToOwners;
    mapping(string => bytes32) public tokenURIsToHash;
    mapping(bytes32 => uint256) public hashToTokenIds;

    // mapping(string => uint256) public tokenURIsToTokenId;

    // event Transfer(
    //     address indexed from,
    //     address indexed to,
    //     uint256 indexed tokenId
    // );

    constructor() ERC721("Swap", "SWP") {}

    function onERC721Received(
        address operator, //my contract address
        address from, //nftowner
        uint256 tokenId,
        bytes calldata data,
        string memory tokenURI
    ) external override returns (bytes4) {
        _approve(address(this), tokenId);
        safeTransferFrom(msg.sender, address(this), tokenId);
        bytes32 nftHash = keccak256(abi.encodePacked("tokenURI"));
        NFTHashToOwners[nftHash] = msg.sender;
        hashToTokenIds[nftHash] = tokenId;
        // emit Transfer(msg.sender, address(this), tokenId);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
    }

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
