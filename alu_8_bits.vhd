-- 8 bits ALU

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_8_bits is port (

	-- inputs 
	a, b : in unsigned(7 downto 0); 
	sel  : in std_logic_vector(3 downto 0); -- selection
	c    : in std_logic; -- carry in
	
	-- outputs
	q : out unsigned(7 downto 0) -- result	
	
	);
end entity;


architecture main of alu_8_bits is
	
	signal wire_arith, wire_logic, c_in : unsigned(7 downto 0) := "00000000";
	signal sel_1 : std_logic_vector(2 downto 0) := "000";
	signal sel_2 : std_logic := '0';
	
begin	
	-- convert the carry in to an 8-bit vector
	c_in(0) <= c;
	
	-- slice selection
	sel_1 <= sel(2 downto 0);
	sel_2 <= sel(3);
	
	-- arithmetic unit
	wire_arith <= a     when sel_1 = "000" else
		      a + 1 when sel_1 = "001" else
		      a - 1 when sel_1 = "010" else
		      b     when sel_1 = "011" else
		      b + 1 when sel_1 = "100" else
		      b - 1 when sel_1 = "101" else
		      a + b when sel_1 = "110" else
		      a + b + c_in;
	
	-- logic unit
	wire_logic <= not a    when sel_1 = "000" else
		      not b    when sel_1 = "001" else
		      a and b  when sel_1 = "010" else
		      a or b   when sel_1 = "011" else
		      a nand b when sel_1 = "100" else
		      a nor b  when sel_1 = "101" else
		      a xor b  when sel_1 = "110" else
		      a xnor b;
	
	-- output mux 
	q <= wire_logic when sel_2 = '1' else wire_arith;
	
end main;
	
