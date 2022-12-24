library IEEE;
use IEEE.std_logic_1164.all;

entity sum_of_minterms is
port( a, b, c	: in std_logic;
      output	: out std_logic);
end sum_of_minterms;

architecture sumof_minterms of sum_of_minterms is
   component andgate
      port(
            i1, i2, i3: in std_logic;
	    o1: out std_logic);
   end component;

   component orgate
      port(
	    i1, i2, i3: in std_logic;
            o1: out std_logic);
   end component;

   signal p1, p2, p3: std_logic;
   signal nota, notb, notc: std_logic;

for unit1, unit2, unit3: andgate use entity 
WORK.andgate (and_gate);

for unit4: orgate use entity 
WORK.orgate (or_gate);

begin
   nota <= not a;
   notb <= not b;
   notc <= not c;

   unit1: andgate
      port map (i1 => nota, i2 => notb, i3 => c, o1 => p1);
   unit2: andgate
      port map (i1 => nota, i2	=> b, i3 => c, o1 => p2 );
   unit3: andgate
      port map (i1 => a, i2 => b, i3 =>	c, o1 => p3 );
   unit4: orgate
      port map (i1 => p1, i2 => p2, i3 => p3, o1 => output);
end sumof_minterms;
