library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY Top_level IS

PORT(	ch_dir: 		IN std_logic;
	ch_spe:			IN std_logic;
	reset:			IN std_logic;
	clock:			IN std_logic;
	
	--Transmitter_show: 	IN std_logic;
	--Calculator_show: 	IN std_logic;
	--Receiver_show: 		IN std_logic;

	--SM_signal:		IN std_logic_vector(9 DOWNTO 0); --Für Simulation

	out_left:		OUT std_logic;
	out_right:		OUT std_logic;
	LED:			OUT std_logic_vector(19 DOWNTO 0)
	

);	

END Top_level;
