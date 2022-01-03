// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleStorage {
    //This is initialized to zero
<<<<<<< HEAD:web3pyVanilla/contracts/simpleStorage.sol
    uint256 favNumber = 545;

=======
    uint256 favNumber;
>>>>>>> 641e2a309c7a3aad3367fef3add5a770eaac8a39:remix/contracts/simpleStorage.sol
    //Store a provided number to our favnumber variable
    function storeFavNumber(uint256 _favNumber) public {
        favNumber = _favNumber;
    }
<<<<<<< HEAD:web3pyVanilla/contracts/simpleStorage.sol

=======
>>>>>>> 641e2a309c7a3aad3367fef3add5a770eaac8a39:remix/contracts/simpleStorage.sol
    //Gets the stored number in our favnumber
    function getFavNumber() public view returns (uint256) {
        return favNumber;
    }

    //a STRUCT kinda similar to a classs in dart or js
    struct Person {
        string firstName;
        string secondName;
        uint128 birthdayYear;
    }
    //Create an object example of type struct person initialized with my names and birthyear
<<<<<<< HEAD:web3pyVanilla/contracts/simpleStorage.sol
    Person public example =
        Person({firstName: "Sam", secondName: "Ndirangu", birthdayYear: 1995});
=======
    Person public example = Person({firstName: "Sam", secondName: "Ndirangu", birthdayYear: 1995});
>>>>>>> 641e2a309c7a3aad3367fef3add5a770eaac8a39:remix/contracts/simpleStorage.sol
    Person[] public people;
    //Create a mappping to map the firstname to birth year.
    mapping(string => uint128) public getByFirstName;

    function addPerson(
        string memory _firstName,
        string memory _secondName,
        uint128 _birthday
    ) public {
        people.push(
            Person({
                firstName: _firstName,
                secondName: _secondName,
                birthdayYear: _birthday
            })
        );
        getByFirstName[_firstName] = _birthday;
    }
}
