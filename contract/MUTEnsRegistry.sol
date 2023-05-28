pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract MUTEnsRegistry is ERC721, Ownable, Pausable {
    struct Domain {
        address owner;
        uint256 tokenId;
        string muteAddress;
        address resolver;
    }

    mapping(string => Domain) public domains;
    mapping(address => bool) public hasClaimedFreeDomain;

    event DomainRegistered(string domain, address indexed owner, uint256 tokenId, string muteAddress, address resolver);
    event DomainTransferred(string domain, address indexed newOwner);

    constructor() ERC721("MUTE Domain Name Service", "MUTEns") {}

    // Permits modifications only by the owner of the specified node.
    modifier onlyDomainOwner(string memory domain) {
        require(domains[domain].owner == _msgSender(), "Caller is not the owner");
        _;
    }

    function registerDomain(string memory domain, string memory muteAddress, address resolver) external onlyDomainOwner(domain) {
        // Registration logic here...
        domains[domain] = Domain(_msgSender(), domains[domain].tokenId, muteAddress, resolver);
        emit DomainRegistered(domain, _msgSender(), domains[domain].tokenId, muteAddress, resolver);
    }

    function transferDomain(string memory domain, address newOwner) external onlyDomainOwner(domain) {
        // Transfer logic here...
        domains[domain].owner = newOwner;
        emit DomainTransferred(domain, newOwner);
    }
}

