library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter_variables is
    port( sign_mag : in std_logic_vector(3 downto 0) ;
          twos_comp : out std_logic_vector(3 downto 0) );
end converter_variables;

architecture sign_magnitude_var of converter_variables is
 
begin
        converting_process: process (sign_mag)
     
	variable negated_mag,second_comp : std_logic_vector (2 downto 0);
        variable temp_mag : std_logic_vector (3 downto 0); 
        
  
     begin
	 negated_mag := not sign_mag(2 downto 0); --first compliment
         second_comp := negated_mag + "001"; -- second compliment
	 
	 if sign_mag(3) = '0' then
            temp_mag := sign_mag;
	 else
	    temp_mag :=  '1' & second_comp;
	 end if;

	    twos_comp <= temp_mag;
    
      end process;

end sign_magnitude_var; 
