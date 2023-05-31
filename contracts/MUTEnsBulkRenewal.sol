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

    function renewDomains(string[] memory domains) public payable {
        uint256 totalFee = 0;
        for (uint256 i = 0; i < domains.length; i++) {
            totalFee += fees.getRegistrationFee(bytes(domains[i]).length);
        }
        require(msg.value == totalFee, "Renewal fee does not match the required fee");

        for (uint256 i = 0; i < domains.length; i++) {
            registry.renewDomain(domains[i]);
        }
    }
}
