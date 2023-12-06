// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Rent {
    address public rentalCompany;
    mapping(address => Driver) public drivers;
    mapping(string => Car) public cars;

    struct Car {
        string chassisNumber;
        string licensePlate;
        string manufacturer;
        string model;
        uint32 year;
        bool exists;
    }

    struct Driver {
        string birth;
        string license;
        string name;
        string[] phoneNumbers;
        bool exists;
        Car rented;
    }

    constructor() {
        rentalCompany = msg.sender;
    }

    function registerCar(
        string calldata _chassisNumber,
        string calldata _licensePlate,
        string calldata _manufacturer,
        string calldata _model,
        uint32 _year
    ) external {
        require(
            msg.sender == rentalCompany,
            "Only the company can register cars"
        );

        Car memory newCar = Car(_chassisNumber,_licensePlate,_manufacturer,_model,_year,true);
        cars[_licensePlate] = newCar;
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

        require(
            drivers[msg.sender].exists == false,
            "Driver with this address is already registered"
        );

        Driver memory newDriver;
        newDriver.birth = _birth;
        newDriver.license = _license;
        newDriver.name = _name;
        newDriver.phoneNumbers = _phoneNumbers;
        newDriver.exists = true;
        drivers[msg.sender] = newDriver;
    }

    function getCar(string calldata _licensePlate) external view returns (Car memory) {
        require(
            msg.sender == rentalCompany,
            "Only the company can check cars"
        );

        return cars[_licensePlate];
    }
    
    function getDriver(address _driverAddress) external view returns (Driver memory) {
        require(
            msg.sender == rentalCompany,
            "Only the company can check drivers"
        );

        return drivers[_driverAddress];
    }
    
    function getSelf() external view returns (Driver memory) {
        return drivers[msg.sender];
    }

    function rent(string calldata _licensePlate) external {
        require(
            msg.sender != rentalCompany,
            "Only drivers can rent cars"
        );
        
        require(
            drivers[msg.sender].exists == true && cars[_licensePlate].exists == true,
            "Driver/car must register before rent"
        );

        drivers[msg.sender].rented = cars[_licensePlate];
    }
}