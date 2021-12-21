// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleStorage {
    //This is initialized to zero
    uint256 favNumber;

    function store(uint256 _favNumber) public {
        favNumber = _favNumber;
    }

    function getNumber() public view returns (uint256) {
        return favNumber;
    }

    struct Person {
        string firstName;
        string secondName;
        uint128 birthdayYear;
    }

    Person public example =
        Person({firstName: "Sam", secondName: "Ndirangu", birthdayYear: 1995});
    Person[] public people;
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
