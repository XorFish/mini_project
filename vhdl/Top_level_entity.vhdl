library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY Top_level IS

PORT(	ch_dir: 	IN std_logic;
	ch_spe:		IN std_logic;
	reset:		IN std_logic;
	clock:		IN std_logic;
	out_left:	OUT std_logic;
	out_right:	OUT std_logic;
	out_l0:		OUT std_logic;
	out_l1:		OUT std_logic;
	out_l2:		OUT std_logic;
	out_l3:		OUT std_logic;

	out_r0:		OUT std_logic;
	out_r1:		OUT std_logic;
	out_r2:		OUT std_logic;
	out_r3:		OUT std_logic;

	c_out0:		OUT std_logic;
	c_out1:		OUT std_logic;
	c_out2:		OUT std_logic;
	c_out3:		OUT std_logic;

	c_out4:		OUT std_logic;
	c_out5:		OUT std_logic;
	c_out6:		OUT std_logic;
	c_out7:		OUT std_logic

);	

END Top_level;
