--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

Entity ALU is 
port(
	clk: in std_logic;
	reset: in std_logic;
	A:in std_logic_vector(3 downto 0);
	B:in std_logic_vector(3 downto 0);
	op:in std_logic_vector(2 downto 0);
	O:out std_logic_vector(7 downto 0)
	);
End ALU;
Architecture beh of ALU is 
signal Bint,Aint:integer;
begin
	process(clk)
		variable A_append: std_logic_vector(7 downto 0);
		variable sum:unsigned(4 downto 0);
		variable O_v:std_logic_vector(7 downto 0);
		variable O_int:integer;
		begin
		if clk'event and clk='1' then
			if reset='0' then
				O<=(others => '0');
				O_v:=(others => '0');
			elsif op = "000" then
				O<=(others => '0');
				O_v:=(others => '0');
			elsif op = "001" then-- check for equality of bits
				O_v:=(others => '0');
				for i in 0 to 3 loop
					if A(i) = B(i) then
						O_v(i):='1';
					else 
						O_v(i):='0';
					end if;
				end loop;
				O<=O_v;
			elsif op ="010" then-- perform A or B
				O_v:=(others => '0');
				O_v(3 downto 0):= A or B;
				O<=O_v;			
			elsif op="011" or op="100" then-- Perform shift left or rotate right
				A_append:="0000"&A;
				for i in 0 to 15 loop	
				exit when i=Bint;
					if op="011" then
						A_append:=A_append(6 downto 0)&'0';
					else
						A_append:=A_append(0)&A_append(7 downto 1);
					end if;
				end loop;
				O<=A_append;
			elsif op="101" then-- perform addition
				O_v:=(others => '0');
				sum:=resize(unsigned(A),sum'length) + (unsigned(B));
				O_v(4 downto 0):= std_logic_vector(sum);
				O<=O_v;
			elsif op="110" then -- perform subtraction
				O_v:=(others => '0');
				O_v(3 downto 0):=std_logic_vector(unsigned(A) - unsigned(B));
				O<=O_v;
			elsif op="111" then -- perform multiplication
				O_int:=0;
				for i in 0 to 15 loop	
				exit when i=Bint;
				O_int:=O_int+Aint;
				end loop;
				O<=std_logic_vector(to_unsigned(O_int, O'length));
			end if;
		end if;
	end process;
Bint<=to_integer(unsigned(B));
Aint<=to_integer(unsigned(A));
end beh;
