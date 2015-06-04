ARCHITECTURE receiver OF RECEIVER IS
--Signale/Components
SIGNAL s_kickoff: 	std_logic;
SIGNAL s_ON_OFF:	std_logic;
SIGNAL s_result:	std_logic_vector(3 DOWNTO 0);
SIGNAL s_resultSampled:	std_logic_vector(3 DOWNTO 0);
SIGNAL s_ON_OFFSampled:	std_logic;

COMPONENT clockdivider
	Port( 	clock	: 	IN 	std_logic;
		reset:		IN	std_logic;
		kickoff:	OUT 	std_logic);
END COMPONENT;

COMPONENT counter
	Port(	kickoff:	IN 	std_logic;
		reset:		IN	std_logic;--Reset der Komponente
		clock:		IN	std_logic;
		channel: 	IN 	std_logic;
		ON_OFF:		OUT	std_logic;
		result:		OUT	std_logic_vector(3 DOWNTO 0));
END COMPONENT;

BEGIN
		divider: clockdivider
		PORT MAP(	clock=>clock,
				reset=>reset,
				kickoff=>s_kickoff
				);
					
			
		pulscounter: counter
		PORT MAP(	kickoff=>s_kickoff,
				reset=>reset,
				clock=>clock,
				channel=>channel,
				ON_OFF=>s_ON_OFF,
				result=>s_result
				);
				
		PROCESS(clock, reset,s_kickoff, s_ON_OFFSampled,s_ON_OFF,s_resultSampled,s_result)
	BEGIN
		IF(reset='1') THEN 
			s_ON_OFFSampled<='0';--Null setzen
			s_resultSampled<="0000";
		ELSIF(rising_edge(clock) AND s_kickoff='1')THEN
			s_ON_OFFSampled<=s_ON_OFF;
			s_resultSampled<=s_result;
		END IF;		
			
	END PROCESS;
		ON_OFF<=s_ON_OFFSampled;
		result<=s_resultSampled;

		

END receiver;
