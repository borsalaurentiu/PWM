library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity counter_01231 is
    port(
        CLK1HZ: in STD_LOGIC;
        MODin_stabil: in STD_LOGIC;
        reset_sistem_stabil: in STD_LOGIC;
        MODout: out STD_LOGIC_VECTOR ( 1 downto 0 )
        );
end counter_01231;
        
architecture counter_01231 of counter_01231 is
signal D1, D0, O1, O0 : STD_LOGIC :='0';

component D_FF
    port(
        ENABLE: in STD_LOGIC;
        D: in STD_LOGIC;
        RESET: in STD_LOGIC;
        CLK1HZ: in STD_LOGIC;
        Q: out STD_LOGIC
        );
end component;		  


begin
    D1 <=  O0 xor O1;
    D0 <= ( not O0 ) or O1;
    C1: D_FF port map ( MODin_stabil, D1, reset_sistem_stabil, CLK1HZ, O1);
    C0: D_FF port map ( MODin_stabil, D0, reset_sistem_stabil, CLK1HZ, O0);
    MODout(1) <= O1 and ( not reset_sistem_stabil );
    MODout(0) <= O0 and ( not reset_sistem_stabil );
end counter_01231;