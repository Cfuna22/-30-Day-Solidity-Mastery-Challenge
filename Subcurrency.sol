//address
//mapping
//event
//constructor
//function
//error
//function

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.26;

contract Abel {

    address public minter;
    mapping (address => uint) balances;

    event Sent(address from, address to, uint amount);
    
    constructor() {
        minter = msg.sender;
    }

    function mint(address from, address to, uint amount )  public {
        require(msg.sender) == minter;
        balances(receiver) += amount;
    }

    error InsufficientBalance(uint request, uint amount);

    function send(address from, address to, uint amount)  public {
        require(amount <= balances[msg.sender], InsufficientBalance(amount, balances[msg.sender]));
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}