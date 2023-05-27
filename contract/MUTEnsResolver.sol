
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MUTEnsResolver is Ownable {
    mapping(string => address) public addr;

    event AddrChanged(string indexed node, address a);

    function setAddr(string memory node, address a) public onlyOwner {
        addr[node] = a;
        emit AddrChanged(node, a);
    }

    function getAddr(string memory node) public view returns (address) {
        return addr[node];
    }
}
