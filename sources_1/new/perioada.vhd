library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity perioada is
     port(
         CLK1HZ: in STD_LOGIC;
         reset_sistem_stabil: in STD_LOGIC;
         count_up_stabil : in  STD_LOGIC;
         count_down_stabil : in  STD_LOGIC;
         Y: out INTEGER;
         unit: out STD_LOGIC_VECTOR(3 downto 0);
         zeci: out STD_LOGIC_VECTOR(3 downto 0); 
         sute: out STD_LOGIC_VECTOR(3 downto 0)
         );
end perioada;

architecture perioada of perioada is
signal u,s,z: STD_LOGIC_VECTOR(3 downto 0);
signal COUNT: STD_LOGIC_VECTOR (3 downto 0);
begin
s<="1010";
process (count_up_stabil,count_down_stabil,reset_sistem_stabil,u,z,s,COUNT,CLK1HZ)
    begin
    if(reset_sistem_stabil='1') then
        u<="0000";
        z<="0000";
        COUNT<="0000";
            elsif(CLK1HZ='1' and CLK1HZ'EVENT) then
           if(count_up_stabil='1') then
                                        COUNT<=COUNT+'1';
                                            if(u="1001") then
                                                u<="0000";
                                                z<=z+'1';
                                            else
                                                u<=u+'1';
                                            end if;
                elsif(count_down_stabil='1') then
                COUNT<=COUNT-'1';   
                                            if(u="0000") then
                                                            u<="1001";
                                                            z<=z-'1';
                                                        else
                                                            u<=u-'1';
                                                       
                                             end if;      
                                            
      end if;
      end if;
        unit<=u;
        zeci<=z;
        sute<=s;
    Y <= TO_INTEGER(UNSIGNED(COUNT));    
end process;
    
    
end perioada;