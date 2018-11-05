library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all; 
use IEEE.NUMERIC_STD.all;

entity test is
	port(
	    Y: in INTEGER;
	    CLK100MHZ: in STD_LOGIC;
	    test: out INTEGER
	    );
end test;

architecture test of test is
signal count, int_test: INTEGER:=0 ;
signal p: INTEGER:=1;			
signal up: STD_LOGIC := '1';


begin


    p<=Y*390624;
               
	process(CLK100MHZ)
	begin
	
	if (CLK100MHZ = '1' and CLK100MHZ'EVENT) then 
				count <= count + 1;		
				if (count = p ) then 	
					count <= 0;
					int_test <= int_test + 1;
					if (int_test = 255) then
					   int_test <= 0;
				    end if;	
				end if;
	       end if; 
	end process;
	
	
	test <= int_test;
	
end test;