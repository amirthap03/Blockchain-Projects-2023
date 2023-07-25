// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaccineTracking {
    
    struct Vaccine {
        string vaccineName;
        string manufacturer;
        uint256 lotNumber;
        address owner;
    }
    
    mapping (uint256 => Vaccine) vaccines;
    uint256 public vaccineCount;
    
    event vaccineAdded(
        uint256 indexed id,
        string vaccineName,
        string manufacturer,
        uint256 lotNumber,
        address owner
    );
    
    event vaccineTransferred(
        uint256 indexed id,
        address from,
        address to
    );
    
    function addVaccine(string memory _vaccineName, string memory _manufacturer, uint256 _lotNumber) public {
        vaccineCount++;
        vaccines[vaccineCount] = Vaccine(_vaccineName, _manufacturer, _lotNumber, msg.sender);
        emit vaccineAdded(vaccineCount, _vaccineName, _manufacturer, _lotNumber, msg.sender);
    }
    
    function getVaccineDetails(uint256 _id) public view returns(string memory, string memory, uint256, address) {
        Vaccine memory vaccine = vaccines[_id];
        return (vaccine.vaccineName, vaccine.manufacturer, vaccine.lotNumber, vaccine.owner);
    }
    
    function transferVaccineOwnership(uint256 _id, address _newOwner) public {
        Vaccine storage vaccine = vaccines[_id];
        require(msg.sender == vaccine.owner, "Only the current owner can transfer ownership");
        require(_newOwner != address(0), "Invalid new owner address");
        vaccine.owner = _newOwner;
        emit vaccineTransferred(_id, msg.sender, _newOwner);
    }
    
}
