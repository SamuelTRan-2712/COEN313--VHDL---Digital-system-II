library IEEE;
use IEEE.std_logic_1164.all;

entity orgate is
port (i1, i2, i3: in std_logic;
        o1: out std_logic);
end orgate;

architecture or_gate of orgate  is
begin
     	o1 <= i1 or  i2 or i3;
end or_gate;


