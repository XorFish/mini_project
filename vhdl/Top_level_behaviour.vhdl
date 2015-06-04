ARCHITECTURE device OF Top_level IS
--Signale/Components
SIGNAL s_ON_OFF_dir: 	std_logic;
SIGNAL s_ON_OFF_spe: 	std_logic;
SIGNAL s_ON_OFF: 	std_logic;

SIGNAL s_Direction:	std_logic_vector(3 DOWNTO 0);
SIGNAL s_Speed:		std_logic_vector(3 DOWNTO 0);
SIGNAL s_Left:		std_logic_vector(3 DOWNTO 0);
SIGNAL s_Right:		std_logic_vector(3 DOWNTO 0);

--Settings Kermit: st_trim:33% R.B.U. th_trim:28% L.F.U

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

	s_ON_OFF<=s_ON_OFF_dir OR s_ON_OFF_spe;
	

	calculator_device: calculator
			PORT MAP(	speed=>s_Speed,
					direction=>s_Direction, 	
					left=>s_Left,
					right=>s_right	
			);

	---------------------------------------------
	out_l0 <= s_Speed(0);
	out_l1<= s_Speed(1);
	out_l2<= s_Speed(2);
	out_l3<= s_Speed(3);

	out_r0<= s_Direction(0);
	out_r1<= s_Direction(1);
	out_r2<= s_Direction(2);
	out_r3<= s_Direction(3);

	c_out0<=s_Left(0);
	c_out1<=s_Left(1);
	c_out2<=s_Left(2);
	c_out3<=s_Left(3);

	c_out4<=s_right(0);
	c_out5<=s_right(1);
	c_out6<=s_right(2);
	c_out7<=s_right(3);


        --------------------------------------------


	transmitter_left: TRANSMITTER
			PORT MAP(	SM=> s_Left,      
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
