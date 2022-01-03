// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

import "./simpleStorage.sol";

//Contract inheritance enable with is statement
contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sFupdateRandomNumber(
        uint256 _simpleStorageIndex, // The specific contract index
        uint256 _simpleStorageNumber // The number we want to store
    ) public {
        //Address
        //ABI
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
            .updateRandomNumber(_simpleStorageNumber);
    }

    function sfGetRandomNumber(uint256 _simpleStorageIndex)
        public
        view
        returns (uint256)
    {
        //Address
        //ABI
        return
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
                .getRandomNumber();
    }
}
