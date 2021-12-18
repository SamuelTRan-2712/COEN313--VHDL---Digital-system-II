library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity twos_complementer is
  port( din : in std_logic_vector(7 downto 0);
        reset : in std_logic ;
        clk : in std_logic ;
        done_out : out std_logic ;
        counter_out : out std_logic_vector(2 downto 0);
        reg_out : out std_logic_vector(7 downto 0));
end twos_complementer ;

architecture twos_complementer_behav of twos_complementer is

  --states
type state_type is (initial, start, loading, check_lsb, check_flip, lsb_0, lsb_1, invert, finish);
signal state : state_type;

--signals
signal set, d, shift, load, inc, clr, ld_done, clr_done, flip : std_logic;
signal counter : std_logic_vector(2 downto 0);
signal shift_register, temp_reg : std_logic_vector(7 downto 0);

begin
  process(reset, clk, counter, shift_register) --control unit
  begin
      if (reset = '1') then
          --reset
          counter <= "000";
          state <= initial;
      elsif (reset = '0' and rising_edge(clk)) then
            case state is
               
              when initial =>
                   set <= '1';
                   state <= start;

              
              when start =>
                  --initialize signals
                   load <= '1';
                   shift <= '0';
                   inc <= '0';
                   clr <= '1';
                   ld_done <= '0';
                   clr_done <= '1';
                   flip <= '0';
                   state <= loading;

              when loading =>
                   shift <= '0';
                   load <= '0';
                   clr <= '0';
                   clr_done <= '0';
                      
                   --check counter
                   if (counter = "111") then
                       state <= finish;
                   else
                       if (flip = '1') then
                       state <= check_flip;
                       else
                       state <= check_lsb;
                       end if;
                   end if;

              when check_lsb =>
                    inc <= '1';
                    --check least significant bit
                    if (shift_register(0) = '1') then
                        state <= lsb_1;
                    else
                        state <= lsb_0;
                    end if;

              when check_flip =>
                    inc <= '1';
                    state <= invert;

              when lsb_0 =>
                    d <= shift_register(0);
                    inc <= '0';
                    shift <= '1';
                    state <= loading;

             when lsb_1 =>
                  d <= shift_register(0);
                  inc <= '0';
                  shift <= '1';
                  flip <= '1';
                  state <= loading;

             when invert =>
                  d <= not(shift_register(0));
                  inc <= '0';
                  shift <= '1';
                  state <= loading;

            when finish =>
                  ld_done <= '1';
                  done_out <= '1';

            when others =>
            --
          end case;
    else
      --nothing
    end if;
  end process;

  process (clk, inc, clr) --counter
  begin
      --reset
      if (set = '1') then
          counter <= "000";
      end if;

       --clear counter
      if (clr = '1') then
          counter <= "000";
           clr <='0';
      else
         -- nothing
      end if;
      
      -- increment counter
      if (inc = '1') then
          counter <= std_logic_vector(unsigned(counter) + 1);
      else
         --nothing
      end if;
  end process;

  counter_out <= counter;

  process (clk, din, d, shift, load) -- shift register
  begin
        --reset
        if (set = '1') then
            shift_register <= "00000000";
        end if;

        --load shift register
        if (load = '1') then
            shift_register <= din;
            load <= '0';
        else
            -- nothing
        end if;

        -- shift bits
        if (shift ='1') then
            temp_reg <= shift_register(6 downto 1) & d & shift_register(7);
        else
            --nothing
        end if;
  end process;

  reg_out <= not (temp_reg);

  process (clk, clr_done, ld_done) -- done FF
  begin
        --clear done output
        if (clr_done = '1') then
            done_out <= '0';
            clr_done <= '0';
        else
            -- nothing
        end if;
    end process;
end architecture;
