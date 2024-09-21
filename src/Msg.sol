/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ICounter.sol";

interface IMsg {
    function sender() external view returns(address);
}

contract Msg is IMsg {
    function sender() public view returns(address) {
        return msg.sender;
    }
}
