library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity afisor is
	port(
		reset_sistem_stabil: in STD_LOGIC;
        value: in STD_LOGIC_VECTOR(15 downto 0);
		seg: out STD_LOGIC_VECTOR(6 downto 0);
		an: out STD_LOGIC_VECTOR(3 downto 0);
		Q: in STD_LOGIC_VECTOR(3 downto 0)
		);
end entity;

architecture afisor of afisor is
	signal digit: STD_LOGIC_VECTOR(3 downto 0);		-- Valoarea afisororului
begin
	
	process(Q, value)
	begin
		case Q is
			when "1110" => digit <= value(3 downto 0);
			when "1101" => digit <= value(7 downto 4);
			when "1011" => digit <= value(11 downto 8);
			when "0111" => digit <= value(15 downto 12);
			when others => digit <= "1010";
		end case;
	end process;
	
	process(digit)
	begin
		case digit is
		    when "0000" => seg  <= "1000000";  -- 0
            when "0001" => seg  <= "1111001";  -- 1
            when "0010" => seg  <= "0100100";  -- 2
            when "0011" => seg  <= "0110000";  -- 3
			when "0100" => seg  <= "0011001";  -- 4 
			when "0101" => seg  <= "0010010";  -- 5
			when "0110" => seg  <= "0000010";  -- 6
			when "0111" => seg  <= "1111000";  -- 7
			when "1000" => seg  <= "0000000";  -- 8
			when "1001" => seg  <= "0010000";  -- 9
			
			when "1100" => seg  <= "0111111";  -- -
            when "1101" => seg  <= "0001000";  -- A
            when "1110" => seg  <= "0000000";  -- B
            when "1111" => seg  <= "1000110";  -- C
            
			when others => seg  <= "1111111";  -- OFF
		end case;
	end process;
	
	process(Q, reset_sistem_stabil)
	begin
		an <= "1111";
		if (reset_sistem_stabil = '0') then
			an <= Q;
		end if;
	end process;
	
end afisor;