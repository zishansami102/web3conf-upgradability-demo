// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Counter.sol";

// import "@openzeppelin-norm/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
// import "@openzeppelin-norm/contracts/proxy/transparent/ProxyAdmin.sol";

contract CounterScript is Script {
    // Counter public counterImplementation;
    // ProxyAdmin public ourProxyAdmin;
    // TransparentUpgradeableProxy public ourProxy;
    
    Counter public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new Counter();
        console2.log(address(counter));
        
        // counterImplementation = new Counter();
        // counterImplementation.initialize();

        // ourProxyAdmin = new ProxyAdmin();

        // ourProxy = new TransparentUpgradeableProxy(
        //     address(counterImplementation),
        //     address(ourProxyAdmin),
        //     bytes("")
        // );
        // console2.log("Our proxy contract:", address(ourProxy));
        // console2.log("Our proxyAdmin contract:", address(ourProxyAdmin));

        // counter = Counter(address(ourProxy));
        // counter.initialize();

        vm.stopBroadcast();
    }
}
