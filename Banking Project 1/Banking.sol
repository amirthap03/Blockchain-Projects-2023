// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Banking {
    mapping(address => uint256) balances;
    uint256 constant initialBalance = 10000;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdrawal(address indexed withdrawer, uint256 amount);
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);

    constructor() {
        balances[msg.sender] = initialBalance;
    }

    function deposit(uint256 amount) public payable {
        require(amount > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) public {
        require(recipient != address(0), "Invalid recipient address");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
}
