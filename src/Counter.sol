// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./ICounter.sol";

contract Counter is Initializable, ICounter {
    uint256 public value;
    address public immutable endpoint = address(0x1337);

    //init func
    function initialize(uint256 _value) public initializer {
        value = _value;
    }

    function increment() public {
        value += 1;
    }
}
