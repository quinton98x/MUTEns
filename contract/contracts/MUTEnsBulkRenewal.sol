pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";
import "./MUTEnsFees.sol";

contract MUTEnsBulkRenewal is Ownable {
    MUTEnsRegistry public registry;
    MUTEnsFees public fees;

    constructor(MUTEnsRegistry _registry, MUTEnsFees _fees) {
        registry = _registry;
        fees = _fees;
    }

    function renew(string[] memory domains) public payable {
        require(msg.value == domains.length * fees.getRegistrationFee(), "Renewal fee does not match the required fee");
        for (uint i = 0; i < domains.length; i++) {
            registry.registerDomain(domains[i], "", address(this));
        }
    }
}

