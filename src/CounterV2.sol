// contracts/MyContractV2.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Counter.sol";

contract CounterV2 is Counter {
    function decrement() public {
        value -= 1;
    }
}
