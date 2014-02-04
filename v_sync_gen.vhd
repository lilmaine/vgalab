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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity v_sync_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_completed : in  STD_LOGIC;
           v_sync : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           completed : out  STD_LOGIC;
           row : out  unsigned (10 downto 0));
end v_sync_gen;

architecture vlook_ahead_moore of v_sync_gen is
	type state_type is
		(active_video, front_porch, sync, back_porch, completed_state);
	signal count_reg: unsigned(10 downto 0):= "00000000000";
	signal state_reg, state_next: state_type;
	signal vsync_reg, vsync_next, blank_reg, blank_next, completed_reg, completed_next: std_logic;
	signal row_reg, row_next, count_next: unsigned (10 downto 0);


begin
	-- state register
	process(clk, reset)
	begin
		if (reset='1') then
			state_reg <= active_video;
		elsif rising_edge(clk) then
			state_reg <= state_next;
		end if;
	end process;
	
	--output buffer
	process(clk, h_completed)
	begin
		if rising_edge(clk) then
			vsync_reg <= vsync_next;
			blank_reg <=	blank_next;
			completed_reg <= completed_next;
			row_reg <=  row_next;
		end if;
	end process;
	
	count_next <= 	(others => '0') when state_reg /= state_next else 
						count_reg + 1 when h_completed = '1' else
						count_reg;
	
	--count register
	
	process(clk, reset)
	begin
		if (reset ='1') then
			count_reg <= (others => '0');
		elsif rising_edge(clk) then
			count_reg <= count_next;
		end if;
	end process;	
			
	
	--next-state logic
		process(state_reg, count_reg, h_completed)
		begin
			state_next <= state_reg;
			if (h_completed = '1') then
		
			case state_reg is
				when active_video =>
					if (count_reg >= 480) then
						state_next <= front_porch;
					end if;
				when front_porch =>
					if (count_reg >= 10) then
						state_next <= sync;
					end if;
				when sync =>
					if (count_reg >= 2) then
						state_next <= back_porch;
					end if;
				when back_porch =>
					if (count_reg >= 33) then
						state_next <= completed_state;
					end if;				
				when completed_state =>
					state_next <= back_porch;
			end case;		
			end if;
	end process;


	--look ahead output logic
	process(state_next, count_reg)
	begin
			vsync_next <= '1';
			blank_next <=	'1';
			completed_next <= '0';
			row_next <=  (others => '0');
			case state_next is
				when active_video =>
					blank_next <=	'0';
					row_next <= count_reg;
				when front_porch =>
				when sync =>
					vsync_next <= '0';
				when back_porch =>
				when completed_state =>
					completed_next <= '1';
			end case;
	end process;
	--output
	v_sync <= vsync_reg;
	blank <=	blank_reg;
	completed <= completed_reg;
	row <=  row_reg;

end vlook_ahead_moore;
