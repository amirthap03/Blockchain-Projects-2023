// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract HealthRecords {
    struct Record {
        string data;
        address owner;
    }

    mapping(uint256 => Record) private records;
    mapping(address => mapping(uint256 => bool)) private recordOwners;

    event RecordCreated(uint256 indexed recordId, string data, address indexed owner);
    event RecordTransferred(uint256 indexed recordId, address indexed from, address indexed to);

    function createRecord(uint256 recordId, string memory data) public {
        require(!recordOwners[msg.sender][recordId], "Record with same ID already exists and owned by the sender");
        records[recordId] = Record(data, msg.sender);
        recordOwners[msg.sender][recordId] = true;
        emit RecordCreated(recordId, data, msg.sender);
    }

    function transferRecordOwnership(uint256 recordId, address newOwner) public {
        require(recordOwners[msg.sender][recordId], "Sender does not own the record");
        records[recordId].owner = newOwner;
        recordOwners[msg.sender][recordId] = false;
        recordOwners[newOwner][recordId] = true;
        emit RecordTransferred(recordId, msg.sender, newOwner);
    }

    function getRecord(uint256 recordId) public view returns (string memory data, address owner) {
        Record storage record = records[recordId];
        require(record.owner != address(0), "Record does not exist");
        return (record.data, record.owner);
    }
}
