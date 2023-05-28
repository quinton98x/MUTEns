pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsTransfer is Ownable {
    MUTEnsRegistry public registry;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function transfer(string memory domain, address newOwner) public {
        require(registry.owner(domain) == msg.sender, "Caller is not the owner of the domain");
        registry.transferDomain(domain, newOwner);
    }
}

