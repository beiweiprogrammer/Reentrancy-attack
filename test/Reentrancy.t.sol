// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.20;
// import "forge-std/Test.sol";
// import "../src/VulnerableVault.sol";
// import "../src/ReentrancyAttacker.sol";
// contract ReentrancyTest is Test
// {
//     VulnerableVault public vault;
//     ReentrancyAttacker public attacker;

//     address victim = address(1);

//     function setUp() public {
//         vault = new VulnerableVault();
//         attacker = new ReentrancyAttacker(address(vault), 1 ether);
//         vm.deal(victim, 10 ether);
//         vm.prank(victim);
//         vault.deposit{value: 10 ether}();
//         vm.deal(address(attacker), 1 ether);
    
//     }
//     // function testWithdraw() public {
//     //     vm.prank(victim);
//     //     vault.withdraw(1 ether);
//     //     assertEq(vault.balances(victim), 9 ether);}
//     function testReentrancyAttack() public {
//         attacker.attack{value: 1 ether}();
//         assertEq(vault.getBalance(), 0);
//         assertEq(address(attacker).balance, 11 ether);



//      }
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";
import "../src/ReentrancyAttacker.sol";
import "../src/SecureVaultCEI.sol";
import "../src/CEIAttacker.sol";
import "../src/SecureVaultGuard.sol";
import "../src/Reentrancyguard_attacker.sol";
contract ReentrancyTest is Test {
    VulnerableVault public vulnerableVault;
    ReentrancyAttacker public attack;
    CEIVulnerableVault public ceiVulnerableVault;
    CEIAttacker public ceiAttack;
    SecureVault public secureVault;
    SecureCEIAttacker public secureCEIAttack;

    address victim = address(1);

    function setUp() public {
        vulnerableVault = new VulnerableVault();
        attack = new ReentrancyAttacker(address(vulnerableVault), 1 ether);
        ceiVulnerableVault = new CEIVulnerableVault();
        ceiAttack = new CEIAttacker(address(ceiVulnerableVault), 1 ether);
        vm.deal(victim, 10 ether);
        vm.prank(victim);
        vulnerableVault.deposit{value: 10 ether}();
        vm.deal(victim, 10 ether);
        vm.prank(victim);
        ceiVulnerableVault.deposit{value: 10 ether}();
        vm.deal(address(ceiAttack), 1 ether);
        secureVault = new SecureVault();
        secureCEIAttack = new SecureCEIAttacker(address(secureVault), 1 ether);
        vm.deal(victim, 10 ether);
        vm.prank(victim);
        secureVault.deposit{value: 10 ether}();
        vm.deal(address(secureCEIAttack), 1 ether);
    }

    function testReentrancyAttack() public {
        assertEq(vulnerableVault.getBalance(), 10 ether);
        attack.attack{value: 1 ether}();
        assertEq(vulnerableVault.getBalance(), 0);
        assertEq(address(attack).balance, 11 ether);
    }

    function testCEIAttack() public {
        assertEq(ceiVulnerableVault.getBalance(), 10 ether);
        vm.expectRevert();
        ceiAttack.attack{value: 1 ether}();

        
    }
    function testSecureCEIAttack() public {
        assertEq(secureVault.getBalance(), 10 ether);
        vm.expectRevert();
        secureCEIAttack.attack{value: 1 ether}();

        
    }
}