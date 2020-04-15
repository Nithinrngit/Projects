--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_tb is
end;

architecture bench of ALU_tb is

  component ALU 
  port(
  	clk: in std_logic;
	reset: in std_logic;
  	A:in std_logic_vector(3 downto 0);
  	B:in std_logic_vector(3 downto 0);
  	op:in std_logic_vector(2 downto 0);
  	O:out std_logic_vector(7 downto 0)
  	);
  end component;

  signal clk,reset: std_logic:='0';
  signal A: std_logic_vector(3 downto 0);
  signal B: std_logic_vector(3 downto 0);
  signal op: std_logic_vector(2 downto 0);
  signal O: std_logic_vector(7 downto 0) ;


begin
  uut: ALU port map (clk => clk,
         	     reset => reset,	
	             A   => A,
                     B   => B,
                     op  => op,
                     O   => O );
  Clk <= not Clk after 5ns;
  stimulus: process
  begin
reset<='1';
wait for 10ns;
reset<='0';
op<="000";
wait for 10ns;
op<="111";
A<="1111";
B<="1111";
wait for 10ns;
op<="111";
A<="1000";
B<="0000";
wait for 10ns;

wait;
  end process;

end;