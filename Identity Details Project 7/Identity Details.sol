// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityRegistry {
    // Structure for identity details
    struct Identity {
        string name;
        uint256 age;
        string location;
        string governmentId;
    }

    // List of identities
    mapping(address => Identity) public identities;

    // Event for identity creation
    event identityCreated(
        address indexed owner,
        string name,
        uint256 age,
        string location,
        string governmentId
    );

    // Function to create an identity
    function createIdentity(
        string memory _name,
        uint256 _age,
        string memory _location,
        string memory _governmentId
    ) public {
        identities[msg.sender] = Identity(
            _name,
            _age,
            _location,
            _governmentId
        );
        emit identityCreated(msg.sender, _name, _age, _location, _governmentId);
    }

    // Function to get identity details for a given address
    function getIdentity(address _address)
        public
        view
        returns (
            string memory,
            uint256,
            string memory,
            string memory
        )
    {
        Identity memory identity = identities[_address];
        return (
            identity.name,
            identity.age,
            identity.location,
            identity.governmentId
        );
    }
}
