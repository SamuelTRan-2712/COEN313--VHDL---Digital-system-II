library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter is
    port( sign_mag : in std_logic_vector(3 downto 0) ;
          twos_comp : out std_logic_vector(3 downto 0) );
end converter;

architecture sign_magnitude of converter is

signal negated_magnitude,second_compliment: std_logic_vector(2 downto 0); --created 2 signals where negated_magnitude is for the first compliment and second_compliment is for the second compliment
signal temporary_magnitude: std_logic_vector (3 downto 0); --this is tempo since we can't use two_comps to assign outputs in the process cuz it only gets updated after the process.  
 
begin
     converting_process: process (sign_mag,negated_magnitude,second_compliment)
      
     begin
	 
	 negated_magnitude <= not sign_mag(2 downto 0); --first compliment 
	 second_compliment <= negated_magnitude + "001"; -- second compliment
	 
	 if sign_mag(3) = '0' then
            temporary_magnitude <= sign_mag;
	 else
	    temporary_magnitude <=  '1' & second_compliment;
	 end if;

     end process;

twos_comp <= temporary_magnitude; --that's what the temporary_magnitude is for, uhhhhh, I'm goddamn smart =))) 

end sign_magnitude; 
