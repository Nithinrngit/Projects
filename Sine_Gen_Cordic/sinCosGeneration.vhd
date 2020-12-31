---------------------------------------------------------------------------------- 
-- Engineer: Nithin
-- Create Date: 12/26/2020 05:34:50 PM
-- Design Name: sinCosGeneration
-- Module Name: test_exc - Behavioral
-- Description: Generates 10kHz Sin&cos wave using Cordic IP. The Cordic IP can be obatined from Xilinx ip catalog in Vivado
-- Dependencies: Cordic IP should be added to the project 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library ieee;
library ieee_proposed;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    use ieee_proposed.fixed_float_types.all;    --for fixed point notation
    use ieee_proposed.fixed_pkg.all;            --for fixed point notation
    use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sinCosGeneration is
Port (
	sine   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	cosine : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	);
end sinCosGeneration;

architecture Behavioral of test_exc is
COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

signal aclk: std_logic :='0';
signal rad_per_sample : sfixed (3 downto -28) := to_sfixed(0.00628318530718,3,-28);--1000 samples per period(2pi/1000)
signal count_limit : integer:=10;--100Mhz(clock) / 10K(freq) /1000(samples))
signal cnt_samp_time : integer:=0;
signal phi_cord : sfixed(2 downto -29) := to_sfixed(0.0,2,-29);
signal s_axis_phase_tvalid : STD_LOGIC;
signal s_axis_phase_tdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal m_axis_dout_tvalid : STD_LOGIC;
signal m_axis_dout_tdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pi  : sfixed (3 downto -28) := to_sfixed(-6.283185307,3,-28);--0.01570796327
begin

cordic : cordic_0
  PORT MAP (
    aclk => aclk,
    s_axis_phase_tvalid => s_axis_phase_tvalid,
    s_axis_phase_tdata => s_axis_phase_tdata,
    m_axis_dout_tvalid => m_axis_dout_tvalid,
    m_axis_dout_tdata => m_axis_dout_tdata
  );
  
  process(aclk)
  variable phi:sfixed(3 downto -28) := to_sfixed(0.0,3,-28);
   begin
   if(rising_edge(aclk)) then 
            if(cnt_samp_time >= count_limit-1) then
                
                phi := resize((phi + rad_per_sample),3,-28);
                --cordic IP core wants angle in rad and [pi to -pi]
                if (phi >= to_sfixed(3.1415926535898,3,-28)) then      
                    phi := resize((pi + phi),3,-28);              
                end if;
                phi_cord <= resize(phi,2,-29);
                cnt_samp_time <= 0;
             else
                cnt_samp_time <= cnt_samp_time + 1;          
             end if;
    end if; 
   end process;

--generate clock of 100MHz
aclk <= not(aclk) after 5ns;

--Assign cordic inputs
s_axis_phase_tvalid <= '1';
s_axis_phase_tdata <= std_logic_vector(phi_cord);
--Assign cordic IP  outputs
sine <= m_axis_dout_tdata(31 downto 16);
cosine <= m_axis_dout_tdata(15 downto 0);
	
end Behavioral;
