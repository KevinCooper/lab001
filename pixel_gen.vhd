
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pixel_gen is
    port ( row      : in unsigned(10 downto 0);
           column   : in unsigned(10 downto 0);
           blank    : in std_logic;
           r        : out std_logic_vector(7 downto 0);
           g        : out std_logic_vector(7 downto 0);
           b        : out std_logic_vector(7 downto 0));
end pixel_gen;

architecture Cooper of pixel_gen is

begin


--output logic
r<="00000000" when blank='1' else
	"11111111"; --when column <"01000000" and row<"10000000" else
	--(others=>'1') when row>"10000000" else
	--(others=>'0');
	
g<="00000000";--(others=>'1') when column >"01000000" and column<"10000000" and row<"10000000" else
	--"01000000" when row>"10000000" else
	--(others=>'0');
	
b<="00000000";--(others=>'1') when column >"10000000" and row<"10000000" else
	--(others=>'0');



end Cooper;

