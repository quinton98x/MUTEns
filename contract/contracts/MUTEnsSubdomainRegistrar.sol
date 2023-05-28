pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsSubdomainRegistrar is Ownable {
    MUTEnsRegistry public registry;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function registerSubdomain(string memory subdomain, string memory domain) public {
        require(registry.owner(domain) == msg.sender, "Caller is not the owner of the domain");
        registry.registerDomain(subdomain, "", address(this));
    }
}

