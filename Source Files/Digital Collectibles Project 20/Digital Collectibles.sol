// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Collectibles {
    // Owner of the contract
    address public owner;
    
    // Number of collectibles created so far
    uint256 public totalCollectibles;
    
    // Mapping of collectibles to their owners
    mapping(uint256 => address) public collectibleToOwner;
    
    // Event that is emitted when a new collectible is created
    event NewCollectible(uint256 indexed tokenId, address indexed owner);
    
    // Constructor function that sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }
    
    // Function that allows the owner of the contract to create a new collectible
    function createCollectible(address _owner) public returns (uint256) {
        require(msg.sender == owner, "Only the owner of the contract can create new collectibles.");
        uint256 tokenId = totalCollectibles;
        collectibleToOwner[tokenId] = _owner;
        totalCollectibles++;
        emit NewCollectible(tokenId, _owner);
        return tokenId;
    }
    
    // Function that allows the owner of a collectible to transfer it to another address
    function transferCollectible(uint256 tokenId, address newOwner) public {
        require(msg.sender == collectibleToOwner[tokenId], "Only the owner of the collectible can transfer it.");
        collectibleToOwner[tokenId] = newOwner;
    }
}
