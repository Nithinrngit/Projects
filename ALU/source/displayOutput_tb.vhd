--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity displayOutput_tb is
end;

architecture bench of displayOutput_tb is

  component displayOutput
      Port ( clk : in  STD_LOGIC;
             reset  : in  STD_LOGIC;
  		   data : in STD_LOGIC_VECTOR (7 downto 0);
             Anode_Activate  : out  STD_LOGIC_VECTOR (1 downto 0);
             data_out  : out  STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal clk: STD_LOGIC:='0';
  signal reset: STD_LOGIC;
  signal data: STD_LOGIC_VECTOR (7 downto 0);
  signal Anode_Activate: STD_LOGIC_VECTOR (1 downto 0);
  signal data_out: STD_LOGIC_VECTOR (6 downto 0);

begin

  uut: displayOutput port map ( clk            => clk,
                                reset          => reset,
                                data           => data,
                                Anode_Activate => Anode_Activate,
                                data_out       => data_out );
Clk <= not Clk after 25ns;

  stimulus: process
  begin
	reset<='0';
	data<="11110000";
	wait for 100ms;  
    wait;
  end process;


end;
