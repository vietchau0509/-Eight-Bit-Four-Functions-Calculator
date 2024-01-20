#Eight-Bit Four Functions Calculator
Project Overview
This project involves the design, implementation, and testing of an eight-bit calculator capable of performing four basic arithmetic functions - addition, subtraction, multiplication, and division. The project harnesses the power of FPGA (Field-Programmable Gate Array) technology, specifically using the DE10-Lite board, coupled with a keypad and optional HexBoard for input and output.

Purpose/Outcomes
Objective: Design, implement, and test an eight-bit, four-function (Add, Subtract, Multiply, Divide)
calculator using DE10-Lite + Keypad (+HexBoard).
Components: Control Unit (CU), Arithmetic Unit (AU), Output Unit (OU), Input Unit (IU).
Skills Demonstrated: Design, implementation, and testing of a machine with combinational and
sequential logic circuits using FPGAs and System Verilog HDL

Design and Implementation
The calculator is structured around four main components:

Control Unit (CU): Coordinates the operations of the calculator.
Arithmetic Unit (AU): Performs the core arithmetic operations.
Input Unit (IU): Manages user input via a 4x4 keypad.
Output Unit (OU): Displays results on the DE10-Lite's seven-segment displays.
The project demonstrates extensive use of combinational and sequential logic circuits, utilizing System Verilog HDL for design and implementation.

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
