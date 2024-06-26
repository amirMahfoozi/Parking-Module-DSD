# Parking Module DSD

This Verilog project models a sophisticated parking management system tailored for university needs. It prioritizes parking for faculty and staff, adjusts allocations dynamically throughout the day, and outputs real-time data on parked cars and available spaces.

![_parking.jpg](https://raw.githubusercontent.com/amirMahfoozi/Parking-Module-DSD/main/parking.jpg)

## Table of Contents
- [Introduction](#Introduction)
- [Key Features](#Key-Features)
- [Tools](#tools)
- [Module Parameters](#module-parameters)
- [Module Ports](#module-ports)
- [Testbench](#testbench)
- [Documentation](#documentation)
- [Usage](#usage)
- [Authors](#authors)

## Introduction
The purpose of this project is to design a parking management module that efficiently handles university parking. It dynamically reallocates parking spaces for university and non-university vehicles based on the time of day to maximize the use of available parking spots.

## Key-Features
- Priority Allocation: Gives preference to university faculty and staff.
- Dynamic Space Adjustment: Changes parking allocation according to the current time.
- Comprehensive Outputs: Provides updated counts of parked vehicles and available spaces.

## Tools
Verilog

## Module Parameters
parameter MAX_ALUMNI_CAPACITY = 500;
parameter TOTAL_CAPACITY = 700;

## Module Ports
Inputs:
wire clk,                  // Clock signal
wire reset,                // Reset signal
wire car_entered,          // Car entered signal
wire is_uni_car_entered,   // Alumni car entered signal
wire car_exited,           // Car exited signal
wire is_uni_car_exited,    // Alumni car exited signal
hour,           // Hour of the day (5 bits, 0 to 23)
Outputs :
uni_parked_car,      // Number of alumni cars parked
parked_car,          // Number of non-alumni cars parked
uni_vacated_space,   // Number of available spaces for alumni cars
vacated_space,       // Number of available spaces for non-alumni cars
uni_is_vacated_space,      // Flag if there is space for alumni cars
is_vacated_space           // Flag if there is space for non-alumni cars

## Testbench
The testbench (tb.v) is designed to rigorously verify the parking management module, ensuring it functions correctly across various scenarios.

### Test Scenarios
Initial conditions
Entry of university and non-university vehicles at different times
Exit of university and non-university vehicles at different times
Adjusting parking spaces from 1 PM to 4 PM dynamically
Managing overflow when university parking is full
Handling maximum general parking capacity

## Simulation Results
The simulation result is in output_sample.txt file. You can see the waveforms by simulating the code yourself using modelsim.

## Documentation
The project includes comprehensive documentation to ensure it is easy to understand and modify. All design decisions, parameter details, and operational flows are included in the Documentation.pdf file.

## Authors
- [Amir Mohammad Mahfoozi](https://github.com/amirMahfoozi)
