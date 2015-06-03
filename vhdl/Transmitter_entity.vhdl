Library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY TRANSMITTER IS
	Port(	        SM:		        IN 	std_logic_vector(3 DOWNTO 0);
			ON_OFF:			IN	std_logic;		
			reset:			IN	std_logic;--Reset der Komponente
			clock:			IN	std_logic;
			PWM:			OUT	std_logic);


END TRANSMITTER;

