## Steps to resproduce:

1. forge build

2. forge test

3. modify contract to have a constructor:
```
constructor() public {
    number = 100;
}
```
4. modify test script and run forge test again.

5. update deployment script to deploy
```
vm.startBroadcast();
Counter counter = new Counter();
console2.log(address(counter));
vm.stopBroadcast();
```

6. setup .env, and source it.
```
GOERLI_RPC_URL=<your_rpc_url>
PRIVATE_KEY=<your_pvt_key_with_eth>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
```

7. run deployment script by running 
```shell
$ forge script script/Counter.s.sol --rpc-url $GOERLI_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify
```


8. install oz upgradable and setup remappings.txt
```
forge install Openzeppelin/openzeppelin-contracts-upgradeable
forge install Openzeppelin/openzeppelin-contracts
```


9. setup `remappings.txt`:
```
@openzeppelin/=lib/openzeppelin-contracts-upgradeable/
@openzeppelin-norm=lib/openzeppelin-contracts/
```

10. inherit `Initializable`, and replace the constructor() with `initialize()` function:
```
function initialize() public initializer {
    number = 100;
}
```

11. Move to tests and import TranparentUpgradableProxy and ProxyAdmin contracts:
```
import "@openzeppelin-norm/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin-norm/contracts/proxy/transparent/ProxyAdmin.sol";
```

12. update test setup to deploy and setup proxies
```
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
```

13. run tests. `forge test`

14. Create `Counter2.sol` with new function `decrement()` and updated `increment()` function.

15. add upgrade test and run tests.
```
function testUpgradeContract() public {
    Counter2 counterImplementation2 = new Counter2();

    ourProxyAdmin.upgrade(ITransparentUpgradeableProxy(address(ourProxy)), address(counterImplementation2));

    Counter2 counter2 = Counter2(address(ourProxy));

    counter2.increment();
    assertEq(counter2.number(), 102);

    counter2.decrement();
    assertEq(counter2.number(), 101);
}
```

16. Update deployment script `Counter.s.sol` to accommodate proxies:
```
counterImplementation = new Counter();
counterImplementation.initialize();

ourProxyAdmin = new ProxyAdmin();

ourProxy = new TransparentUpgradeableProxy(
    address(counterImplementation),
    address(ourProxyAdmin),
    bytes("")
);
console2.log("Our proxy contract:", address(ourProxy));
console2.log("Our proxyAdmin contract:", address(ourProxyAdmin));

counter = Counter(address(ourProxy));
counter.initialize();
```

17. run deployment and go through the etherscan.

18. Create upgrade script, update the proxie addresses, run the script.
```
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
```


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy
```shell
$ source .env
```

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url $GOERLI_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
