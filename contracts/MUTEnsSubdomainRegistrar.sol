pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsSubdomainRegistrar is Ownable {
    MUTEnsRegistry public registry;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function registerSubdomain(string memory subdomain, string memory domain, address muteAddress) public {
        require(muteAddress != address(0), "MuteAddress is required");
        (address domainOwner,,,,) = registry.domains(domain);
        require(domainOwner == msg.sender, "Caller is not the owner of the domain");

        string memory muteAddressStr = addressToString(muteAddress);
        string memory subdomainName = string(abi.encodePacked(subdomain, ".", muteAddressStr));
        registry.registerDomain(subdomainName, muteAddressStr, address(this));
    }

    function addressToString(address _address) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_address)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = "0";
        str[1] = "x";
        for (uint256 i = 0; i < 20; i++) {
            str[2 + i * 2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3 + i * 2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }
}
