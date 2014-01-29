
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity h_sync_gen is
    port ( clk       : in  std_logic;
           reset     : in  std_logic;
           h_sync    : out std_logic;
           blank     : out std_logic;
           completed : out std_logic;
           column    : out unsigned(10 downto 0)
     );
end h_sync_gen;

architecture Behavioral of h_sync_gen is
	type states is (activeVideo, frontPorch, sync, backPorch);
	signal state_reg, state_next: states;
	signal clock_state, clock_next: unsigned(1000);
begin

	-- state register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= activeVideo;
			clock_state <= "0";
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
			clock_state <= clock_next;
      end if;
   end process;
	
	--Next State Logic
	process(clk, clock_state) is
	begin
		if(clk'event and clk='1') then
			clock_next <= clock_state +1;
			state_next <= state_next;
			if(clock_state = 800) then
				state_next <= activeVideo;
				clock_next <= "0";
			elsif(clock_state = 640) then
				state_next <= frontPorch;
			elsif(clock_state = 656) then
				state_next <= sync;
			elsif(clock_state = 752) then
				state_next <= backPorch;
			end if;
		end if;
	end process;
	
	--Output Logic
	h_sync <= '1' when state_reg = sync else
				 '0';
	blank  <= '0' when state_reg = activeVideo else
	          '1';
	column <= clock_state when clock_state < 640 else
				 "000000000";
	completed <= '1' when clock_state = 800 else
					 '0';

end Behavioral;

