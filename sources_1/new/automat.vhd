library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all; 
use IEEE.NUMERIC_STD.all;

entity pwm_automat is
	port(
	    reset_sistem_stabil: in STD_LOGIC;
	    Y: in INTEGER;
	    CLK100MHZ: in STD_LOGIC;
	    automat: out INTEGER
	    );
end entity;

architecture pwm_automat of pwm_automat is
signal count, int_automat: integer:=0 ;
signal p: integer:=1;			
signal up: STD_LOGIC := '1';				

begin


               
	process(CLK100MHZ,reset_sistem_stabil,p,Y,int_automat,count,up)
	begin
	
    p<=Y*195312;
	if(reset_sistem_stabil = '1') then
               int_automat <= 0;
               count <= 0;
               up<='1';
               p<=1;
               else
	if (CLK100MHZ='1' and CLK100MHZ'EVENT) then 
				count <= count + 1;		
				if (count = p and up = '1') then 
					count <= 0;
					int_automat <= int_automat + 1;
					
					if (int_automat = 255) then
						int_automat <= int_automat - 1;
						up <= '0';
					end if;
				elsif (count = p and up = '0') then	
					count <= 0;
					int_automat <= int_automat - 1;
					
					if int_automat = 1 then
						up <= '1';
					end if;				
				end if;
			end if;
			end if;
	end process;

        automat <= int_automat;
        
    end pwm_automat;