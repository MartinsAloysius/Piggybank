// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/Piggybank.sol";

contract PiggybankTest is Test {
    Piggybank piggybank;
    address owner = address(1);
    address user1 = address(2);
    address user2 = address(3);

   
function setUp() public {
    vm.prank(owner);  // ← Next action will be as "owner"
    piggybank = new Piggybank();  // ← NOW owner deploys the contract ✅

    vm.deal(user1, 10 ether);  // ✅ Give user1 10 fake ETH
    vm.deal(user2, 10 ether);  // ✅ Give user2 10 fake ETH
}

function testDeposit() public {
    // Arrange: user1 starts with 10 ETH (from setUp)
    
    // Act: user1 deposits 5 ETH
    vm.prank(user1);  // Next call is from user1
    piggybank.deposit{value: 5 ether}();
    
    // Assert: Check the results
    assertEq(piggybank.balances(user1), 5 ether);  // user1's balance should be 5 ETH
    assertEq(piggybank.totalDeposits(), 5 ether);  // total should be 5 ETH
    assertEq(address(piggybank).balance, 5 ether);  // contract should hold 5 ETH
}

function testDepositRevertsOnZero() public {
    vm.prank(user1);
    vm.expectRevert("Deposit must be greater than 0");
    piggybank.deposit{value: 0}();
}

function testSetGoal() public {
        vm.prank(user1);
        piggybank.setGoal(10 ether);
        assertEq(piggybank.goals(user1), 10 ether);
    }

    function testSetGoalRevertsOnZero() public {
        vm.prank(user1);
        vm.expectRevert("Goal must be > 0");
        piggybank.setGoal(0);
    }

    function testSetLockPeriod() public {
        uint256 lockDays = 7;


        vm.prank(user1);
        piggybank.setLockPeriod(lockDays); // 7 days
       uint256 expectedUnlockTime = block.timestamp + (lockDays * 1 days);
        assertEq(piggybank.unlockTime(user1), expectedUnlockTime);
    }

    function testSetLockPeriodRevertsOnZero() public {
        vm.prank(user1);
        vm.expectRevert("Lock period must be > 0 days");
        piggybank.setLockPeriod(0);
    }

    function testWithdrawAfterUnlockAndGoalReached() public {
        vm.prank(user1);
        piggybank.deposit{value: 10 ether}();
        vm.prank(user1);
        piggybank.setGoal(10 ether);
        vm.prank(user1);
        piggybank.setLockPeriod(10); // 1 day

        // Fast forward time by 2 days
        vm.warp(block.timestamp + 10 days);

        vm.prank(user1);
        piggybank.withdraw(10 ether);

        assertEq(piggybank.balances(user1), 0);
        assertEq(address(piggybank).balance, 0);
    }

    function testWithdrawWithPenalty() public {
        vm.prank(user1);
        piggybank.setGoal(10 ether);
        vm.prank(user1);
        piggybank.setLockPeriod(10); // 10 days
        vm.prank(user1);
         piggybank.deposit{value: 5 ether}();
       

        // Fast forward time by 5 days (not enough to unlock)
        vm.warp(block.timestamp + 5 days);

        vm.prank(user1);
        piggybank.withdraw(5 ether);

        // 2% penalty on 5 ether = 0.1 ether
        assertEq(piggybank.balances(user1), 0);
        assertEq(address(piggybank).balance, 0.1 ether); // Penalty remains in contract
    }





}
