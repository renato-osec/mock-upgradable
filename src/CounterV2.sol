// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./ICounterV2.sol";

contract CounterV2 is Initializable, ICounterV2 {
    uint256 public value;
    address public immutable endpoint = address(0x4141);

    //init func
    function initialize(uint256 _value) public initializer {
        value = _value;
    }

    function increment() public {
        value += 1;
    }

    function decrement() public {
        value += 1;
    }
}
