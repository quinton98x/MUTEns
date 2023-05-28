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
        require(domains[domain].owner == address(0), "Domain already registered");
        uint256 tokenId = totalSupply() + 1; // Increment tokenId for each new domain
        _mint(_msgSender(), tokenId); // Mint new NFT for the domain
        domains[domain] = Domain(_msgSender(), tokenId, muteAddress, resolver);
        emit DomainRegistered(domain, _msgSender(), tokenId, muteAddress, resolver);
    }

    function transferDomain(string memory domain, address newOwner) external onlyDomainOwner(domain) {
        require(newOwner != address(0), "New owner address cannot be 0");
        _transfer(_msgSender(), newOwner, domains[domain].tokenId); // Transfer NFT ownership
        domains[domain].owner = newOwner;
        emit DomainTransferred(domain, newOwner);
    }
}
