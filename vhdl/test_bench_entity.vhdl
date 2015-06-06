LIBRARY ieee,std;
USE ieee.std_logic_1164.all;


ENTITY Test_Bench IS
   PORT( clock      : IN  std_logic;
         reset      : IN  std_logic;
	 OK	    : OUT std_logic);
END Test_Bench;

