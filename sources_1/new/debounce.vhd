library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity debounce is
	port(
	     button: in STD_LOGIC;
	     CLK100MHZ: in STD_LOGIC;
	     button_stabil: out STD_LOGIC
	     );
end debounce;

architecture debounce of debounce is
signal Q1, Q2, Q3: STD_LOGIC;


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

    D1: D_FF port map ( '1', button, '0', CLK100MHZ, Q1 );
    D2: D_FF port map ( '1', Q1, '0', CLK100MHZ, Q2 );
    D3: D_FF port map ( '1', Q2, '0', CLK100MHZ, Q3 );
	
	button_stabil <= Q1 and Q2 and Q3;
	
end debounce;
