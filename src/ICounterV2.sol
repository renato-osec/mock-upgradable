/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ICounter.sol";

interface ICounterV2 is ICounter {
    function decrement() external;
}
