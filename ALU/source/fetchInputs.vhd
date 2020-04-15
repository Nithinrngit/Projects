--Authors: Nithin Ravani Nanjundaswamy, Ninad Shashikant Kulkarnmi

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
entity fetchInputs is
port(
	clk:in std_logic;
	reset:in std_logic;
	sw0,sw1,sw2,sw3,sw4:in std_logic;
	Anode_Activate  : out  STD_LOGIC_VECTOR (3 downto 0);
        data_out  : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end fetchInputs;
Architecture behaviour of fetchInputs is
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
component displayOutput
	port(
		clk : in  STD_LOGIC;
        	--reset  : in  STD_LOGIC;
           	data : in STD_LOGIC_VECTOR (7 downto 0);
           	A:in STD_LOGIC_VECTOR (3 downto 0);
         			B:in STD_LOGIC_VECTOR (3 downto 0);
            Anode_Activate  : out  STD_LOGIC_VECTOR (3 downto 0);
            data_out  : out  STD_LOGIC_VECTOR (7 downto 0)
		);
end component;
signal A_s: std_logic_vector(3 downto 0);
signal B_s: std_logic_vector(3 downto 0);
signal op_s: std_logic_vector(2 downto 0);
signal O_s: std_logic_vector(7 downto 0);
signal psw0,psw1,psw2,psw3,psw4: std_logic:= '0';
signal i,j,k:integer;
type state is (start,delaystate,update);
signal curr_state : state := start;
signal count: integer := 0;
constant max_count : integer := 400000; 
begin 
ALU1: ALU port map (clk => clk,
		    reset => reset,	
		    A   => A_s,
                    B   => B_s,
                    op  => op_s,
                    O   => O_s );
displayOutput1: displayOutput port map(clk => clk,
		    		--	reset => reset,
					data => O_s,
					A   => A_s,
          B   => B_s, 
 					Anode_Activate => Anode_Activate,
					data_out => data_out);
		
process(sw0,sw1,sw2,sw3,sw4,reset,clk)
begin
	if reset='0' then 
		i<=0;
		j<=0;
		k<=0;
		op_s<=(others => '0');
		A_s<=(others => '0');
		B_s<=(others => '0');
	elsif clk'event and clk ='1' then
		case curr_state is 
			when start =>
					if sw0/=psw0 or sw1/=psw1 or sw2/=psw2 or sw3/=psw3 or sw4/=psw4 then 
						curr_state<=delaystate;
					else 
						curr_state<=start;
					end if;
			when delaystate =>
					if count < max_count then 
						count <= count+1;
					else
						count <= 0;
						curr_state <= update;    
					end if; 
			when update =>
				psw0<=sw0;
				psw1<=sw1;
				psw2<=sw2;
				psw3<=sw3;
				psw4<=sw4;
				if sw0='1' and i<3 then
					if sw3 = '1' then
						op_s(i)<='1';
						i<= i+1;-- update i value only if value is obtained
					elsif sw4 = '1' then
						op_s(i)<='0';
						i<= i+1;
					end if;
--					i<= i+1;
				elsif sw1='1' and j<4 then
					if sw3 = '1' then
						A_s(j)<='1';
						j<= j+1;
					elsif sw4 = '1' then
						A_s(j)<='0';
						j<= j+1;
					end if;
					--j<= j+1;
				elsif sw2='1' and k<4 then
					if sw3 = '1' then
						B_s(k)<='1';
						k<= k+1;
					elsif sw4 = '1' then
						B_s(k)<='0';
						k<= k+1;
					end if;
--					k<= k+1;
				end if;
				curr_state<=start;
		end case;
	end if;
end process; 
		
end behaviour;