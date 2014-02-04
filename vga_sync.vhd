
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity vga_sync is
    port ( clk         : in  std_logic;
           reset       : in  std_logic;
           h_sync      : out std_logic;
           v_sync      : out std_logic;
           v_completed : out std_logic;
           blank       : out std_logic;
           row         : out unsigned(10 downto 0);
           column      : out unsigned(10 downto 0)
     );
end vga_sync;


architecture Cooper of vga_sync is

component v_sync_gen
    port ( clk         : in  std_logic;
           reset       : in std_logic;
           h_blank     : in std_logic;
           h_completed : in std_logic;
           v_sync      : out std_logic;
           blank       : out std_logic;
           completed   : out std_logic;
           row         : out unsigned(10 downto 0)
     );
end component;

component h_sync_gen
    port ( clk       : in  std_logic;
           reset     : in  std_logic;
           h_sync    : out std_logic;
           blank     : out std_logic;
           completed : out std_logic;
           column    : out unsigned(10 downto 0)
     );
end component;

signal wire_hsync, wire_vsync, wire_vcompleted: std_logic;
signal wire_vblank, wire_hblank: std_logic;
signal wire_hcompleted: std_logic;
begin

	my_v : v_sync_gen port map
	(
	clk=> clk,
	reset=>reset,
	h_blank=>wire_hblank,
	h_completed=>wire_hcompleted,
	v_sync=>v_sync,
	blank=>wire_vblank,
	completed=>v_completed,
	row=>row
	);
	
	my_h : h_sync_gen port map
	(
	clk=> clk,
	reset=>reset,
	h_sync=>h_sync,
	blank=>wire_hblank,
	completed=>wire_hcompleted,
	column=>column
	);

--output signals
blank <= '1' when wire_hblank='1' or wire_vblank='1'
			else '0';

end Cooper;

