// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClimateAgreement {
    
    address private owner;
    string public agreementDetails;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }
    
    function addDetails(string memory details) public onlyOwner {
        agreementDetails = details;
    }
    
    function getDetails() public view returns (string memory) {
        return agreementDetails;
    }
    
    function updateDetails(string memory details) public onlyOwner {
        agreementDetails = details;
    }
}
