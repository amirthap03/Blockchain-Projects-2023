// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DistributedLedger {
    
    mapping (string => string) private data;
    mapping (address => bool) private nodes;
    
    event DataAdded(string key, string value);
    event NodeAdded(address node);
    
    constructor() {
        nodes[msg.sender] = true;
        emit NodeAdded(msg.sender);
    }
    
    function addData(string memory key, string memory value) public {
        require(nodes[msg.sender] == true, "Only nodes can add data");
        data[key] = value;
        emit DataAdded(key, value);
    }
    
    function getData(string memory key) public view returns (string memory) {
        return data[key];
    }
    
    function addNode(address node) public {
        require(nodes[msg.sender] == true, "Only nodes can add other nodes");
        nodes[node] = true;
        emit NodeAdded(node);
    }
    
    function removeNode(address node) public {
        require(nodes[msg.sender] == true, "Only nodes can remove other nodes");
        nodes[node] = false;
    }
}
