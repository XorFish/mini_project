ARCHITECTURE calc OF calculator IS
SIGNAL s_speed: 	std_logic_vector(2 DOWNTO 0);
SIGNAL s_left: 		std_logic_vector(2 DOWNTO 0);
SIGNAL s_right:		std_logic_vector(2 DOWNTO 0);
SIGNAL s_left_result, s_right_result: std_logic_vector(3 DOWNTO 0);

BEGIN
	s_speed<=speed(2 DOWNTO 0);
	s_left<=direction(2 DOWNTO 0) WHEN direction(3)='1' ELSE "000";
	s_right<=direction(2 DOWNTO 0) WHEN direction(3)='0' ELSE "000";

	s_left_result<=	"0"&std_logic_vector(unsigned(s_speed)- unsigned(s_left)) WHEN(unsigned(s_speed)>=unsigned(s_left)) ELSE 
			"1"&std_logic_vector(unsigned(s_left)- unsigned(s_speed));
	s_right_result<="0"&std_logic_vector(unsigned(s_speed)- unsigned(s_right)) WHEN(unsigned(s_speed)>=unsigned(s_right)) ELSE 
			"1"&std_logic_vector(unsigned(s_right)- unsigned(s_speed));

	left  <= s_left_result  WHEN speed(3)= '0' ELSE (s_left_result  XOR "1000");
	right <= s_right_result WHEN speed(3)= '0' ELSE (s_right_result XOR "1000");
END calc;


	
