// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    mapping (bytes32 => uint256) public votes;
    mapping (address => bool) public hasVoted;
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action.");
        _;
    }
    
    function vote(bytes32 /*encryptedBiometricData*/, bytes32 candidate) public {
    // function code here
        votes[candidate] += 1;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, candidate);
    }
    
    function addCandidate(bytes32 candidate) public onlyAdmin {
        require(votes[candidate] == 0, "This candidate already exists.");
        votes[candidate] = 0;
        emit CandidateAdded(candidate);
    }
    
    function changeAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
        emit AdminChanged(newAdmin);
    }
    
    event Voted(address voter, bytes32 candidate);
    event CandidateAdded(bytes32 candidate);
    event AdminChanged(address newAdmin);
}
