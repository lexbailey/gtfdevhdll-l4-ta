library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Parametric adder, default width 8
entity param_adder is
	 generic (adder_size : integer := 8);
    Port ( A : in  STD_LOGIC_VECTOR (adder_size-1 downto 0); --input number A
           B : in  STD_LOGIC_VECTOR (adder_size-1 downto 0); --input number B
           Cin : in  STD_LOGIC;										 --Carry input
           S : out  STD_LOGIC_VECTOR (adder_size-1 downto 0);--Sum output number
           Cout : out  STD_LOGIC);									 --Carry output
end param_adder;

architecture Behavioral of param_adder is

	--internal carry bus
	signal carry : std_logic_vector (adder_size downto 0);

begin
	
	--generate the adders
	p_adder: for i in 0 to adder_size-1 generate
		full_adder: entity work.adder
			port map (A => A(i), 			--directly connect a and b
						B => B(i), 
						Cin => carry(i), 		--carry in from carry bus
						Cout => carry(i+1), 	--carry out on next signal in bus
						S => S(i));				--directly connect sum output
	end generate;
	
	--connect CIn to the start of the internal carry bus
	carry(0) <= Cin;
	
	--connect the end of the internal carry bus to Cout
	Cout <= carry(adder_size);

end Behavioral;
