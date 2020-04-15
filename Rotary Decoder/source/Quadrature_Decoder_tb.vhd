----------------------------------------------------------------------------------
-- Engineer: Nithin Ravani Nanjundaswamy 
-- Create Date: 08.04.2020
-- Module Name:  Quadrature Encoder
-- Project Name:  Rotary Encoder 
-- Description:   
-- Revision:
-- 0.01 - File Created
-- Additional Comments:
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Quadrature_Decoder_tb is
end Quadrature_Decoder_tb;

architecture Behavioral of Quadrature_Decoder_tb is

	component Quadrature_Decoder
		GENERIC(
			angle_range						:	INTEGER := 4096);	
		PORT(
			a			:	IN			STD_LOGIC;										
			b			:	IN			STD_LOGIC;  									
			angle	    :	OUT INTEGER  RANGE 0 to 65535;
			sinAngle	:   OUT integer range 0 to 65535;
			cosAngle    :   OUT integer range 0 to 65535);
	end component;
	
	signal a: STD_LOGIC:='0';
	signal b: STD_LOGIC:='0';
	signal angle: INTEGER RANGE 0 to 65535;
	signal cosAngle: INTEGER RANGE 0 to 65535;
	signal sinAngle: INTEGER RANGE 0 to 65535;
Begin
	Dut: Quadrature_Decoder generic map ( angle_range => 4096  )
							 port map ( a           => a,
										b           => b,
										angle       => angle,
										sinAngle    => sinAngle,
										cosAngle    => cosAngle);

	process
	begin
		wait for 10 ns;                   
		for i in 0 to 2047 loop --- loop for forward revolution. 2048 transitions to generate 1024 pulses
			a <= not a;
			wait for 5 ns;
			b <= not b;
			wait for 5 ns;
		end loop;
		
		wait for 100 ns;
		
		for i in 0 to 2047 loop --- loop for backward revolution
			b <= not b;
			wait for 5 ns;
			a <= not a;
			wait for 5 ns;
		end loop;
		
		wait;
	end process;


end;
  