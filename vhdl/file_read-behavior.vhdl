ARCHITECTURE non_synthesisable OF File_Read IS

   FILE readfile : text IS IN filename;
   
   FUNCTION to_std_logic( ch : IN character ) return std_logic IS
   BEGIN
      CASE ch IS
	 WHEN '0'    => return '0';
	 WHEN '1'    => return '1';
	 WHEN 'X'    => return 'X';
	 WHEN 'U'    => return 'U';
	 WHEN 'Z'    => return 'Z';
	 WHEN 'W'    => return 'W';
	 WHEN 'L'    => return 'L';
	 WHEN 'H'    => return 'H';
	 WHEN '-'    => return '-';
	 WHEN others => assert false report "Error in infile" severity error;
                        return 'U';
      END CASE;
   END;
   
   SIGNAL s_state : std_logic_vector( (bitwidth-1) DOWNTO 0 );
   SIGNAL s_stop  : std_logic;
   
BEGIN

   data       <= s_state;
   file_empty <= s_stop;

   ReadP : PROCESS( clock , reset , s_state )
     VARIABLE wline : line;
     VARIABLE bchar : character;
   BEGIN
      IF (reset = '1') THEN s_stop  <= '1';
	                    s_state <= (OTHERS => '0');
      ELSIF (clock'event AND (clock = '1')) THEN
	 IF NOT(endfile(readfile)) THEN 
	    s_stop <= '0';
	    readline( readfile , wline );
	    FOR i IN 1 TO bitwidth LOOP
	       read( wline , bchar );
	       s_state( bitwidth - i ) <= to_std_logic( bchar );
	    END LOOP;
         			   ELSE s_stop <= '1'; 
	 END IF;
      END IF;
   END PROCESS ReadP;
   
END non_synthesisable;
