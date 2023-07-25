// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TollFree {
    struct Toll {
        uint256 timestamp;
        string location;
        uint256 amount;
    }
    
    mapping(address => Toll[]) public tolls;
    
    function addToll(string memory _location, uint256 _amount) public {
        Toll memory newToll = Toll({
            timestamp: block.timestamp,
            location: _location,
            amount: _amount
        });
        tolls[msg.sender].push(newToll);
    }
    
    function getTolls(address _owner) public view returns (Toll[] memory) {
        return tolls[_owner];
    }
    
    function updateToll(uint256 _index, string memory _location, uint256 _amount) public {
        require(_index < tolls[msg.sender].length, "Index out of range");
        Toll storage tollToUpdate = tolls[msg.sender][_index];
        tollToUpdate.location = _location;
        tollToUpdate.amount = _amount;
    }
}
