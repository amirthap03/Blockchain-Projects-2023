// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transportation {
    // Structure for highway details
    struct Highway {
        string name;
        uint256 length;
        uint256 toll;
        address owner;
    }

    // List of highways
    mapping(uint256 => Highway) public highways;

    // Number of highways
    uint256 public highwayCount;

    // Event for highway creation
    event highwayCreated(
        uint256 indexed id,
        string name,
        uint256 length,
        uint256 toll,
        address owner
    );

    // Event for highway ownership transfer
    event highwayTransferred(
        uint256 indexed id,
        address from,
        address to
    );

    // Function to add highway
    function addHighway(
        string memory _name,
        uint256 _length,
        uint256 _toll
    ) public {
        highwayCount++;
        highways[highwayCount] = Highway(
            _name,
            _length,
            _toll,
            msg.sender
        );
        emit highwayCreated(
            highwayCount,
            _name,
            _length,
            _toll,
            msg.sender
        );
    }

    // Function to get highway details
    function getHighway(uint256 _id)
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            address
        )
    {
        Highway memory highway = highways[_id];
        return (highway.name, highway.length, highway.toll, highway.owner);
    }

    // Function to transfer highway ownership
    function transferHighwayOwnership(uint256 _id, address _newOwner) public {
        Highway storage highway = highways[_id];
        require(msg.sender == highway.owner, "Only the current owner can transfer ownership");
        require(_newOwner != address(0), "Invalid new owner address");
        highway.owner = _newOwner;
        emit highwayTransferred(_id, msg.sender, _newOwner);
    }
}
