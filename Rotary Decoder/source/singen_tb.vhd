library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity singen_tb is
end;

architecture bench of singen_tb is

  component singen
  	PORT( 									
  		angle: IN integer range 0 to 65535;
  		sindata	:	OUT integer range 0 to 65535;
		cosdata	:	OUT integer range 0 to 65535);
  end component;

  signal angle: integer range 0 to 65535:=0;
  signal sindata: integer range 0 to 65535 ;
  signal cosdata: integer range 0 to 65535 ;

begin

  uut: singen port map ( angle   => angle,
                         sindata => sindata,
						 cosdata => cosdata );
  stimulus: process
  begin
		for i in 0 to 4095 loop --- loop for backward revolution
			angle <= angle+1;
			wait for 5 ns;
		end loop;
		
		wait;

    wait;
  end process;


end;
