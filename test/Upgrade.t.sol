// test/CounterTest.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

import {Counter} from "../src/Counter.sol";
import {CounterV2} from "../src/CounterV2.sol";
import "../src/ICounter.sol";
import "../src/ICounterV2.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract CounterTest is Test {
    Counter public myContract;
    CounterV2 public myContractV2;
    TransparentUpgradeableProxy public proxy;
    ProxyAdmin public proxyAdmin;

    function setUp() public {
        //necessary because tranpsarent proxies communicate the owner only through logs
        vm.recordLogs();

        myContract = new Counter();

        bytes memory data = abi.encodeWithSignature("initialize(uint256)", 42);
        proxy = new TransparentUpgradeableProxy(
            address(myContract),
            address(this),
            data
        );

        Vm.Log[] memory entries = vm.getRecordedLogs();

        proxyAdmin = ProxyAdmin(entries[2].emitter);

        myContract = Counter(address(proxy));
        
    }

    function testInitialValue() public {
        uint256 val = myContract.value();
        assertEq(val, 42);
    }

    function testIncrement() public {
        ICounter(address(proxy)).increment();
        uint256 val = myContract.value();
        assertEq(val, 43);
    }

    function testUpgrade() public {
        // Deploy the new implementation contract
        address oldEndpoint = myContract.endpoint();

        myContract.increment();

        myContractV2 = new CounterV2();

        console.log(myContract.endpoint());

        proxyAdmin.upgradeAndCall(ITransparentUpgradeableProxy(address(proxy)),address(myContractV2), hex"");

        // Cast the proxy address to CounterV2
        CounterV2 upgraded = CounterV2(address(proxy));

        // Use the new function from the upgraded contract
        upgraded.decrement();

        uint256 val = upgraded.value();
        console.log(upgraded.endpoint());
        //endpoint will be the same
        assertEq(oldEndpoint, upgraded.endpoint());
        assertEq(val, 42); // Should be back to the initial value after decrement
    }
}
