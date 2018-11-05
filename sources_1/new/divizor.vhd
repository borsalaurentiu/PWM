library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity v1hz is
port (CLK100MHZ : in std_logic;
      p: in integer;
      CLK : out std_logic);
end v1hz;		  

architecture v1hz of v1hz is
signal count : integer :=1;
signal Q: std_logic;
begin
    
	process(CLK100MHZ)
	begin
		if (CLK100MHZ = '1' and CLK100MHZ'EVENT) then
			count<=count+1;
			if(count=p) then
				count<=1;
				Q<= not Q;
			end if;
		end if;
	end process;
			CLK<=Q;
end v1hz;
