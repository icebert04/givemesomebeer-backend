// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract BeerPortal {
    uint256 totalBeer;

    address payable public owner;

    event NewBeer(
        address indexed from,
        uint256 timestamp,
        string message,
        string name
    );

    constructor() payable {
        console.log("Smart Contract Compiled");
        owner = payable(msg.sender);
    }

    struct Beer {
        address giver;
        string message;
        string name;
        uint256 timestamp;
    }

    Beer[] beer;

    function getAllBeer() public view returns (Beer[] memory) {
        return beer;
    }

    function getTotalBeer() public view returns (uint256) {
        console.log("We have %d total beer recieved ", totalBeer);
        return totalBeer;
    }

    function buyBeer(
        string memory _message,
        string memory _name,
        uint256 _payAmount
    ) public payable {
        uint256 cost = 0.001 ether;
        require(_payAmount <= cost, "Insufficient Ether provided");

        totalBeer += 1;
        console.log("%s has just sent a beer!", msg.sender);

        beer.push(Beer(msg.sender, _message, _name, block.timestamp));

        (bool success, ) = owner.call{value: _payAmount}("");
        require(success, "Failed to send money");

        emit NewBeer(msg.sender, block.timestamp, _message, _name);
    }
}
