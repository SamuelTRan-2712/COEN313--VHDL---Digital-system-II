library IEEE;
use IEEE.std_logic_1164.all;

entity andgate is
port (i1, i2, i3: in std_logic;
	o1: out std_logic);
end andgate;

architecture and_gate of andgate  is 
begin 
	o1 <= i1 and i2 and i3;
end and_gate;
