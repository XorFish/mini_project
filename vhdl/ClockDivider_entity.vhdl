Library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY CLOCKDIVIDER IS

Port( 	clock	: 	IN 		std_logic;
		reset:		IN		std_logic;
		kickoff:	OUT 	std_logic);

END CLOCKDIVIDER;
