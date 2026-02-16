# Reentrancy Lab (Foundry)
This is a minimal lab foucsing on demonstrating Reentrancy Attack, CEI fix and ReentrancyGuard protection

This project demonstrates:
- a volunerable vault contract
- a vault contract protected by CEI fix.
- a vault contract protected by CEI fix and ReentrancyGuard.
## Project Structure
```
src/
  ├── VulnerableVault.sol
  ├── CEIVault.sol
  ├── SafeVault.sol
  ├── ReentrancyAttacker.sol

test/
  ├── Reentrancy.t.sol
```
## Setup

Install dependencies:

```bash
forge install
forge test -vvv
```
## Reentrancy Attack Flow
- attacker deposites 1 ETH
- attacker try to withdraw 1 ETH
- attacker withdraws again when withdraw successful
- keep doing this until there is no sufficient balance
## Protection Mechanism
### CEI
We deduct balance before the withdraw was successful
### ReentrancyGuard
We ues the state to check whether the withdraw process really end.
## Tech Stack

- Solidity ^0.8.20
- Foundry
## Lessons Learned
- Always update state before external call
- Use Reenetrancy guard as security
