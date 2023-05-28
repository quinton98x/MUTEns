pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MUTEnsRegistry.sol";

contract MUTEnsPublicResolver is Ownable {
    MUTEnsRegistry public registry;

    mapping(string => address) public addr;
    mapping(string => string) public name;
    mapping(string => mapping(string => string)) public text;
    mapping(string => bytes) public pubkey;
    mapping(string => string) public contenthash;
    mapping(string => string) public url;
    mapping(string => string) public email;
    mapping(string => string) public avatar;

    constructor(MUTEnsRegistry _registry) {
        registry = _registry;
    }

    modifier onlyNodeOwner(string memory node) {
        require(registry.owner(node) == msg.sender, "Caller is not the owner of the domain");
        _;
    }

    function setAddr(string memory node, address a) public onlyNodeOwner(node) {
        addr[node] = a;
    }

    function setName(string memory node, string memory _name) public onlyNodeOwner(node) {
        name[node] = _name;
    }

    function setText(string memory node, string memory key, string memory value) public onlyNodeOwner(node) {
        text[node][key] = value;
    }

    function setPubkey(string memory node, bytes memory _pubkey) public onlyNodeOwner(node) {
        pubkey[node] = _pubkey;
    }

    function setContenthash(string memory node, string memory _contenthash) public onlyNodeOwner(node) {
        contenthash[node] = _contenthash;
    }

    function setURL(string memory node, string memory _url) public onlyNodeOwner(node) {
        url[node] = _url;
    }

    function setEmail(string memory node, string memory _email) public onlyNodeOwner(node) {
        email[node] = _email;
    }

    function setAvatar(string memory node, string memory _avatar) public onlyNodeOwner(node) {
        avatar[node] = _avatar;
    }

    function getAddr(string memory node) public view returns (address) {
        return addr[node];
    }

    function getName(string memory node) public view returns (string memory) {
        return name[node];
    }

    function getText(string memory node, string memory key) public view returns (string memory) {
        return text[node][key];
    }

    function getPubkey(string memory node) public view returns (bytes memory) {
        return pubkey[node];
    }

    function getContenthash(string memory node) public view returns (string memory) {
        return contenthash[node];
    }

    function getURL(string memory node) public view returns (string memory) {
        return url[node];
    }

    function getEmail(string memory node) public view returns (string memory) {
        return email[node];
    }

    function getAvatar(string memory node) public view returns (string memory) {
        return avatar[node];
    }
}

