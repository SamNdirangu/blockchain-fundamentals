// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleStorage {
    //This is initialized to zero
    uint256 randomNumber = 45;

    //Store a provided number to our favnumber variable
    function updateRandomNumber(uint256 _randomNumber) public {
        randomNumber = _randomNumber;
    }

    //Gets the stored number in our favnumber
    function getRandomNumber() public view returns (uint256) {
        return randomNumber;
    }

    //==================================================================
    //a STRUCT kinda similar to a classs in dart or js
    struct Person {
        string firstName;
        string secondName;
        uint128 birthYear;
    }
    //Create an object example of type struct person initialized with my names and birthyear
    Person public example =
        Person({firstName: "Sam", secondName: "Ndirangu", birthYear: 1995});
    Person[] public people;

    //Create a mappping to map the firstname to birth year.
    mapping(string => uint128) public getBirthYearByFirstName;

    function addPerson(
        string memory _firstName,
        string memory _secondName,
        uint128 _birthYear
    ) public {
        people.push(
            Person({
                firstName: _firstName,
                secondName: _secondName,
                birthYear: _birthYear
            })
        );
        getBirthYearByFirstName[_firstName] = _birthYear;
    }
}
