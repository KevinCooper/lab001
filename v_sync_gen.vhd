
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity v_sync_gen is
    port ( clk         : in  std_logic;
           reset       : in std_logic;
           h_blank     : in std_logic;
           h_completed : in std_logic;
           v_sync      : out std_logic;
           blank       : out std_logic;
           completed   : out std_logic;
           row         : out unsigned(10 downto 0)
     );
end v_sync_gen;

architecture Cooper of v_sync_gen is
	type states is (activeVideo, frontPorch, sync, backPorch);
	signal state_reg, state_next: states;
	signal clock_state, clock_next: unsigned(1000);
begin

	-- state register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= start;
			clock_state <= unsigned(0);
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
			clock_state <= clock_next;
      end if;
   end process;
	
	--Next State Logic
	process(input, clock_state, h_sync) is
	begin
		state_next <= state_next;
		clock_next <= clock_next;
		if(clock_state = 525) then
			state_next <= activeVideo;
			clock_next <= 0;
		elsif(clock_state = 480) then
			state_next <= frontPorch;
		elsif(clock_state = 490) then
			state_next <= sync;
		elsif(clock_state = 492) then
			state_next <= backPorch;
		end if;
		if(h_completed = '1') then
			clock_next <= clock_state +1;
		end if;
	end process;
	
	--Output Logic
	v_sync <= '1' when state_reg = sync else
				 '0';
	blank  <= '0' when state_reg = activeVideo else
	          '1';
	row <= clock_state when clock_state < 480 else
				 "000000000";
	completed <= '1' when clock_state = 525 else
					 '0';
end Cooper;

