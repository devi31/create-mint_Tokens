// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeviToken {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

// notify external users when something happens in a contract
    event Transfer(address indexed source, address indexed destination, uint256 amount);
    event Burn(address indexed source, uint256 amount);
    event Mint(address indexed destination, uint256 amount);

    address public owner;
// only contract owner can mint tokens
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can mint tokens");
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    function minttoken(address _destination, uint256 _amount) public onlyOwner {
        require(_destination != address(0), "Invalid address");
        balanceOf[_destination] += _amount;
        totalSupply += _amount;
        emit Mint(_destination, _amount);
    }

    function burntoken(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Burn(msg.sender, _amount);
    }

    function transfertoken(address _destination, uint256 _amount) public {
        require(_destination != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");

        balanceOf[msg.sender] -= _amount;
        balanceOf[_destination] += _amount;

        emit Transfer(msg.sender, _destination, _amount);
    }
}
