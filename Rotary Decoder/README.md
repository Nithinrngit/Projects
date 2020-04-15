# Rotary Decoder
Nithin Ravani Nanjundaswamy


Inputs- Channel A & Channel B pulses.  
Output- integer of 16 bit wide(so integer range is 0 to  2^(16-1)).  
1024 pulses per revolution.  
As angle is represented by integer ranging 0 to 4095(4x1024), we can deduce that X4 coding  is used.  
Clock is not considered and also marker signal Z(denoting one complete revolution) is not considered as it’s not part of given requirements.  
  
  
A_previous   B_previous A   B    output  

	0			0		1	0	Increment  
	1			0		1	1	Increment  
	1			1		0	1	Increment  
	0			1		0	0	Increment  
	0			0		0	1	Decrement  
	0			1		1	1	Decrement  
	1			1		1	0	Decrement  
	1			0		0	0	Decrement  
  
  
B_previous and A has XOR Relationship  
(B_previous XOR A)=1 -> Increment  
(B_previous XOR A)=0 -> Decrement  
  
  
####          TestBench  
Minimum 2 revolutions  
One forward – 1024 pulses  
One reverse – 1024 pulses  
Pulses duration=20ns  
  
  
####								Sin/Cos(angle) Calculation

The result of Sin(angle) is represented by 16 bit integer(0 to 65535).  
16 bit integers corresponding to sin(angle) is obtained using below expression in matlab  
					((0.5+0.5*sin(angle))*(65535))               0 ≤ angle ≤ 360  
16 bit integers are stored in Lookuptables of FPGA.  
Cos(angle) is obtained using the sin lookuptable with the help of trigonometric function  
	Cos(theta)=sin(90 - theta)  



####           Further possible optimization of sin/cos(angle) calculation

Instead of storing all 4 quadrant data, store one quadrant data and obtain other three quadrants using trigonometric functions.  
Instead of using LUT to store sine data, BlockRAM of FPGA can be used.  
Most efficient way of calculating sine/cosine function can be implemented through CORDIC Algorithm.  
