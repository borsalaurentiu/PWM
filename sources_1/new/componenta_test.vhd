library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity pwm_test is
    port(
        CLK100MHZ: in STD_LOGIC;
        pwm_duty: in INTEGER;
        LED: out STD_LOGIC
        );
end pwm_test;

architecture pwm_test of pwm_test is
signal pwm_counter: INTEGER :=0;
begin

process(CLK100MHZ)	   							
	    begin
            if (CLK100MHZ = '1' and CLK100MHZ'event) then
			    pwm_counter <= pwm_counter + 1;		
			        if (pwm_counter = 255) then
				        pwm_counter <= 0;
			        end if;
	       	end if;
    end process;
	
    process(pwm_counter, pwm_duty)
	   begin
		    if (pwm_duty = 0) then
			    LED <= '0';
		            elsif (pwm_counter < pwm_duty) then
			            LED <= '1';
		                    else 
			            LED <= '0';
		    end if;
    end process;
    
    
end pwm_test;