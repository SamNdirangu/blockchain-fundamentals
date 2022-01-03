// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleStorage {
    //This is initialized to zero
    uint256 favNumber;
    //Store a provided number to our favnumber variable
    function storeFavNumber(uint256 _favNumber) public {
        favNumber = _favNumber;
    }
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
    Person public example = Person({firstName: "Sam", secondName: "Ndirangu", birthdayYear: 1995});
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
