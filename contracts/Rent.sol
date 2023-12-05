// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Rent {
    address public rentalCompany;
    mapping(address => Driver) public drivers;
    mapping(string => Car) public cars;

    struct Car {
        string chassisNumber;
        string manufacturer;
        string model;
        uint32 year;
    }

    struct Driver {
        string birth;
        string license;
        string name;
        string[] phoneNumber;
    }

    constructor() {
        rentalCompany = msg.sender;
    }

    function registerDriver(
        string calldata _birth, 
        string calldata _license, 
        string calldata _name, 
        string[] calldata _phoneNumbers
    ) public {
        require(
            msg.sender != rentalCompany,
            "Only drivers can register themselves"
        );

        Driver memory newDriver = Driver(_birth,_license,_name,_phoneNumbers);
        drivers[msg.sender] = newDriver;
    }

    function getSelf() external view returns(Driver memory) {
        return drivers[msg.sender];
    }
}