library IEEE;
use IEEE.std_logic_1164.all;

entity sum_of_minterms_version_two is
  port( a, b, c	: in std_logic;
        output	: out std_logic);
end sum_of_minterms_version_two;

architecture sumofminterms of sum_of_minterms_version_two is
   signal p1, p2, p3: std_logic;
   signal na, nb, nc: std_logic;

begin

   na <= not a;
   nb <= not b;
   nc <= not c; 

   output <= p1 or p2 or p3;
   p1 <= na and nb and c;
   p2 <= na and b and c;
   p3 <= a and b and c;

end sumofminterms;
