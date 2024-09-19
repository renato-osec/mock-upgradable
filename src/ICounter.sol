/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICounter {
    function increment() external;
    function value() external returns(uint256);
}
