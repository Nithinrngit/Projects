----------------------------------------------------------------------------------
-- Engineer: Nithin Ravani Nanjundaswamy 
-- Create Date: 07.04.2020
-- Module Name:  Quadrature Encoder
-- Project Name:  Rotary Encoder 
-- Description:   
-- Revision:
-- 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Quadrature_Decoder is
  GENERIC(
		angle_range						:	INTEGER := 4096);	
	PORT(
		a					:	IN			STD_LOGIC;										
		b					:	IN			STD_LOGIC;  									
		angle	:	OUT INTEGER  RANGE 0 to 65535;
		sinAngle: 	OUT INTEGER  RANGE 0 to 65535;
		cosAngle: 	OUT INTEGER  RANGE 0 to 65535); -- 16 bit wide(0 to 2^[16-1])	
END Quadrature_Decoder;

ARCHITECTURE RTL OF Quadrature_Decoder IS
	component singen
  	PORT( 									
  		angle       : IN integer range 0 to 65535;
  		sinAngle	: OUT integer range 0 to 65535;
		cosAngle    : OUT integer range 0 to 65535);
  end component;

	Signal a_prev: std_logic:='0';
	Signal b_prev: std_logic:='0';
	Signal angle_s:INTEGER  RANGE 0 to 65535:=0;
BEGIN
	DUTSine: singen port map ( angle   => angle_s,
							  sinAngle => sinAngle,
							  cosAngle => cosAngle	);
	Process(a,b)
	BEGIN
	if((a_prev /= a) OR (b_prev /= b)) then
		if((b_prev XOR a) = '1') then
			if(angle_s < angle_range-1) THEN				
				angle_s <= angle_s + 1;						
			else										
				angle_s <= 0;								
			end if;
		else											
			if(angle_s > 0) then							
				angle_s <= angle_s - 1;						
			else										
				angle_s <= angle_range-1;					
			end if;
		end if;
		a_prev <= a;
		b_prev <= b;
	end if;
	end process;
	angle <= angle_s;
end;
