library ieee;
use ieee.std_logic_1164.all;


entity adder_tb is
end adder_tb;

architecture behav of adder_tb is

	component adder
		port(i0, i1 : in std_logic;
		ci : in std_logic;
		s: out std_logic;
		co : out std_logic);
	end component;

	for adder_0: adder use entity work.adder;
	signal i0, i1, ci, s, co : std_logic;

	begin
--  Component instantiation.
    adder_0: adder port map (i0 => i0, i1 => i1, ci => ci,
                             s => s, co => co);
 
    --  This process does the real job.
    process
       type pattern_type is record
          --  The inputs of the adder.
          i0, i1, ci : std_logic;
          --  The expected outputs of the adder.
          s, co : std_logic;
       end record;
       --  The patterns to apply.
       type pattern_array is array (natural range <>) of pattern_type;
       constant patterns : pattern_array :=
         (('0', '0', '0', '0', '0'),
          ('0', '0', '1', '1', '0'),
          ('0', '1', '0', '1', '0'),
          ('0', '1', '1', '0', '1'),
          ('1', '0', '0', '1', '0'),
          ('1', '0', '1', '0', '1'),
          ('1', '1', '0', '0', '1'),
          ('1', '1', '1', '1', '1'));
    begin
       --  Check each pattern.
       for i in patterns'range loop
          --  Set the inputs.
          i0 <= patterns(i).i0;
          i1 <= patterns(i).i1;
          ci <= patterns(i).ci;
          --  Wait for the results.
          wait for 1 ns;
          --  Check the outputs.
          assert s = patterns(i).s
             report "bad sum value" severity error;
          assert co = patterns(i).co
             report "bad carray out value" severity error;
       end loop;
       assert false report "end of test" severity note;
       --  Wait forever; this will finish the simulation.
       wait;
    end process;
end behav;
