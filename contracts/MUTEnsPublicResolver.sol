pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsPublicResolver is Ownable {
    MUTEnsRegistry public registry;

    struct Record {
        address addr;
        string name;
        string text;
        bytes32 pubkey;
        bytes32 contenthash;
        string url;
        string email;
        string avatar;
    }

    mapping(string => Record) public records;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    function setAddr(string memory domain, address _addr) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].addr = _addr;
    }

    function setName(string memory domain, string memory _name) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].name = _name;
    }

    function setText(string memory domain, string memory _text) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].text = _text;
    }

    function setPubkey(string memory domain, bytes32 _pubkey) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].pubkey = _pubkey;
    }

    function setContenthash(string memory domain, bytes32 _contenthash) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].contenthash = _contenthash;
    }

    function setURL(string memory domain, string memory _url) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].url = _url;
    }

    function setEmail(string memory domain, string memory _email) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].email = _email;
    }

    function setAvatar(string memory domain, string memory _avatar) public {
        (address owner,,,,) = registry.domains(domain);
        require(owner == msg.sender, "Caller is not the owner of the domain");
        records[domain].avatar = _avatar;
    }
}
