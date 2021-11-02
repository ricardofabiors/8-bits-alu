-- 8 bits ALU - Testbench

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_8_bits_tb is 
end entity;


architecture main of alu_8_bits_tb is

	signal a : unsigned(7 downto 0) := "00001000"; -- any non-zero value
	signal b : unsigned(7 downto 0) := "00000010"; -- any non-zero value
	signal sel_tb  : unsigned(3 downto 0) := "0000";  -- variable selection
	signal sel : std_logic_vector(3 downto 0); -- target selection
	signal c_in : std_logic:= '0'; -- carry in

	signal q : unsigned(7 downto 0); 

begin
	
	DUT : entity work.alu_8_bits(main) port map(a, b, sel, c_in, q);
	
	process is
	begin

		wait for 50 ps;
		a <= a + 15; 
		b <= b + 20;
		c_in <= not c_in;
		sel_tb <= sel_tb + 1;
		
	end process;

	sel <= std_logic_vector(sel_tb); -- alu_8_bits expects a std_logic_vector in 'sel' parameter

end main;
	
