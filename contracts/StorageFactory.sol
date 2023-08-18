// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorages;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorages.push(simpleStorage);
    }

    function sfStore(
        uint256 _simpleStorageIndex,
        uint256 _simpleStorageNumber
    ) public {
        simpleStorages[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorages[_simpleStorageIndex].retrieve();
    }
}
