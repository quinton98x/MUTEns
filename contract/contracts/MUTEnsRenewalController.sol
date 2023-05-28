pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";
import "./MUTEnsFees.sol";

contract MUTEnsRenewalController is Ownable {
    MUTEnsRegistry public registry;
    MUTEnsFees public fees;

    constructor(MUTEnsRegistry _registry, MUTEnsFees _fees) {
        registry = _registry;
        fees = _fees;
    }

    function renew(string memory domain) public payable {
        require(msg.value == fees.getRegistrationFee(), "Renewal fee does not match the required fee");
        registry.registerDomain(domain, "", address(this));
    }
}

