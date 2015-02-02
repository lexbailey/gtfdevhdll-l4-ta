
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

	

entity mn_param_adder is
	generic (adder_size : integer := 8;
				sub_adder_size : integer :=2);
	
    Port ( A : in  STD_LOGIC_VECTOR (size-1 downto 0);
           B : in  STD_LOGIC_VECTOR (size-1 downto 0);
           Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (size-1 downto 0);
           Cout : out  STD_LOGIC);
end mn_param_adder;

architecture Behavioral of mn_param_adder is

	signal carry : std_logic_vector (adder_size downto 0);

begin
	mn_adder: for i in 0 to ((adder_size/sub_adder_size)-1) generate
		p_adder: entity work.param_adder
		generic map (adder_size => sub_adder_size)
		port map (
			A => A((i*sub_adder_size) to (((i+1)*sub_adder_size)-1)),
			B => B((i*sub_adder_size) to (((i+1)*sub_adder_size)-1)), 
			Cin => carry(i), 
			Cout => carry(i+1), 
			S => S((i*sub_adder_size) to (((i+1)*sub_adder_size)-1)));
	end generate;
	
	carry(0) <= Cin;
	Cout <= carry(adder_size);


end Behavioral;

