library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity pwm_manual is
    port(
        CLK100MHZ: in STD_LOGIC;
        pwm_duty: in INTEGER;
        LED: out STD_LOGIC_VECTOR(7 downto 0);
        busLED: in STD_LOGIC_VECTOR (7 downto 0);
        enable: in STD_LOGIC

        );
end pwm_manual;

architecture pwm_manual of pwm_manual is
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
	
    process(pwm_counter, pwm_duty,enable,busLED)
	   begin
	   if(enable='0') then
		    if (pwm_duty = 0) then
			    LED <= (others => '0');
		            elsif (pwm_counter < pwm_duty) then
			            LED <= (others => '1');
		                    else 
			            LED <= (others => '0');
		    end if;
		    else
		    LED<=busLED;
		    end if;
    end process;
    
    
end pwm_manual;