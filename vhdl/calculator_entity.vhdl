library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY calculator IS

PORT(	speed, direction: IN std_logic_vector(3 DOWNTO 0);
	left, right: OUT std_logic_vector(3 DOWNTO 0));
	
END calculator;
