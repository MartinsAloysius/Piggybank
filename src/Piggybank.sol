// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Piggybank {
    uint256 public totalDeposits;
    address public owner;
    uint256 public penaltyPool;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public goals;
    mapping(address => uint256) public unlockTime;


    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed sender, uint256 amount);
    event PenaltyCollected(address indexed user, uint256 amount);
    event GoalSet(address indexed user, uint256 goalAmount);
    event LockPeriodSet(address indexed user, uint256 unlockTimestamp);


    error Unauthorized();
    error InsufficientBalance();
    error GoalNotSet();
    error LockPeriodNotSet();
    error InvalidAmount();


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }


    function deposit () external payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
         emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(goals[msg.sender] > 0, "Set a goal first");
        require(unlockTime[msg.sender] > 0, "Set lock period first");

    // NEW: Check unlock time and goal
        bool isUnlocked = block.timestamp >= unlockTime[msg.sender];
        bool goalReached = balances[msg.sender] >= goals[msg.sender];

        uint256 finalAmount = amount;  // Amount user will receive

    // NEW: Apply penalty if conditions not met
    if (!isUnlocked || !goalReached) {
        uint256 penalty = (amount * 2) / 100;  // 2% penalty
        finalAmount = amount - penalty;
        penaltyPool += penalty;
        emit PenaltyCollected (msg.sender, penalty);
        // Penalty stays in contract or goes to owner
    }

    // Update state (deduct full amount from balance)
    balances[msg.sender] -= amount;
    totalDeposits -= amount;

    // Transfer final amount (after penalty)
    (bool sent, ) = payable(msg.sender).call{value: finalAmount}("");
    require(sent, "Transfer failed");

    emit Withdrawal(msg.sender, finalAmount);
}

       
   function setGoal(uint256 goalAmount1) external {
    require(goalAmount1 > 0, "Goal must be > 0");
    goals[msg.sender] = goalAmount1;
}

     
    function setLockPeriod(uint256 _days1) external {
        require(_days1 > 0, "Lock period must be > 0 days");
        unlockTime[msg.sender] = block.timestamp + (_days1 * 1 days);


    }

    
   

}
