----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:24:38 01/29/2014 
-- Design Name: 
-- Module Name:    v_sync_gen - Behavioral 
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

entity v_sync_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_blank : in  STD_LOGIC;
           h_completed : in  STD_LOGIC;
           v_sync : in  STD_LOGIC;
           blank : in  STD_LOGIC;
           completed : in  STD_LOGIC;
           row : in  STD_LOGIC_VECTOR (10 downto 0));
end v_sync_gen;

architecture Behavioral of v_sync_gen is

signal count: unsigned(10 downto 0):= "00000000000";
signal count_next: unsigned(10 downto 0);

begin
	count_next <= count + 1;
	row <= count;
	process(reset)
	begin
		if (reset='1') then
			count <= "00000000000";
			v_sync <= '0';
			blank <= '1';
			completed <= '0';
		end if;
	end process;
	
	process (clk, h_completed)
	begin
		if (clk'event and clk='1' and h_completed) then
			if (count < 480) then
				count <= count_next;
				v_sync <= '1';
				blank <= '0';
				completed <= '0';
			elsif (count < 490) then
				count <= count_next;
				v_sync <= '1';
				blank <= '1';
				completed <= '0';
			elsif (count < 492) then
				count <= count_next;
				v_sync <= '0';
				blank <= '1';
				completed <= '0';		
			elsif (count < 524) then
				count <= count_next;
				v_sync <= '1';
				blank <= '1';
				completed <= '0';				
			else 
				count <= count_next;
				v_sync <= '1';
				blank <= '1';
				completed <= '1';					
			end if;	
		end if;
	end process;		

row<= std_logic_vector(count) when count < 480 else "00000000000"; 

end Behavioral;

