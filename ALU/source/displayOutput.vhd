--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity displayOutput is
    Port ( clk : in  STD_LOGIC;
          -- reset  : in  STD_LOGIC;
		   data : in STD_LOGIC_VECTOR (7 downto 0);
		   A:in STD_LOGIC_VECTOR (3 downto 0);
			B:in STD_LOGIC_VECTOR (3 downto 0);
           Anode_Activate  : out  STD_LOGIC_VECTOR (3 downto 0);
           data_out  : out  STD_LOGIC_VECTOR (7 downto 0));
end displayOutput;
architecture Behavioral of displayOutput is
signal halfdata: STD_LOGIC_VECTOR (3 downto 0);
signal switch:STD_LOGIC_VECTOR(1 downto 0):="00";
signal count:STD_LOGIC_VECTOR (16 downto 0) := (others => '0');
constant max_count :STD_LOGIC_VECTOR (16 downto 0) := "10011100010000000"; 
begin
process(clk)
	begin
	if clk'event and clk = '1' then 
		if count < max_count then 
			count <= count+1;
		else
			count <= (others => '0');
			--switch<=not(switch);    
		end if;
		if   count >= "00000000000000000" and count <= "00100111000100000" then 
		  switch<="00";
		elsif count > "00100111000100000" and count <= "01001110001000000" then 
		  switch<="01";
		elsif count > "01001110001000000" and count <= "01110101001100000" then 
		  switch<="10";
		elsif count > "01110101001100000" and count <= "10011100010000000" then 
		  switch<="11";
		end if;
	end if; 
end process;

process(switch,data,A,B)
	begin
	if switch="00" then 
		Anode_Activate<="ZZZ0";
		halfdata<=A;
	elsif switch="01" then
		Anode_Activate<="ZZ0Z";
		halfdata<=B;
  elsif switch="10" then
		Anode_Activate<="Z0ZZ";
    halfdata<=data(3 downto 0);
 	elsif switch="11" then
		Anode_Activate<="0ZZZ";
		halfdata<=data(7 downto 4);
	end if;
end process;

process(halfdata)
	begin
	case halfdata is
    when "0000" => data_out <= "00000011"; -- "0"     
    when "0001" => data_out <= "10011111"; -- "1" 
    when "0010" => data_out <= "00100101"; -- "2" 
    when "0011" => data_out <= "00001101"; -- "3" 
    when "0100" => data_out <= "10011001"; -- "4" 
    when "0101" => data_out <= "01001001"; -- "5" 
    when "0110" => data_out <= "01000001"; -- "6" 
    when "0111" => data_out <= "00011111"; -- "7" 
    when "1000" => data_out <= "00000001"; -- "8"     
    when "1001" => data_out <= "00001001"; -- "9" 
    when "1010" => data_out <= "00010001"; -- a
    when "1011" => data_out <= "11000001"; -- b
    when "1100" => data_out <= "01100011"; -- C
    when "1101" => data_out <= "10000101"; -- d
    when "1110" => data_out <= "01100001"; -- E
    when "1111" => data_out <= "01110001"; -- F
	when others => data_out <= "00000001";
    end case;
end process;
end Behavioral;