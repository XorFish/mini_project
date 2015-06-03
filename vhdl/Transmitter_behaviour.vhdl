
ARCHITECTURE transmitter OF TRANSMITTER IS
--Signale/Components
SIGNAL s_kickoff : std_logic;
SIGNAL s_trep: std_logic_vector(8 DOWNTO 0);
SIGNAL s_time: std_logic_vector(4 DOWNTO 0);
COMPONENT clockdivider
	Port( 	clock	: 	IN 	std_logic;
		reset:		IN	std_logic;
		kickoff:	OUT 	std_logic);
END COMPONENT;
BEGIN
	divider: clockdivider
	PORT MAP(	clock=>clock,
			reset=>reset,
			kickoff=>s_kickoff
			);
	s_time<="10001" WHEN SM="1111" ELSE
		"10010" WHEN SM="1110" ELSE
		"10011" WHEN SM="1101" ELSE
		"10100" WHEN SM="1100" ELSE
		"10101" WHEN SM="1011" ELSE
		"10110" WHEN SM="1010" ELSE
		"10111" WHEN SM="1001" ELSE
		"11000" WHEN SM="1000" ELSE
		"11000" WHEN SM="0000" ELSE
		"11001" WHEN SM="0001" ELSE
		"11010" WHEN SM="0010" ELSE
		"11011" WHEN SM="0011" ELSE
		"11100" WHEN SM="0100" ELSE
		"11101" WHEN SM="0101" ELSE
		"11110" WHEN SM="0110" ELSE
		"11111"

		WHEN SM="1000" OR SM="0000" ELSE 
		"11"&(SM(2 DOWNTO 0)) 	WHEN (SM(3) = '0') ELSE 
		"10"&(std_logic_vector(7-unsigned(SM(2 DOWNTO 0))));

	PROCESS(clock, s_kickoff, reset)
	BEGIN
		IF(reset='1'OR s_trep="100101100") THEN --entspricht 20ms
		      s_trep<="000000000";
		
		ELSIF(rising_edge(clock)) THEN
		 	IF(s_kickoff='1')THEN
				s_trep<=std_logic_vector(unsigned(s_trep)+1);
			END IF;
		END IF;
	END PROCESS;

	
	PWM<='1' WHEN (unsigned(s_time) >unsigned( s_trep)) AND (ON_OFF='1') ELSE '0'; 
	
END transmitter;
