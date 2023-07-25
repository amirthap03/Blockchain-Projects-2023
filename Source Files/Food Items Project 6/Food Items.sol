// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodAuthentication {
    // Structure for food item details
    struct FoodItem {
        string name;
        string origin;
        uint256 sentTimestamp;
        address owner;
        bool isConsumed;
    }

    // List of food items
    mapping(uint256 => FoodItem) public foodItems;

    // Number of food items
    uint256 public foodItemCount;

    // Event for food item creation
    event foodItemCreated(
        uint256 indexed id,
        string name,
        string origin,
        uint256 sentTimestamp,
        address owner
    );

    // Event for food item consumption
    event foodItemConsumed(
        uint256 indexed id,
        address consumer
    );

    // Function to add food item
    function addFoodItem(
        string memory _name,
        string memory _origin
    ) public {
        foodItemCount++;
        foodItems[foodItemCount] = FoodItem(
            _name,
            _origin,
            block.timestamp,
            msg.sender,
            false
        );
        emit foodItemCreated(
            foodItemCount,
            _name,
            _origin,
            block.timestamp,
            msg.sender
        );
    }

    // Function to get food item details
    function getFoodItem(uint256 _id)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            address,
            bool
        )
    {
        FoodItem memory foodItem = foodItems[_id];
        return (
            foodItem.name,
            foodItem.origin,
            foodItem.sentTimestamp,
            foodItem.owner,
            foodItem.isConsumed
        );
    }

    // Function to consume food item
    function consumeFoodItem(uint256 _id) public {
        FoodItem storage foodItem = foodItems[_id];
        require(msg.sender == foodItem.owner, "Only the owner can consume the food item");
        require(!foodItem.isConsumed, "Food item has already been consumed");
        foodItem.isConsumed = true;
        emit foodItemConsumed(_id, msg.sender);
    }
}
