// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DrugTracking {
    // Structure for drug details
    struct Drug {
        string name;
        string batchNumber;
        uint256 quantity;
        string manufacturer;
        string distributor;
        string retailer;
        address owner;
    }

    // List of drugs
    mapping(uint256 => Drug) public drugs;

    // Number of drugs
    uint256 public drugCount;

    // Event for drug creation
    event drugCreated(
        uint256 indexed id,
        string name,
        string batchNumber,
        uint256 quantity,
        string manufacturer,
        string distributor,
        string retailer,
        address owner
    );

    // Event for drug ownership transfer
    event drugTransferred(
        uint256 indexed id,
        address from,
        address to
    );

    // Function to add drug
    function addDrug(
        string memory _name,
        string memory _batchNumber,
        uint256 _quantity,
        string memory _manufacturer,
        string memory _distributor,
        string memory _retailer
    ) public {
        drugCount++;
        drugs[drugCount] = Drug(
            _name,
            _batchNumber,
            _quantity,
            _manufacturer,
            _distributor,
            _retailer,
            msg.sender
        );
        emit drugCreated(
            drugCount,
            _name,
            _batchNumber,
            _quantity,
            _manufacturer,
            _distributor,
            _retailer,
            msg.sender
        );
    }

    // Function to get drug details
    function getDrug(uint256 _id)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            string memory,
            string memory,
            string memory,
            address
        )
    {
        Drug memory drug = drugs[_id];
        return (
            drug.name,
            drug.batchNumber,
            drug.quantity,
            drug.manufacturer,
            drug.distributor,
            drug.retailer,
            drug.owner
        );
    }

    // Function to transfer drug ownership
    function transferDrugOwnership(uint256 _id, address _newOwner) public {
        Drug storage drug = drugs[_id];
        require(msg.sender == drug.owner, "Only the current owner can transfer ownership");
        require(_newOwner != address(0), "Invalid new owner address");
        drug.owner = _newOwner;
        emit drugTransferred(_id, msg.sender, _newOwner);
    }
}
