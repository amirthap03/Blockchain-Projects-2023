// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MediaRights {
    // Struct for storing digital asset details
    struct DigitalAsset {
        string name;
        address owner;
        bool exists;
    }
    
    // Mapping to store all digital assets
    mapping(uint256 => DigitalAsset) public digitalAssets;
    
    // Event to emit when a digital asset is created
    event DigitalAssetCreated(uint256 indexed id, string name, address indexed owner);
    
    // Function to create a new digital asset
    function createDigitalAsset(uint256 id, string memory name) public {
        require(!digitalAssets[id].exists, "Digital asset with this ID already exists.");
        digitalAssets[id] = DigitalAsset(name, msg.sender, true);
        emit DigitalAssetCreated(id, name, msg.sender);
    }
    
    // Function to transfer ownership of a digital asset
    function transferOwnership(uint256 id, address newOwner) public {
        require(digitalAssets[id].exists, "Digital asset with this ID does not exist.");
        require(digitalAssets[id].owner == msg.sender, "Only the current owner can transfer ownership.");
        digitalAssets[id].owner = newOwner;
    }
    
    // Function to delete a digital asset
    function deleteDigitalAsset(uint256 id) public {
        require(digitalAssets[id].exists, "Digital asset with this ID does not exist.");
        require(digitalAssets[id].owner == msg.sender, "Only the owner can delete a digital asset.");
        delete digitalAssets[id];
    }
}
