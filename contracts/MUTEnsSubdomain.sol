pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsSubdomainRegistrar is Ownable, Pausable {
    MUTEnsRegistry public registry;

    event SubdomainCreated(string indexed domain, string subdomain, address indexed owner);

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function createSubdomain(string memory domain, string memory subdomain, address owner) public onlyOwner {
        // Ensure the msg.sender is the owner of the domain
        require(registry.ownerOf(domain) == msg.sender, "Caller is not the owner of the domain");

        // Create the subdomain
        registry.registerSubdomain(domain, subdomain, owner);

        emit SubdomainCreated(domain, subdomain, owner);
    }
}
