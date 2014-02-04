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
--use IEEE.NUMERIC_STD.ALL;

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
           row : out  STD_LOGIC_VECTOR (10 downto 0);
           column : out  STD_LOGIC_VECTOR (10 downto 0));
end vga_sync;

architecture Behavioral of vga_sync is

	component h_sync_gen
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_sync : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           completed : out  STD_LOGIC;
           column : out  STD_LOGIC_VECTOR (10 downto 0));
	end component;

	component v_sync_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_completed : in  STD_LOGIC;
           v_sync : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           completed : out  STD_LOGIC;
           row : out  STD_LOGIC_VECTOR (10 downto 0));
	end component;

--entity work.v_sync_gen(Behavioral);

signal hsync_sig, hblank_sig, hcompleted_sig, vblank_sig: std_logic_vector;

begin

	Inst_h_sync_gen: entity work.h_sync_gen(Behavioral) PORT MAP(
		clk => clk,
		reset => reset,
		h_sync => h_sync,
		blank => hblank_sig,
		completed => hcompleted_sig,
		column => column
	);

	Inst_v_sync_gen:  entity work.v_sync_gen(Behavioral) PORT MAP(
		clk => clk,
		reset => reset,
		h_completed => hcompleted_sig,
		v_sync => vsync,
		blank => vblank_sig,
		completed => v_completed,
		row => row
	);
	
blank <= vblank_sig or hblank_sig;

end Behavioral;

