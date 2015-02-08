LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY mn_param_adder_24_8_tb IS

	constant size : natural := 24;
	constant sub_size : natural := 8;

	type test_vector is record
		a : std_logic_vector (size-1 downto 0);
		b : std_logic_vector (size-1 downto 0);
		s : std_logic_vector (size-1 downto 0);
		cin : std_logic;
		cout : std_logic;
	end record;

	type test_vector_array is array
		(natural range <>) of test_vector;
		constant test_vectors : test_vector_array := (
		-- a, b, s, cin, cout
		(X"000000", X"000000", X"000000", '0', '0'), --no carry
		(X"ffffff", X"000000", X"000000", '1', '1'), --carry all the way
		(X"751428", X"4194ab", X"b6a8d3", '0', '0'), --some carry bits high but not all
		(X"000000", X"000000", X"000001", '1', '0'), --just carry in
		(X"800000", X"800000", X"000000", '0', '1'), --just carry out
		(X"aaaaaa", X"555555", X"ffffff", '0', '0'), --no carry
		(X"aaaaaa", X"555554", X"ffffff", '1', '0'), --no carry out
		(X"aaaaaa", X"d55555", X"7fffff", '0', '1')  --no carry in
	);


END mn_param_adder_24_8_tb;
 
ARCHITECTURE behavior OF mn_param_adder_24_8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mn_param_adder
	 generic (adder_size : natural;
				sub_adder_size : natural
			);
    PORT(
         A : IN  std_logic_vector(size-1 downto 0);
         B : IN  std_logic_vector(size-1 downto 0);
         Cin : IN  std_logic;
         S : OUT  std_logic_vector(size-1 downto 0);
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(size-1 downto 0) := (others => '0');
   signal B : std_logic_vector(size-1 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(size-1 downto 0);
   signal Cout : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mn_param_adder
	generic map (
				adder_size => size,
				sub_adder_size => sub_size
			)
	PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          S => S,
          Cout => Cout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		for i in test_vectors'range loop
			a <= test_vectors(i).a;
			b <= test_vectors(i).b;
			cin <= test_vectors(i).cin;
			wait for 20 ns; -- multiple of period when sequential
			assert ((s = test_vectors(i).s) and
						(Cout = test_vectors(i).Cout))
			report "Test condition " & integer'image(i) &
						" failed. a = " & integer'image(to_integer(unsigned(a))) &
						", b = " & integer'image(to_integer(unsigned(b))) &
						", cin = " & std_logic'image(cin) &
						". Expected s = " & integer'image(to_integer(unsigned(test_vectors(i).s))) &
						", cout = " & std_logic'image(test_vectors(i).cout) &
						". But got s = " & integer'image(to_integer(unsigned(s))) &
						", cout = " & std_logic'image(cout) &
						"."
			severity error;
		end loop;

      wait;
   end process;

END;

