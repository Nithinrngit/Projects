--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fetchInputs_tb is
end;

architecture bench of fetchInputs_tb is

  component fetchInputs
  port(
  	clk:in std_logic;
  	reset:in std_logic;
  	sw0,sw1,sw2,sw3,sw4:in std_logic;
	Anode_Activate  : out  STD_LOGIC_VECTOR (3 downto 0);
        data_out  : out  STD_LOGIC_VECTOR (7 downto 0)
  	);
  end component;

  signal clk: std_logic:='0';
  signal reset: std_logic;
  signal sw0,sw1,sw2,sw3,sw4: std_logic ;
  signal Anode_Activate  : STD_LOGIC_VECTOR (3 downto 0);
  signal data_out  : STD_LOGIC_VECTOR (7 downto 0);
begin

  uut: fetchInputs port map ( clk   => clk,
                              reset => reset,
                              sw0   => sw0,
                              sw1   => sw1,
                              sw2   => sw2,
                              sw3   => sw3,
                              sw4   => sw4,
			Anode_Activate => Anode_Activate,
			data_out => data_out	 );
	Clk <= not Clk after 25ns;

stimulus: process
begin
reset<='0';
wait for 50ns;
reset<='1';
sw0<='1';--input for operator op-100
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='1';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw0<='0';--input for operator A-1010
sw1<='1';
sw3<='1';
wait for 25ms;
sw3<='0';
sw4<='1';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='1';
wait for 25ms;
sw1<='0';--input for operator B-1010
sw2<='1';
sw3<='1';
wait for 25ms;
sw3<='0';
sw4<='1';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='1';
wait for 25ms;
sw4<='0';
sw2<='0';
wait for 60ms;
reset<='0';
wait for 50ns;
reset<='1';
sw0<='1';--input for operator
sw3<='1';
wait for 25ms;
sw3<='0';
--sw4<='1';
wait for 25ms;
sw3<='1';
--sw4<='0';
wait for 25ms;
sw3<='0';
--sw4<='1';
wait for 25ms;
sw3<='1';
--sw4<='0';
wait for 25ms;
sw3<='0';
wait for 25ms;
sw0<='0';--input for operator A-1111
sw1<='1';
sw3<='1';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw1<='0';--input for operator B-1111
sw2<='1';
sw3<='1';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
sw3<='0';
sw4<='0';
wait for 25ms;
sw3<='1';
sw4<='0';
wait for 25ms;
wait;
end process;

end;