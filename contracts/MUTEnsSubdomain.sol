pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsSubdomains is Ownable {
    MUTEnsRegistry public registry;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function registerSubdomain(string memory domain, string memory subdomain, address owner, address resolver) public onlyOwner {
        string memory fullDomain = string(abi.encodePacked(subdomain, ".", domain));
        registry.registerDomain(fullDomain, "", resolver);
        registry.transferDomain(fullDomain, owner);
    }
}
