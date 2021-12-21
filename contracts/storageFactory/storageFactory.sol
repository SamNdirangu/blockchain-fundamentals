// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

import "./simpleStorage.sol";
//Contract inheritance enable with is statement
contract StorageFactory is SimpleStorage {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStoreFavNumber(
        uint256 _simpleStorageIndex,
        uint256 _simpleStorageNumber
    ) public {
        //Address
        //ABI
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
            .storeFavNumber(_simpleStorageNumber);
    }

    function sfGetFavNumber(uint256 _simpleStorageIndex)
        public
        view
        returns (uint256)
    {
        //Address
        //ABI
        return
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
                .getFavNumber();
    }
}
