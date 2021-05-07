pragma solidity 0.8.4;

contract Swappair {

    address[]memory path = new address [](2)
    path[0]= NFT1
    path[1]= NFT2 

    function createNFTMarket( NFTA, NFTB)
        external
        returns (address pair)
    {
        require(NFTA != NFTB, "Identical NFTs");
    }
}
