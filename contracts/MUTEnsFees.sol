pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MUTEnsFees is Ownable {
    IERC20 public muteCoin;

    constructor() {
        muteCoin = IERC20(0xa49d7499271ae71cd8ab9ac515e6694c755d400c);
    }

    function getRegistrationFee(uint256 length) public view returns (uint256) {
        if (length == 1) {
            return 1 ether;
        } else if (length == 2) {
            return 0.1 ether;
        } else if (length == 3) {
            return 0.01 ether;
        } else {
            return 0.001 ether;
        }
    }

    function isMuteHolder(address _user) public view returns (bool) {
        return muteCoin.balanceOf(_user) > 0;
    }
}
