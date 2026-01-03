// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Script.sol";
import "../src/Piggybank.sol";

contract DeployPiggybank is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new Piggybank();
        vm.stopBroadcast();
    }


}