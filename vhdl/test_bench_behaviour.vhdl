ARCHITECTURE testBench OF Test_Bench IS

SIGNAL s_direction       :  std_logic_vector(3 DOWNTO 0);
SIGNAL s_speed		 :  std_logic_vector(3 DOWNTO 0);
SIGNAL s_LeftFile	 :  std_logic_vector(3 DOWNTO 0); 
SIGNAL s_LeftDevice	 :  std_logic_vector(3 DOWNTO 0); 
SIGNAL s_LeftCompare	 :  std_logic;
SIGNAL s_RightFile	 :  std_logic_vector(3 DOWNTO 0); 
SIGNAL s_RightDevice	 :  std_logic_vector(3 DOWNTO 0); 
SIGNAL s_RightCompare 	 :  std_logic;
SIGNAL s_delayedReset    :  std_logic;
SIGNAL s_solution	 :  std_logic;
SIGNAL s_OK		 :  std_logic;



--COMPONENT Test_Bench  
--	PORT(	A,B 	 : IN  std_logic_vector(3 DOWNTO 0);
  --   		Result 	 : OUT std_logic_vector(3 DOWNTO 0);
	--	Overflow : OUT std_logic);
--END COMPONENT;

COMPONENT File_Read IS
   GENERIC(filename   : STRING;
           bitwidth   : INTEGER);
   PORT( clock      : IN  std_logic;
         reset      : IN  std_logic;
         file_empty : OUT std_logic;
         data       : OUT std_logic_vector( (bitwidth-1) DOWNTO 0 ));
END COMPONENT;

COMPONENT calculator IS
	PORT(	speed, direction: IN std_logic_vector(3 DOWNTO 0);
		left, right: OUT std_logic_vector(3 DOWNTO 0));
END COMPONENT;

--COMPONENT File_Write IS
  -- GENERIC(filename   : STRING;
    --       bitwidth   : INTEGER);
   --PORT( clock      : IN  std_logic;
--         reset      : IN  std_logic;
--         enable     : IN  std_logic;
--         data       : IN  std_logic_vector( (bitwidth-1) DOWNTO 0 ));
--END COMPONENT;


BEGIN

	READ_SPEED: 	File_Read
			GENERIC MAP (	filename   => "../stimuli/speed.txt",
           				bitwidth   => 4)
			PORT MAP ( 	clock      =>clock,
				 	reset      =>reset,
				 	file_empty =>OPEN,
				 	data       =>s_speed);
	READ_DIRECTION: File_Read
			GENERIC MAP (	filename   => "../stimuli/direction.txt",
           				bitwidth   => 4)
			PORT MAP ( 	clock     =>clock,
				 	reset      =>reset,
				 	file_empty =>OPEN,
				 	data       =>s_direction);

	READ_LEFT: 	File_Read
			GENERIC MAP (	filename   => "../stimuli/left.txt",
           				bitwidth   => 4)
			PORT MAP ( 	clock     =>clock,
				 	reset      =>reset,
				 	file_empty =>OPEN,
				 	data       =>s_LeftFile);
	READ_RIGHT: 	File_Read
			GENERIC MAP (	filename   => "../stimuli/right.txt",
           				bitwidth   => 4)
			PORT MAP ( 	clock     =>clock,
				 	reset      =>reset,
				 	file_empty =>OPEN,
				 	data       =>s_RightFile);
	Device: 	calculator  
			PORT MAP (	speed=>s_speed,
					direction=>s_direction, 	 
     					left=>s_LeftDevice,
					right =>s_RightDevice);
	--WriteResult File_Write IS
	--   GENERIC MAP (filename   => "../stimuli/TestBenchResult.txt",
	--	   bitwidth   => 1);
	--   PORT MAP( clock     
	--	 reset      => s_delayedReset;
	--	 enable     => 1,
	--	 data       : IN  std_logic_vector( (bitwidth-1) DOWNTO 0 ));
	--END COMPONENT;




	s_solution<='0' WHEN ((s_LeftFile = s_LeftDevice) AND (s_RightDevice = s_RightFile)) ELSE '1';
	ok<=s_OK;

	DelayReset : PROCESS( clock , reset , s_delayedReset)
   		BEGIN
     			IF (reset = '1') THEN s_delayedReset<='1';
      			ELSIF (clock'event AND (clock = '1')) THEN
	 			s_delayedReset<=reset;
      			END IF;
   		END PROCESS DelayReset;

	DelaySolution : PROCESS( clock , s_delayedReset, s_ok, s_solution)
   		BEGIN
     			IF (s_delayedReset = '1') THEN s_ok<='0';
      			ELSIF (clock'event AND (clock = '1')) THEN
	 			s_ok<=s_solution;
      			END IF;
   		END PROCESS DelaySolution;
END testBench;
