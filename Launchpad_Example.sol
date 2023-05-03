// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Launchpad is Ownable, ReentrancyGuard {

    uint256 public totalCollected;

    uint256 public bronzePrice = 0.1 ether;
    uint256 public silverPrice = 0.2 ether;
    uint256 public goldPrice = 0.3 ether;

    struct Holder {
        uint256 invested;
        uint256 bronzeOwned;
        uint256 silverOwned;
        uint256 goldOwned;
    }

    mapping(address => Holder) public holders;

    event NewInvestment (
        string indexed investmentType,
        uint256 amount
    );

    event PricesSet (
        uint256 newBronzePrice,
        uint256 newSilverPrice, 
        uint256 newGoldPrice
    );

    function investBronze() public payable {
        require(msg.value == bronzePrice, "Exceeded minimal insvetment value");
        totalCollected += msg.value;
        holders[msg.sender].invested += msg.value;
        holders[msg.sender].bronzeOwned += 1;
        totalCollected += msg.value;
        emit NewInvestment("Bronze", msg.value);
    }

    function investSilver() public payable {
        require(msg.value == silverPrice, "Exceeded minimal insvetment value");
        totalCollected += msg.value;
        holders[msg.sender].invested += msg.value;
        holders[msg.sender].silverOwned += 1;
        totalCollected += msg.value;
        emit NewInvestment("Silver", msg.value);
    }

    function investGold() public payable {
        require(msg.value == goldPrice, "Exceeded minimal insvetment value");
        totalCollected += msg.value;
        holders[msg.sender].invested += msg.value;
        holders[msg.sender].goldOwned += 1;
        totalCollected += msg.value;
        emit NewInvestment("Gold", msg.value);
    }

    function setNewPrices(uint256 _newBronzePrice, uint256 _newSilverPrice, uint256 _newGoldPrice) public onlyOwner {
        bronzePrice = _newBronzePrice;
        silverPrice = _newSilverPrice;
        goldPrice = _newGoldPrice;
        emit PricesSet(
            bronzePrice,
            silverPrice,
            goldPrice
        );
    }

}