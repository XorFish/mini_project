ARCHITECTURE clockdivider OF CLOCKDIVIDER IS
--Signale/Components
SIGNAL s_time: std_logic_vector(11 DOWNTO 0);
BEGiN
	PROCESS (clock, s_time)
	BEGIN
		IF(reset='1')THEN
			s_time<="000000000000";
		ELSIF (rising_edge(clock)) AND (NOT(s_time="101000000000")) THEN --1/2560*clock
			s_time<=std_logic_vector(unsigned(s_time) +1);
		ELSIF (rising_edge(clock)) AND (s_time<="101000000000") THEN	
			s_time<="000000000000";
		END IF;
	END PROCESS;
	kickoff<='0' WHEN NOT(s_time="100000000000") ELSE '1';
END clockdivider;
