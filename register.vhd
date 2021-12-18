library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity registers_min_max is
port(   din: in std_logic_vector (3 downto 0);
	reset: in std_logic;
	clk: in std_logic;
	sel: in std_logic_vector (1 downto 0);
	max_out: out std_logic_vector (3 downto 0);
	min_out: out std_logic_vector (3 downto 0);
	reg_out: out std_logic_vector (3 downto 0));
end registers_min_max;

architecture saM_da_beast of registers_min_max is

signal R0, R1, R2, R3, nextstate_min, nextstate_max, max_register, min_register: std_logic_vector (3 downto 0);  
signal load_input_max_register, load_input_min_register: std_logic; 

begin

process_to_take_data_in: process(clk, reset)
	begin
		if (reset = '1') then
		   R0 <= "1000";
		   R1 <= "1000";
		   R2 <= "1000"; 	
		   R3 <= "1000";
		elsif (rising_edge(clk)) then
		   R0 <= din;
		   R1 <= R0;
		   R2 <= R1;
		   R3 <= R2; 
	end if;
end process;

process_to_compare_four_registers: process(R0, R1, R2, R3)
	begin
		if (R0 >= R1 and R0 >= R2 and R0 >= R3) then
		   nextstate_max <= R0;
		elsif (R1 >= R0 and R1 >= R2 and R1 >=	R3) then
   		   nextstate_max <= R1;
		elsif (R2 >= R0 and R2 >= R1 and R2 >=	R3) then
		   nextstate_max <= R2;
		else
		   nextstate_max <= R3;
		end if;

	 
                if (R1 >= R0 and R2 >= R0 and R3 >= R0) then
                   nextstate_min <= R0;
                elsif (R0 >= R1 and R2 >= R1 and R3 >= R1) then
   	           nextstate_min <= R1;
                elsif (R0 >= R2 and R1 >= R2 and R3 >= R2) then
                   nextstate_min <= R2;
                else
                   nextstate_min <= R3;
                end if;
end process;

load_input_process:process (clk, reset, max_register, min_register)
	begin
		
		if (nextstate_max >= max_register) then
		   load_input_max_register <= '1'; 
		else
		   load_input_max_register <= '0';
		end if;
		
		if(min_register >= nextstate_min) then
		   load_input_min_register <= '1';
		else
		   load_input_min_register <= '0';
		end if;
end process;
		   

process_to_determine_max_min_registers: process(clk, reset)
	begin
		if (reset = '1') then
		   max_register <= "1000";
		   min_register <= "1000";
		
		elsif (rising_edge(clk)) then
		   
		      if (load_input_max_register = '1') then
			
			if (load_input_min_register = '1') then
			  max_register <= nextstate_max;
			  min_register <= nextstate_min;

		        else
                          max_register <= nextstate_max;
                          min_register <= min_register;
		       end if;
		
		     elsif (load_input_max_register = '0' and load_input_min_register = '1') then
			max_register <= max_register;                        
			min_register <= nextstate_min;
                      
       		     else
       	       	       	max_register <= max_register;
			min_register <=	min_register;
                     end if;

		else 
		   max_register <= max_register;
		   min_register <= min_register;
		end if; 

end process;
max_out <= max_register;
min_out <= min_register;

process_to_display_using_mux: process(R0, R1, R2, R3, sel)
	begin
		if (sel = "00") then
		   reg_out <= R0;
		elsif (sel = "01") then
		   reg_out <= R1;
		elsif (sel = "10") then
		   reg_out <= R2;
		else
		   reg_out <= R3;
	end if;
end process;
end saM_da_beast;
