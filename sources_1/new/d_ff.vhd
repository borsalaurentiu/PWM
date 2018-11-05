library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity D_FF is
    port(
        ENABLE: in STD_LOGIC;
        D: in STD_LOGIC;
        RESET: in STD_LOGIC;
        CLK1HZ: in STD_LOGIC;
        Q: out STD_LOGIC
        );
end D_FF;
        
architecture D_FF of D_FF is
signal O: STD_LOGIC :='0';

begin
    process(CLK1HZ, RESET, ENABLE)
    begin
        if( RESET = '1' ) then
            O<='0';
                elsif ( CLK1HZ = '1' and CLK1HZ'EVENT ) then
                     if ( ENABLE = '1' ) then
                         O <= D;
                     end if;
        end if;
    end process;
    Q <= O;
end D_FF;