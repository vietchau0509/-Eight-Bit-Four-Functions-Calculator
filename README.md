#Eight-Bit Four Functions Calculator
Project Overview
This project involves the design, implementation, and testing of an eight-bit calculator capable of performing four basic arithmetic functions - addition, subtraction, multiplication, and division. The project harnesses the power of FPGA (Field-Programmable Gate Array) technology, specifically using the DE10-Lite board, coupled with a keypad and optional HexBoard for input and output.

This calculator is developed for the DE10-Lite board, equipped with a keypad and a HexBoard, and utilizes the Quartus Prime Lite Edition with the device model 10M50DAF484C7G.

Purpose/Outcomes
Objective: Design, implement, and test an eight-bit, four-function (Add, Subtract, Multiply, Divide)
calculator using DE10-Lite + Keypad (+HexBoard).
Components: Control Unit (CU), Arithmetic Unit (AU), Output Unit (OU), Input Unit (IU).
Skills Demonstrated: Design, implementation, and testing of a machine with combinational and
sequential logic circuits using FPGAs and System Verilog HDL

Design and Implementation
The calculator is structured around four main components:
The calculator comprises four main components, each playing a crucial role in its functionality:
Control Unit (CU): Manages the overall control logic, coordinating the operations of other units. It interprets user inputs and signals from the Input Unit to control the flow of data and operations.
Arithmetic Unit (AU): Responsible for executing the arithmetic operations. It performs calculations based on the inputs and the operation selected by the Control Unit.
Output Unit (OU): Handles the display of the results. It takes the computed data from the Arithmetic Unit and presents it in a human-readable format on the HexBoard's 7-segment displays.
Input Unit (IU): Interfaces with the keypad, capturing user inputs such as numbers and operation commands, and relays this information to the Control Unit.
Features and Functionalities
Basic Operations: Addition, Subtraction, Multiplication, and Division.
Input Method: Numeric inputs through a 4x4 CSE Keypad.
Negative Number Entry: Entered with a '*' symbol and leading zeros.
Display Mechanics: Operand and result display in decimal sign-magnitude format.
Overflow Indication: An LED indicator for arithmetic overflows.

Test Cases
A series of test cases cover a range of scenarios including positive and negative numbers, boundary conditions, and typical use cases. The calculator has been rigorously tested for accuracy, handling of negative numbers, boundary conditions, and division operations.

Source Code
The Verilog code for each component of the calculator, along with an integrated top module, is provided in this repository. The code is well-documented and structured for easy understanding and modification.

Usage and Demonstration
Instructions for setting up the hardware, compiling the Verilog code, and operating the calculator are included. Example test inputs and expected outputs are provided to demonstrate the functionality of the calculator.
