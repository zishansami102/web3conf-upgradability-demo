// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {Counter2} from "../src/Counter2.sol";

import "@openzeppelin-norm/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin-norm/contracts/proxy/transparent/ProxyAdmin.sol";

contract CounterTest is Test {
    Counter public counterImplementation;
    ProxyAdmin public ourProxyAdmin;
    TransparentUpgradeableProxy public ourProxy;
    
    Counter public counter;

    function setUp() public {
        // Counter counter = new Counter();

        counterImplementation = new Counter();
        counterImplementation.initialize();

        ourProxyAdmin = new ProxyAdmin();

        ourProxy = new TransparentUpgradeableProxy(
            address(counterImplementation),
            address(ourProxyAdmin),
            bytes("")
        );

        counter = Counter(address(ourProxy));
        counter.initialize();

    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 101);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testUpgradeContract() public {
        Counter2 counterImplementation2 = new Counter2();

        ourProxyAdmin.upgrade(ITransparentUpgradeableProxy(address(ourProxy)), address(counterImplementation2));

        Counter2 counter2 = Counter2(address(ourProxy));

        counter2.increment();
        assertEq(counter2.number(), 102);

        counter2.decrement();
        assertEq(counter2.number(), 101);
    }
}
