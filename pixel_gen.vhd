----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:31:46 01/29/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM; 
use UNISIM.VComponents.all;

entity pixel_gen is
    Port ( row : in  unsigned (10 downto 0);
           column : in  unsigned (10 downto 0);
           blank : in  STD_LOGIC;
			  switch_1 : in std_logic;
			  switch_2 : in std_logic;		  
           r : out  STD_LOGIC_VECTOR (7 downto 0);
           g : out  STD_LOGIC_VECTOR (7 downto 0);
           b : out  STD_LOGIC_VECTOR (7 downto 0));
end pixel_gen;

architecture Behavioral of pixel_gen is

begin
process(row, column, blank, switch_1, switch_2)
begin
	if(blank = '0') then
--case 1
	if (switch_1 = '0' and switch_2 = '0') then
		if(row < 400) then
			if(column < 210) then
				r <= (others => '0');
				g <= "11111111";
				b <= (others => '0');
			elsif(column >= 210 and column < 420) then
				r <= (others => '0');
				g <= (others => '0');
				b <= "11111111";
			else
				r <= "11111111";
				g <= (others => '0');
				b <= (others => '0');
			end if;
	else
		r <= "11111111";
		g <= (others => '0');
		b <= "11111111";			
		end if;
	end if;
--case 2
	if (switch_1 = '0' and switch_2 = '0') then
		if(row < 400) then
			if(column < 210) then
				r <= "11111111";
				g <= "11111000";
				b <= (others => '0');
			elsif(column >= 210 and column < 420) then
				r <= (others => '0');
				g <= "00001111";
				b <= "11111111";
			else
				r <= "00001111";
				g <= "00000111";
				b <= "11111100";
			end if;
	else
		r <= "00000111";
		g <= "00000000";
		b <= "11111111";			
		end if;
	end if;
--case 3
	if (switch_1 = '0' and switch_2 = '0') then
		if(row < 400) then
			if(column < 210) then
				r <= "10000000";
				g <= "00000001";
				b <= "00000111";
			elsif(column >= 210 and column < 420) then
				r <= (others => '0');
				g <= (others => '0');
				b <= "11111111";
			else
				r <= "11111111";
				g <= (others => '0');
				b <= (others => '0');
			end if;
	else
		r <= "11111111";
		g <= (others => '0');
		b <= "11111111";			
		end if;
	end if;
--case 4
	if (switch_1 = '0' and switch_2 = '0') then
		if(row < 400) then
			if(column < 210) then
				r <= (others => '0');
				g <= "11111111";
				b <= (others => '0');
			elsif(column >= 210 and column < 420) then
				r <= (others => '0');
				g <= (others => '0');
				b <= "11111111";
			else
				r <= "11111111";
				g <= (others => '0');
				b <= (others => '0');
			end if;
	else
		r <= "00000011";
		g <= (others => '0');
		b <= "00000000";			
		end if;
	end if;	
	
	end if;
end process;

end Behavioral;

