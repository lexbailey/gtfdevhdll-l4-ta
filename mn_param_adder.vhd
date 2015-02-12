library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Parametric adder or length M made from adders of size N
entity mn_param_adder is
	generic (adder_size : integer;
				sub_adder_size : integer);
	
	Port ( A : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);		--input number A
           B : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);	--input number B
           Cin : in  STD_LOGIC;											--Carry in
           S : out  STD_LOGIC_VECTOR (adder_size-1 downto 0);	--Sum output number
           Cout : out  STD_LOGIC);										--Carry output
		
end mn_param_adder;

architecture Behavioral of mn_param_adder is

	--internal carry bus
	signal carry : std_logic_vector (adder_size/sub_adder_size downto 0);

begin
	
	--generate (size/sub_size) adders of width (size)
	mn_adder: for i in 0 to ((adder_size/sub_adder_size)-1) generate
		p_adder: entity work.param_adder
		generic map (adder_size => sub_adder_size) --set size of sub adders
		port map (
			--Connect A and B to the relevent section of the input bus
			A => A(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))),
			B => B(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))), 
			--carry in from internal carry bus
			Cin => carry(i), 
			--carry out to next signal in carry bus
			Cout => carry(i+1), 
			--connect sum outputs to the relevent section of the output bus
			S => S(((i+1)*sub_adder_size)-1 downto ((i*sub_adder_size))));
	end generate;
	
	--connect carry in to the first signal on the internal carry bus
	carry(0) <= Cin;
	
	--connect the last signal on the internal carry bus to the carry output
	Cout <= carry(adder_size/sub_adder_size);


end Behavioral;

