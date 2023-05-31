pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";
import "./MUTEnsFees.sol";

contract MUTEnsRegistrar is Ownable {
    MUTEnsRegistry public registry;
    MUTEnsFees public fees;

    constructor(MUTEnsRegistry _registry, MUTEnsFees _fees) {
        registry = _registry;
        fees = _fees;
    }

    function register(string memory domain, string memory muteAddress, address resolver) public payable {
        require(msg.value == fees.getRegistrationFee(bytes(domain).length), "Registration fee does not match the required fee");
        registry.registerDomain(domain, muteAddress, resolver);
    }

    function renewDomain(string memory domain) public payable {
        require(msg.value == fees.getRegistrationFee(bytes(domain).length), "Renewal fee does not match the required fee");
        registry.renewDomain(domain);
    }
}
