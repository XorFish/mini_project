ARCHITECTURE receiver OF RECEIVER IS
--Signale/Components
SIGNAL s_kickoff: 	std_logic;
SIGNAL s_ON_OFF:	std_logic;
SIGNAL s_result:	std_logic_vector(3 DOWNTO 0);

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
				
		ON_OFF<=s_ON_OFF;
		result<=s_result;

		

END receiver;
