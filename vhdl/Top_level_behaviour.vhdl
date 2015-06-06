ARCHITECTURE device OF Top_level IS
--Signale/Components
SIGNAL s_ON_OFF_dir: 	std_logic;
SIGNAL s_ON_OFF_spe: 	std_logic;
SIGNAL s_ON_OFF: 	std_logic;

SIGNAL s_Receiver:	std_logic;
SIGNAL s_Transmitter:	std_logic;
SIGNAL s_Calculator:	std_logic;

SIGNAL s_Direction:	std_logic_vector(3 DOWNTO 0);
SIGNAL s_Speed:		std_logic_vector(3 DOWNTO 0);
SIGNAL s_Left:		std_logic_vector(3 DOWNTO 0);
SIGNAL s_Right:		std_logic_vector(3 DOWNTO 0);
SIGNAL s_LeftReversed:	std_logic_vector(3 DOWNTO 0);

--Settings Kermit: st_trim:8 th_trim:8

COMPONENT RECEIVER

	Port( 	clock,reset: 	IN 	std_logic;
		channel:	IN 	std_logic;
		ON_OFF:		OUT 	std_logic;
		result:		OUT 	std_logic_vector(3 DOWNTO 0));
END COMPONENT;

COMPONENT TRANSMITTER

	Port(	SM:	        IN 	std_logic_vector(3 DOWNTO 0);
		ON_OFF:		IN	std_logic;		
		reset:		IN	std_logic;--Reset der Komponente
		clock:		IN	std_logic;
		PWM:		OUT	std_logic);
END COMPONENT;

COMPONENT calculator

	PORT(	speed, direction: 	IN std_logic_vector(3 DOWNTO 0);
		left, right: 		OUT std_logic_vector(3 DOWNTO 0));
END COMPONENT;



BEGIN
	--Selektion wie Anzeige Nutzen für Simulation
	--s_Receiver<=Receiver_show;
	--s_Transmitter<=Transmitter_show;
	--s_Calculator<=Calculator_show; 
	
	channel_direction: RECEIVER
			PORT MAP(	clock=>clock,
					reset=>reset,
					channel=>ch_dir,
					ON_OFF=>s_ON_OFF_spe,
					result=>s_Direction
			);

	channel_speed: RECEIVER
			PORT MAP(	clock=>clock,
					reset=>reset,
					channel=>ch_spe,
					ON_OFF=>s_ON_OFF_dir,
					result=>s_Speed
			);

	s_ON_OFF<=s_ON_OFF_dir AND s_ON_OFF_spe;
	

	calculator_device: calculator
			PORT MAP(	speed=>s_Speed,
					direction=>s_Direction, 	
					left=>s_Left,
					right=>s_right	
			);

	---------------------------------------------
	LED(3 DOWNTO 0)<=s_Speed;-- WHEN(s_Receiver = '1')ELSE s_Direction
	LED(4)<='0';
	LED(8 DOWNTO 5)<=s_Direction;
	LED(9)<='0';
	LED(10)<=s_ON_OFF;
	LED(11)<='0';
	LED(15 DOWNTO 12)<=s_right;
	LED(19 DOWNTO 16)<=s_left;
        --------------------------------------------
	
	s_LeftReversed<=NOT(s_left(3))&s_left(2 DOWNTO 0);
	transmitter_left: TRANSMITTER
			PORT MAP(	SM=> s_LeftReversed,      
					ON_OFF=>s_ON_OFF,				
					reset=>reset,	
					clock=>clock,	
					PWM=>out_left				
			);	

	transmitter_right: TRANSMITTER
			PORT MAP(	SM=>s_Right,	       
					ON_OFF=>s_ON_OFF,				
					reset=>reset,	
					clock=>clock,	
					PWM=>out_right			
			);	

END device;
