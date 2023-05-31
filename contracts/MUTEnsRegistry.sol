pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MUTEnsRegistry is Ownable {
    struct Domain {
        address owner;
        uint256 tokenId;
        string muteAddress;
        address resolver;
        uint256 expiry;
    }

    mapping(string => Domain) public domains;

    uint256 private _currentTokenId = 0;

    event DomainRegistered(string domain, string muteAddress, address owner, address resolver, uint256 expiry);
    event DomainRenewed(string domain, uint256 newExpiry);
    event DomainTransferred(string domain, address from, address to);

    function registerDomain(string memory domain, string memory muteAddress, address resolver) public onlyOwner {
        uint256 newTokenId = _currentTokenId + 1; // Increment tokenId for each new domain
        _currentTokenId = newTokenId;

        uint256 expiry = block.timestamp + 31536000; // Set domain to expire in 1 year

        domains[domain] = Domain(msg.sender, newTokenId, muteAddress, resolver, expiry);

        emit DomainRegistered(domain, muteAddress, msg.sender, resolver, expiry);
    }

    function renewDomain(string memory domain) public {
        require(msg.sender == domains[domain].owner, "Only the owner can renew the domain");

        domains[domain].expiry += 31536000; // Extend the domain's expiry by 1 year

        emit DomainRenewed(domain, domains[domain].expiry);
    }

    function transferDomain(string memory domain, address to) public {
        require(msg.sender == domains[domain].owner, "Only the owner can transfer the domain");

        domains[domain].owner = to;

        emit DomainTransferred(domain, msg.sender, to);
    }
}
