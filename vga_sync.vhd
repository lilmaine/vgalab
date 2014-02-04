----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:15 01/29/2014 
-- Design Name: 
-- Module Name:    vga_sync - Behavioral 
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

entity vga_sync is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_sync : out  STD_LOGIC;
           v_sync : out  STD_LOGIC;
           v_completed : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           row : out  unsigned (10 downto 0);
           column : out  unsigned (10 downto 0));
end vga_sync;

architecture Behavioral of vga_sync is

signal hblank_sig, hcompleted_sig, vblank_sig: std_logic;

begin

	Inst_h_sync_gen: entity work.h_sync_gen(look_ahead_moore) PORT MAP(
		clk => clk,
		reset => reset,
		h_sync => h_sync,
		blank => hblank_sig,
		completed => hcompleted_sig,
		column => column
	);

	Inst_v_sync_gen:  entity work.v_sync_gen(vlook_ahead_moore) PORT MAP(
		clk => clk,
		reset => reset,
		h_completed => hcompleted_sig,
		v_sync => v_sync,
		blank => vblank_sig,
		completed => v_completed,
		row => row
	);
	
blank <= vblank_sig or hblank_sig;

end Behavioral;

