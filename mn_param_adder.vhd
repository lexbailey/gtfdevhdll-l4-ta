library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mn_param_adder is
	generic (adder_size : integer;
				sub_adder_size : integer);
	
	Port ( A : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           B : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           Cout : out  STD_LOGIC);
		
end mn_param_adder;

architecture Behavioral of mn_param_adder is

	signal carry : std_logic_vector (adder_size/sub_adder_size downto 0);

begin
	mn_adder: for i in 0 to ((adder_size/sub_adder_size)-1) generate
		p_adder: entity work.param_adder
		generic map (adder_size => sub_adder_size)
		port map (
			A => A(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))),
			B => B(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))), 
			Cin => carry(i), 
			Cout => carry(i+1), 
			S => S(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))));
	end generate;
	
	carry(0) <= Cin;
	Cout <= carry(adder_size/sub_adder_size);


end Behavioral;

