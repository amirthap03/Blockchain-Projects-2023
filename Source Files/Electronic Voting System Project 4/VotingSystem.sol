// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    // Structure for candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Structure for voter
    struct Voter {
        bool voted;
        uint voteIndex;
    }

    // Owner of the contract
    address public owner;

    // List of candidates
    mapping(uint => Candidate) public candidates;

    // Number of candidates
    uint public candidatesCount;

    // List of voters
    mapping(address => Voter) public voters;

    // Event for voting
    event votedEvent (
        uint indexed _candidateId
    );

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Function to add candidate
    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidate");
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to vote for candidate
    function vote(uint _candidateId) public {
        require(!voters[msg.sender].voted, "Already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");
        voters[msg.sender].voted = true;
        voters[msg.sender].voteIndex = _candidateId;
        candidates[_candidateId].voteCount ++;
        emit votedEvent(_candidateId);
    }

    // Function to get candidate details
    function getCandidate(uint _candidateId) public view returns (string memory) {
        return candidates[_candidateId].name;
    }

    // Function to get total votes for candidate
    function getTotalVotes(uint _candidateId) public view returns (uint) {
        return candidates[_candidateId].voteCount;
    }

    // Function to get total number of candidates
    function getCandidatesCount() public view returns (uint) {
        return candidatesCount;
    }
}
