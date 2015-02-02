library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Full adder circuit, A, B and Carry inputs, Sum and Carry outputs.
entity adder is
    Port ( A : in  STD_LOGIC;					--Input A
           B : in  STD_LOGIC;					--Input B
           Cin : in  STD_LOGIC;				--Carry in
           S : out  STD_LOGIC;				--Sum out
           Cout : out  STD_LOGIC);			--Carry out
end adder;

--Process for the full adder
architecture Behavioral of adder is
signal P,G,Cprop: STD_LOGIC;
begin
	G <= A and B;
	P <= A xor B;
	Cprop <= P and Cin;
	
	Cout <= Cprop or G;  --Carry out is high when the sum is 2 or 3
	S <= P xor Cin;		--Sum out is high when the sum is 1 or 3
end Behavioral;

