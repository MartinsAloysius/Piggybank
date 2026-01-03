# Piggybank Smart Contract

A Solidity smart contract that lets users save ETH with goals, time locks, and withdrawal penalties.

## Features

- Set savings goals
- Set lock period
- Make the first deposit to achieve your goals
- Penalty for early withdrawals


## How It Works

Each user can set a savings goal and lock period. If they withdraw before the time passes or before reaching their goal, they pay a 2% penalty.

## Installation

[HOW do I run this locally?]
```bash
# Step 1: Clone
git clone https://github.com/MartinsAloysius/Piggybank-cu.git

# Step 2: Install dependencies
forge install

# Step 3: Run tests
forge test
```

## Usage

[HOW do I interact with it?]

### Set Your Goal
```solidity
setGoal(10 ether)
```

### Set Lock Period
```solidity
setLockPeriod(30) // 30 days
```

### Deposit
```solidity
deposit{value: 1 ether}()
```

### Withdraw
```solidity
withdraw(1 ether)
```

## Testing
```bash
forge test
forge test -vv  # Verbose
```

### Get Sepolia ETH

Need testnet ETH? Get it from these faucets:
- [Alchemy Sepolia Faucet](https://sepoliafaucet.com)
- [Chainlink Faucet](https://faucets.chain.link/sepolia)

## Tech Stacks

- Solidity ^0.8.30 
- Foundry (testing & deployment)
- Sepolia testnet

## Tools

- VS code
- Alchemy
- Metamask
- Etherscan

## Deployment

- **Network:** Sepolia Testnet
- **Chain ID:** 11155111
- **Contract Address:** `0x9806e303cd6b53ebff916b66443b4385badb479f`
- **Etherscan:** [View Contract](https://sepolia.etherscan.io/address/0x9806e303cd6b53ebff916b66443b4385badb479f)


## Security Practices Implemented:

- [x] Checks-Effects-Interactions pattern (prevent reentrancy)
- [x] Input validation on all functions
- [x] Access control with onlyOwner modifier
- [x] SafeMath (Solidity 0.8+ built-in)
- [x] Event emission for transparency
- [x] Emergency pause mechanism
- [x] Formal security audit (future)

## Security Features

- **Reentrancy Protection**: Follows Checks-Effects-Interactions pattern
- **Access Control**: Owner-only functions protected
- **Input Validation**: All inputs validated before processing
- **Event Logging**: All state changes emit events for transparency
- **Penalty Handling**: Penalties collected in pool, withdrawable by owner
- **Safe Math**: Solidity 0.8+ automatic overflow protection

## Known Limitations

- No emergency pause mechanism
- Not formally audited (testnet only)
- Penalties controlled by contract owner


## Future Improvements

- [ ] Add frontend with React
- [ ] Support ERC20 tokens
- [ ] Add milestone rewards

## Author

Your Name - [GitHub](https://github.com/MartinsAloysius) - [Twitter](https://twitter.com/Xterthy3) - [LinkedIn](https://www.linkedin.com/in/martinsaloysius/)

# Piggybank Smart Contract

![Solidity](https://img.shields.io/badge/Solidity-0.8.30-blue)
![Network](https://img.shields.io/badge/Network-Sepolia-orange)
![Chain ID](https://img.shields.io/badge/ChainID-11155111-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

A multi-user savings contract with goals and time locks.
