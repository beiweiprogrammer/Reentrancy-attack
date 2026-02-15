// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReentrancyGuard{
    bool internal locked = false;

    modifier noReentrant(){
        require (!locked,"No re-entrancy");
        locked = true;
        _;
        locked = false;
    }
}

contract SecureVault is ReentrancyGuard{
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external noReentrant {
        require(balances[msg.sender] > 0, "Insufficient balance");
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}