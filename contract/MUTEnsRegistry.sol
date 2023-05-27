
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
    modifier authorised(string memory domain) {
        address owner = domains[domain].owner;
        require(owner == _msgSender() || isApprovedForAll(owner, _msgSender()), "Caller is not the owner");
        _;
    }

    function registerDomain(string memory domain, string memory muteAddress, address resolver) external authorised(domain) {
        // Registration logic here...
    }

    function transferDomain(string memory domain, address newOwner) external authorised(domain) {
        // Transfer logic here...
    }

    function setResolver(string memory domain, address resolver) public authorised(domain) {
        domains[domain].resolver = resolver;
        emit DomainRegistered(domain, domains[domain].owner, domains[domain].tokenId, domains[domain].muteAddress, resolver);
    }

    function owner(string memory domain) public view returns (address) {
        return domains[domain].owner;
    }

    function resolver(string memory domain) public view returns (address) {
        return domains[domain].resolver;
    }
}
