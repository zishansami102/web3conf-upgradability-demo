// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract Counter is Initializable {
    uint256 public number;

    // function constructor() public initializer {
    //     number = 100;
    // }

    // why? short: to initialize proxy state
    // because constructor() sets the state variables
    // wrt its own state when the contract is created
    // and we need to initialize state within the proxy
    function initialize() public initializer {
        number = 100;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
