# Task: Implementation of Arithmetic Logic Unit
 Nithin Ravani Nanjundaswamy

####                  Introduction

The task is to implement an ALU which performs 8 different
operations.
Target Hardware and Tools used
Device: Spartan3 XC3S400
Design Tool: Xilinx ISE
Simulation Tool Modelsim
Clock used 20 MHz

####              Implementation

The ALU design consists of three modules
1.FetchInputs.vhd To obtain data from push buttons with
debounce of 20ms.
2.ALU.vhd To perform operations based on the input data
3.DisplayOutput.vhd To display results and operands on seven segment display.

FetchInputs.vhd is also the top module of the design.


1.FetchInputs
Inputs obtained through 5 push buttons sw1,sw2,sw3,sw4,sw5.
Outputs operand A(4 bits), operand B(4 bits), operator(3 bits)
Three pushbuttons (sw1,sw2,sw3) indicate the data type(operand or operator).
Two push buttons(sw4,sw5) are used to obtain data.
Push buttons have debounce of 20ms.
No. of clock cycles for debounce of 20ms=20ms/ clock_period =400000
FetchInputs.vhd implements a finite state machine to read inputs
with a debounce of 20ms.


2.ALU
Inputs operand A, operand B, operator are obtained from FetchInputs
Operation performed based on operator.
Use of shift and rotate operators are not recommended.
Implemented separate logic for shift and rotate operations.
Shift left   ->    Append zeros to LSB
Rotate right ->    Append LSB to MSB
For multiplication, cumulative addition is performed

3.DisplayOutput
Module drives four common anode seven segment display.
Four seven segment displays are multiplexed with a refresh rate of 1ms( changed from 10ms to avoid flickering)
Out of four displays
	2 are used to display input operands (A & B each 4 bits wide)
	Other 2 are used to display ALU output(8 bits)
No. of clock cycles for refresh rate of 1ms=1ms/ clock_period =20000

####               Testbench
Three separate testbenches were designed for all three modules.
Alu_tb to test all operations of ALU
DisplayOutput_tb to test the refresh rate of seven segment displays
Fetchinput_tb to test debounce time and also to verify the whole design
Hold data for 25ms to test the debounce data updated after 20ms
Whole design simulation proved correctness of the design