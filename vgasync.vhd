----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:08 01/29/2014 
-- Design Name: 
-- Module Name:    h_sync_gen - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity h_sync_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_sync : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           completed : out  STD_LOGIC;
           column : out  STD_LOGIC_VECTOR (10 downto 0));
end h_sync_gen;

architecture Behavioral of h_sync_gen is

signal count: unsigned(10 downto 0):= "00000000000";
signal count_next: unsigned(10 downto 0);

begin
	count_next <= count + 1;
	column <= count;
	process(clk, reset)
	begin
		if (reset='1') then
			count <= "00000000000";
		elsif (clk'event and clk='1') then
			if (count < 640) then
				count <= count_next;
				h_sync <= '1';
				blank <= '0';
				completed <= '0';
			elsif (count < 656) then
				count <= count_next;
				h_sync <= '1';
				blank <= '1';
				completed <= '0';
			elsif (count < 752) then
				count <= count_next;
				h_sync <= '0';
				blank <= '1';
				completed <= '0';		
			elsif (count < 799) then
				count <= count_next;
				h_sync <= '1';
				blank <= '1';
				completed <= '0';				
			else 
				count <= count_next;
				h_sync <= '1';
				blank <= '1';
				completed <= '1';					
			end if;	
		end if;	
	end process;

column <= std_logic_vector(count) when count < 640 else "00000000000"; 

end Behavioral;

