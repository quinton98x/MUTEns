// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract MuteNameService {
    struct Token {
        address owner;
        string name;
    }

    Token[] public tokens;
    uint256 public totalSupply;
    
    uint256 public constant CHAR_1_FEE = 1 ether;
    uint256 public constant CHAR_2_FEE = 0.1 ether;
    uint256 public constant CHAR_3_FEE = 0.01 ether;
    uint256 public constant DEFAULT_FEE = 0.001 ether;

    constructor() {
        totalSupply = 0;
    }

    function calculateFee(string memory name) internal pure returns (uint256) {
        uint256 length = bytes(name).length;
        if (length == 1) {
            return CHAR_1_FEE;
        } else if (length == 2) {
            return CHAR_2_FEE;
        } else if (length == 3) {
            return CHAR_3_FEE;
        } else {
            return DEFAULT_FEE;
        }
    }

    function mint(string memory name) public payable returns (uint256 tokenId) {
        uint256 fee = calculateFee(name);
        require(msg.value >= fee, "Insufficient funds to mint the domain.");
        
        totalSupply++;
        uint256 newTokenId = totalSupply;
        tokens.push(Token(msg.sender, name));
        
        if (msg.value > fee) {
            // Refund excess payment
            payable(msg.sender).transfer(msg.value - fee);
        }
        
        return newTokenId;
    }

    function transfer(address to, uint256 tokenId) public returns (bool success) {
        require(tokenId <= totalSupply, "Invalid tokenId");
        require(tokens[tokenId - 1].owner == msg.sender, "You do not own this token");
        tokens[tokenId - 1].owner = to;
        return true;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(tokenId <= totalSupply, "Invalid tokenId");
        return tokens[tokenId - 1].owner;
    }

    function tokenName(uint256 tokenId) public view returns (string memory) {
        require(tokenId <= totalSupply, "Invalid tokenId");
        return tokens[tokenId - 1].name;
    }

    function resolveAddress(address addr) public pure returns (string memory) {
        return string(abi.encodePacked(toString(addr), ".mute"));
    }

    // Helper function to convert address to string
    function toString(address addr) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(addr)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory result = new bytes(42);
        result[0] = '0';
        result[1] = 'x';
        for (uint256 i = 0; i < 20; i++) {
            result[i * 2 + 2] = alphabet[uint8(value[i + 12] >> 4)];
            result[i * 2 + 3] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(result);
    }
}
