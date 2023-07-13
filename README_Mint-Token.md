# Create and Mint Token

This project demonstrates how to create your own token on a local HardHat network and to use remix to interact with it.

## Pre-requisites
1. Install metamask 
2. Install npm package

## Description

This project creates a token called DeviToken. 
#### It ensures that the contract owner is able to mint tokens to a provided address and any user can burn and transfer tokens.
The contract has the following properties:A name and symbol,total supply of tokens.Three events: Transfer, Burn, and Mint.
A function called minttoken that mints a new token and assigns it to the address _destination.
A function called burntoken that burns a token from the caller's balance.
A function called transfertoken that transfers a token from the caller's balance to the address _destination.
The code also uses the event keyword to define three events: Transfer, Burn, and Mint. These events are emitted when tokens are transferred, burned, or minted. The events can be listened to by external users to track the movement of tokens in the contract.

This project is an example of a token creation. It creates a token that can be transferred, burned, and minted. 


## Getting Started

#### Configuring local hardhat network

STEP 1: Setting Up Project Structure: Create a project named **any name**. Next, open the project folder on the terminal or simply navigate to that directory and run the following commands:

                  cd <project name>
                  npm init --y

STEP 2: Creating Hardhat Project: Install the Hardhat packages that enable you to run a blockchain server, on the terminal, run the following commands:

                  npm install hardhat

After the installation, run the hardhat command below:
                    
                    npx hardhat

STEP 3: Running Hardhat Server: On completion of the installation, again run this command to spin up the Hardhat blockchain server:


                    npx hardhat node
STEP 4: Configuring Network: open metamask, add network details, with host name as: LocalHost8545, id as:31337.

STEP 6: Importing Accounts: From step 3, copy the first private key for the account zero (0) and paste it import account option. For this project , import 2-3 accounts.

With this one-time process implemented, anytime you spin up your Hardhat blockchain server, your account will be updated with a fresh 10,000 ETH balance.

### Executing Solidity program

To run the program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
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

```
After the successful compilation of the code:
#### Under the environment section, select Inject provider which connects it to the local hardhat network.

Enter the name and symbol of the token and deploy it.

Use the same address to mint the tokens. For burning and transfering of the tokens use can you different accounts, but ensure that they have enough balance(no. of tokens) 

## Authors

Contributors names and contact info

[B Devi](devibattini@gmail.com)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
