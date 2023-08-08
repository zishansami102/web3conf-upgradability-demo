// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Counter2.sol";

import "@openzeppelin-norm/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin-norm/contracts/proxy/transparent/ProxyAdmin.sol";

contract CounterUpgradeScript is Script {
    address _OUR_PROXY = 0xBF3F8c0589A88e869C05DAAD2A48fE7cc35588FA;
    address _PROXY_ADMIN = 0x9D6d1b55738bB4baBAD756B9652ecE345EBf2Fe6;

    ProxyAdmin public ourProxyAdmin = ProxyAdmin(_PROXY_ADMIN);
    ITransparentUpgradeableProxy public ourProxy = ITransparentUpgradeableProxy(_OUR_PROXY);

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        
        Counter2 counterImplementation2 = new Counter2();

        ourProxyAdmin.upgrade(ourProxy, address(counterImplementation2));

        vm.stopBroadcast();
    }
}
