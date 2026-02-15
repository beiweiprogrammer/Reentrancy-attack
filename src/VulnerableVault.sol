//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/console.sol";
contract VulnerableVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] >= 0, "Insufficient balance");
        (bool success,) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer failed");
        balances[msg.sender] = 0;
    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}
