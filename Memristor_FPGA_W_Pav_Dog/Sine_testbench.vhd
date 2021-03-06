library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
entity Sine_testbench is
end entity Sine_testbench;

architecture Test of Sine_testbench is

signal z_i_clk, z_i_rstb,z_i_sync_reset: std_logic;
signal z_i_fcw: std_logic_vector(31 downto 0);
signal R_init: std_logic_vector(31 downto 0);
signal Reset: std_logic;
signal Valid_Vbe,Valid_Vte: std_logic_vector(1 downto 0);
signal I,R: std_logic_vector(31 downto 0);


component memtester is
   port( 
  	z_i_clk, z_i_rstb,z_i_sync_reset: in std_logic;
	z_i_fcw: in  std_logic_vector(31 downto 0);
	R_init: in std_logic_vector(31 downto 0);
	Reset: in std_logic;
	Valid_Vbe,Valid_Vte: in std_logic_vector(1 downto 0);
	I,R: out std_logic_vector(31 downto 0)
);
end component;

begin

dds_proc: memtester
port map (z_i_clk, z_i_rstb,z_i_sync_reset,z_i_fcw,R_init,Reset,Valid_Vte, Valid_Vbe,I, R);
z_i_rstb<='0', '1' after 10 ns; 
z_i_sync_reset<='1', '0' after 12 ns; 
z_i_fcw<=X"000010C6";
R_init<=X"48927c00";
Valid_Vte<="01";
Valid_Vbe<="01";
Reset<='1', '0' after 1300 ns;

--
CLK_PROCESS: process
begin
	z_i_clk<='1';
	wait for 10 ns;
	z_i_clk<='0';
	wait for 10 ns;
end process;

end architecture Test;