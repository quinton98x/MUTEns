pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsTransfer is Ownable {
    MUTEnsRegistry public registry;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function transferDomain(string memory domain, address to) public {
        (address domainOwner,,,,) = registry.domains(domain);
        require(domainOwner == msg.sender, "Caller is not the owner of the domain");
        registry.transferDomain(domain, to);
    }
}
