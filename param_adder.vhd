library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity param_adder is
	 generic (adder_size : integer := 8);
    Port ( A : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           B : in  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (adder_size-1 downto 0);
           Cout : out  STD_LOGIC);
end param_adder;

architecture Behavioral of param_adder is

	signal carry : std_logic_vector (adder_size downto 0);

begin

	p_adder: for i in 0 to adder_size-1 generate
		full_adder: entity work.adder
			port map (A => A(i), B => B(i), Cin => carry(i), Cout => carry(i+1), S => S(i));
	end generate;

	carry(0) <= Cin;
	Cout <= carry(adder_size);

end Behavioral;
