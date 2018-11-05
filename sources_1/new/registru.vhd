library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity registru is
    port(
        Q: out STD_LOGIC_VECTOR(3 downto 0);
        CLK62HZ : in STD_LOGIC
        );
end registru;
        
architecture registru of registru is
signal O: STD_LOGIC_VECTOR(3 downto 0) :="1110";
component DFF
  port (
        D:in STD_LOGIC;
        Q:out STD_LOGIC;
        CLK: in STD_LOGIC 
        );
end component;

begin
      process(CLK62HZ, O)
      begin
      if(CLK62HZ='1' and CLK62HZ'EVENT) then
        O(3)<=O(2);
        O(2)<=O(1);
        O(1)<=O(0);
        O(0)<=O(3);
      
      
      end if;
      end process;
      Q<=O;
end registru;
