-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
-- CREATED		"Sun May 05 17:23:33 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY div_test IS 
	PORT
	(
		z_i_clk :  IN  STD_LOGIC;
		z_i_rstb :  IN  STD_LOGIC;
		z_i_sync_reset :  IN  STD_LOGIC;
		z_i_fcw :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_i_start_phase :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		fpOut :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END div_test;

ARCHITECTURE bdf_type OF div_test IS 

COMPONENT fpdds
	PORT(z_i_clk : IN STD_LOGIC;
		 z_i_rstb : IN STD_LOGIC;
		 z_i_sync_reset : IN STD_LOGIC;
		 z_i_fcw : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 z_i_start_phase : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 fpOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT shift_reg32
	PORT(load : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 shiftout : OUT STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT shift_regin32
	PORT(clock : IN STD_LOGIC;
		 shiftin : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sub32
	PORT(clock : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
SYNTHESIZED_WIRE_0 <= '1';



b2v_inst : fpdds
PORT MAP(z_i_clk => z_i_clk,
		 z_i_rstb => z_i_rstb,
		 z_i_sync_reset => z_i_sync_reset,
		 z_i_fcw => z_i_fcw,
		 z_i_start_phase => z_i_start_phase,
		 fpOut => SYNTHESIZED_WIRE_1);


b2v_inst2 : shift_reg32
PORT MAP(load => SYNTHESIZED_WIRE_0,
		 clock => z_i_clk,
		 data => SYNTHESIZED_WIRE_1,
		 shiftout => SYNTHESIZED_WIRE_2,
		 q => SYNTHESIZED_WIRE_3);


b2v_inst3 : shift_regin32
PORT MAP(clock => z_i_clk,
		 shiftin => SYNTHESIZED_WIRE_2,
		 q => SYNTHESIZED_WIRE_4);


b2v_inst4 : sub32
PORT MAP(clock => z_i_clk,
		 dataa => SYNTHESIZED_WIRE_3,
		 datab => SYNTHESIZED_WIRE_4,
		 result => fpOut);



END bdf_type;