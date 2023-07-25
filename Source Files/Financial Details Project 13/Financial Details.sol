// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MicroFinancing {
    
    struct FinancingDetails {
        string documentHash;
        uint256 amount;
        string borrowerName;
        string lenderName;
    }
    
    mapping(uint256 => FinancingDetails) public financingDetails;
    uint256 public financingCount = 0;
    
    function addFinancingDetails(string memory _documentHash, uint256 _amount, string memory _borrowerName, string memory _lenderName) public {
        financingDetails[financingCount] = FinancingDetails(_documentHash, _amount, _borrowerName, _lenderName);
        financingCount++;
    }
    
    function getFinancingDetails(uint256 _index) public view returns (string memory, uint256, string memory, string memory) {
        return (financingDetails[_index].documentHash, financingDetails[_index].amount, financingDetails[_index].borrowerName, financingDetails[_index].lenderName);
    }
    
    function updateFinancingDetails(uint256 _index, string memory _documentHash, uint256 _amount, string memory _borrowerName, string memory _lenderName) public {
        financingDetails[_index] = FinancingDetails(_documentHash, _amount, _borrowerName, _lenderName);
    }
    
}
