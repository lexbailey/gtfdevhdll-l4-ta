LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY param_adder_tb IS
END param_adder_tb;
 
ARCHITECTURE behavior OF param_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	 constant size : natural := 8;
 
    COMPONENT param_adder
	 generic (adder_size: natural);
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
   uut: param_adder 
		generic map(adder_size => size)
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

      A <= "01010101";
		B <= "00010001";
		Cin <= '0';

      wait;
   end process;

END;
