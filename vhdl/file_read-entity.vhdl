LIBRARY ieee,std;
USE ieee.std_logic_1164.all;
USE std.textio.all;


ENTITY File_Read IS
   GENERIC(filename   : STRING := "../stimuli/test.IN";
           bitwidth   : INTEGER := 1);
   PORT( clock      : IN  std_logic;
         reset      : IN  std_logic;
         file_empty : OUT std_logic;
         data       : OUT std_logic_vector( (bitwidth-1) DOWNTO 0 ));
END File_Read;

