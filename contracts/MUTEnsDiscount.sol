pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsDiscount is Ownable {
    IERC20 public muteToken;
    MUTEnsRegistry public registry;

    uint256 public deploymentTime;

    enum Rank {
        Diamond, // 0
        Platinum, // 1
        Gold, // 2
        Silver, // 3
        Bronze, // 4
        Wood // 5
    }

    mapping(address => Rank) public rankOf;

    constructor(IERC20 _muteToken, MUTEnsRegistry _registry) {
        muteToken = _muteToken;
        registry = _registry;
        deploymentTime = block.timestamp;
    }

    function updateRank(address account) public {
        uint256 balance = muteToken.balanceOf(account);
        if (balance >= 100000) {
            rankOf[account] = Rank.Diamond;
        } else if (balance >= 50000) {
            rankOf[account] = Rank.Platinum;
        } else if (balance >= 25000) {
            rankOf[account] = Rank.Gold;
        } else if (balance >= 10000) {
            rankOf[account] = Rank.Silver;
        } else if (balance >= 5000) {
            rankOf[account] = Rank.Bronze;
        } else {
            rankOf[account] = Rank.Wood;
        }
    }

    function mintDomain(string memory domain, string memory muteAddress, address resolver) public {
        updateRank(msg.sender);
        require(bytes(domain).length <= uint256(rankOf[msg.sender]) + 1, "Domain length exceeds your rank limit");
        
        // If the contract has been live for less than a month, only allow wallets with Mute coins to mint domains
        if (block.timestamp < deploymentTime + 30 days) {
            require(muteToken.balanceOf(msg.sender) > 0, "Only wallets with Mute coins can mint domains during the first month");
        }

        registry.registerDomain(domain, muteAddress, resolver);
    }
}
