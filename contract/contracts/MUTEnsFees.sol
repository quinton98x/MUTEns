
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MUTEnsFees {
    using SafeERC20 for IERC20;
    IERC20 public muteToken;

    uint256 public registrationFee = 0.001 ether;

    constructor() {
        muteToken = IERC20(0xa49d7499271ae71cd8ab9ac515e6694c755d400c);
    }

    function getRegistrationFee() public view returns (uint256) {
        return registrationFee;
    }

    function getMuteBalance(address account) internal view returns (uint256) {
        return muteToken.balanceOf(account);
    }
}
