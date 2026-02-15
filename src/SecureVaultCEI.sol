//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CEIVulnerableVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "Insufficient balance");
        balances[msg.sender] = 0;
        (bool success,) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer failed");
    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}