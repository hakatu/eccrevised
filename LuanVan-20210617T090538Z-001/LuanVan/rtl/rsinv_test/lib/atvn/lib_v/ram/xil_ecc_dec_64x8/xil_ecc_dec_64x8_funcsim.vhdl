-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Tue Aug 25 15:50:30 2015
-- Host        : linuxsrv13 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Share4Syn/Thalassa/Cisco/VU190_SYN_15.2_8SLICE_150824/Synthesis/AF6CCI0011_VU190.srcs/sources_1/ip/xil_ecc_dec_64x8/xil_ecc_dec_64x8_funcsim.vhdl
-- Design      : xil_ecc_dec_64x8
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcvu190-flgb2104-2-i-es2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_dec_64x8_ecc_v2_0_reg_stage is
  port (
    D : out STD_LOGIC_VECTOR ( 81 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_correct_n : in STD_LOGIC_VECTOR ( 72 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_dec_64x8_ecc_v2_0_reg_stage : entity is "ecc_v2_0_reg_stage";
end xil_ecc_dec_64x8_ecc_v2_0_reg_stage;

architecture STRUCTURE of xil_ecc_dec_64x8_ecc_v2_0_reg_stage is
  signal \^d\ : STD_LOGIC_VECTOR ( 81 downto 0 );
  signal \data_out[72]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[72]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[72]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[72]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[72]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[72]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[73]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[73]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[73]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[73]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[74]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[74]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[74]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[74]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[74]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[75]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[75]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[75]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[75]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[76]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[76]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[76]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[76]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_10_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_8_n_0\ : STD_LOGIC;
  signal \data_out[77]_i_9_n_0\ : STD_LOGIC;
  signal \data_out[78]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_8_n_0\ : STD_LOGIC;
  signal \data_out[79]_i_9_n_0\ : STD_LOGIC;
  signal \data_out[80]_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_out[74]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \data_out[79]_i_8\ : label is "soft_lutpair0";
begin
  D(81 downto 0) <= \^d\(81 downto 0);
\data_out[72]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \data_out[72]_i_2_n_0\,
      I1 => \data_out[72]_i_3_n_0\,
      I2 => \data_out[72]_i_4_n_0\,
      I3 => \data_out[72]_i_5_n_0\,
      I4 => \data_out[72]_i_6_n_0\,
      O => \^d\(72)
    );
\data_out[72]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(13),
      I1 => \^d\(8),
      I2 => \^d\(15),
      I3 => \^d\(19),
      I4 => \^d\(38),
      I5 => \^d\(30),
      O => \data_out[72]_i_2_n_0\
    );
\data_out[72]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(23),
      I1 => \^d\(17),
      I2 => \^d\(21),
      I3 => \^d\(36),
      I4 => \^d\(40),
      I5 => \^d\(32),
      O => \data_out[72]_i_3_n_0\
    );
\data_out[72]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(54),
      I2 => \^d\(52),
      I3 => \^d\(4),
      I4 => \^d\(6),
      I5 => \^d\(10),
      O => \data_out[72]_i_4_n_0\
    );
\data_out[72]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(48),
      I1 => \^d\(46),
      I2 => \^d\(44),
      I3 => \^d\(42),
      I4 => \^d\(34),
      I5 => \^d\(25),
      O => \data_out[72]_i_5_n_0\
    );
\data_out[72]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(0),
      I1 => \^d\(1),
      I2 => \^d\(3),
      I3 => \^d\(56),
      I4 => \^d\(63),
      I5 => \data_out[72]_i_7_n_0\,
      O => \data_out[72]_i_6_n_0\
    );
\data_out[72]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(28),
      I1 => \^d\(59),
      I2 => \^d\(61),
      I3 => \^d\(11),
      I4 => \^d\(26),
      I5 => \^d\(57),
      O => \data_out[72]_i_7_n_0\
    );
\data_out[73]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[77]_i_2_n_0\,
      I1 => \data_out[73]_i_2_n_0\,
      I2 => \data_out[74]_i_3_n_0\,
      I3 => \data_out[73]_i_3_n_0\,
      I4 => \data_out[73]_i_4_n_0\,
      I5 => \data_out[73]_i_5_n_0\,
      O => \^d\(73)
    );
\data_out[73]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(31),
      I1 => \^d\(35),
      I2 => \^d\(12),
      I3 => \^d\(27),
      I4 => \^d\(58),
      I5 => \^d\(62),
      O => \data_out[73]_i_2_n_0\
    );
\data_out[73]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(59),
      I1 => \^d\(0),
      I2 => \^d\(3),
      I3 => \^d\(63),
      I4 => \^d\(5),
      I5 => \^d\(43),
      O => \data_out[73]_i_3_n_0\
    );
\data_out[73]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(6),
      I1 => \^d\(44),
      I2 => \^d\(36),
      I3 => \^d\(32),
      I4 => \^d\(13),
      I5 => \^d\(28),
      O => \data_out[73]_i_4_n_0\
    );
\data_out[73]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(2),
      I1 => \data_out[77]_i_9_n_0\,
      I2 => \data_out[79]_i_9_n_0\,
      I3 => \data_out[79]_i_2_n_0\,
      I4 => \data_out[77]_i_10_n_0\,
      I5 => \data_out[79]_i_3_n_0\,
      O => \data_out[73]_i_5_n_0\
    );
\data_out[74]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[77]_i_4_n_0\,
      I1 => \data_out[74]_i_2_n_0\,
      I2 => \data_out[74]_i_3_n_0\,
      I3 => \data_out[74]_i_4_n_0\,
      I4 => \data_out[74]_i_5_n_0\,
      I5 => \data_out[74]_i_6_n_0\,
      O => \^d\(74)
    );
\data_out[74]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(2),
      I1 => \^d\(45),
      I2 => \^d\(37),
      I3 => \^d\(29),
      I4 => \^d\(7),
      I5 => \^d\(14),
      O => \data_out[74]_i_2_n_0\
    );
\data_out[74]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^d\(25),
      I1 => \^d\(24),
      I2 => \^d\(56),
      I3 => \^d\(55),
      O => \data_out[74]_i_3_n_0\
    );
\data_out[74]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(61),
      I1 => \^d\(1),
      I2 => \^d\(3),
      I3 => \^d\(63),
      I4 => \^d\(31),
      I5 => \^d\(62),
      O => \data_out[74]_i_4_n_0\
    );
\data_out[74]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(46),
      I1 => \^d\(32),
      I2 => \^d\(8),
      I3 => \^d\(15),
      I4 => \^d\(38),
      I5 => \^d\(30),
      O => \data_out[74]_i_5_n_0\
    );
\data_out[74]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(60),
      I1 => \data_out[77]_i_9_n_0\,
      I2 => \data_out[79]_i_2_n_0\,
      I3 => \data_out[79]_i_4_n_0\,
      I4 => \data_out[77]_i_10_n_0\,
      I5 => \data_out[79]_i_3_n_0\,
      O => \data_out[74]_i_6_n_0\
    );
\data_out[75]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[75]_i_2_n_0\,
      I1 => \data_out[75]_i_3_n_0\,
      O => \^d\(75)
    );
\data_out[75]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[79]_i_3_n_0\,
      I1 => \data_out[77]_i_2_n_0\,
      I2 => \data_out[77]_i_4_n_0\,
      I3 => \data_out[74]_i_3_n_0\,
      I4 => \data_out[75]_i_4_n_0\,
      I5 => \data_out[75]_i_5_n_0\,
      O => \data_out[75]_i_2_n_0\
    );
\data_out[75]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(4),
      I2 => \^d\(6),
      I3 => \^d\(34),
      I4 => \^d\(36),
      I5 => \^d\(8),
      O => \data_out[75]_i_3_n_0\
    );
\data_out[75]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(18),
      I1 => \^d\(33),
      I2 => \^d\(49),
      I3 => \data_out[77]_i_9_n_0\,
      I4 => \data_out[79]_i_9_n_0\,
      I5 => \data_out[79]_i_4_n_0\,
      O => \data_out[75]_i_4_n_0\
    );
\data_out[75]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(19),
      I1 => \^d\(38),
      I2 => \^d\(5),
      I3 => \^d\(35),
      I4 => \^d\(37),
      I5 => \^d\(7),
      O => \data_out[75]_i_5_n_0\
    );
\data_out[76]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[76]_i_2_n_0\,
      I1 => \data_out[76]_i_3_n_0\,
      O => \^d\(76)
    );
\data_out[76]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[77]_i_10_n_0\,
      I1 => \data_out[77]_i_2_n_0\,
      I2 => \data_out[77]_i_4_n_0\,
      I3 => \data_out[74]_i_3_n_0\,
      I4 => \data_out[76]_i_4_n_0\,
      I5 => \data_out[76]_i_5_n_0\,
      O => \data_out[76]_i_2_n_0\
    );
\data_out[76]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(46),
      I2 => \^d\(44),
      I3 => \^d\(42),
      I4 => \^d\(13),
      I5 => \^d\(15),
      O => \data_out[76]_i_3_n_0\
    );
\data_out[76]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(18),
      I1 => \^d\(49),
      I2 => \^d\(41),
      I3 => \data_out[79]_i_9_n_0\,
      I4 => \data_out[79]_i_2_n_0\,
      I5 => \data_out[79]_i_4_n_0\,
      O => \data_out[76]_i_4_n_0\
    );
\data_out[76]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(19),
      I1 => \^d\(11),
      I2 => \^d\(43),
      I3 => \^d\(12),
      I4 => \^d\(45),
      I5 => \^d\(14),
      O => \data_out[76]_i_5_n_0\
    );
\data_out[77]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[77]_i_2_n_0\,
      I1 => \data_out[77]_i_3_n_0\,
      I2 => \data_out[77]_i_4_n_0\,
      I3 => \data_out[77]_i_5_n_0\,
      I4 => \data_out[77]_i_6_n_0\,
      I5 => \data_out[77]_i_7_n_0\,
      O => \^d\(77)
    );
\data_out[77]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(47),
      I1 => \^d\(48),
      O => \data_out[77]_i_10_n_0\
    );
\data_out[77]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(51),
      I1 => \^d\(52),
      O => \data_out[77]_i_2_n_0\
    );
\data_out[77]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(31),
      I1 => \^d\(35),
      I2 => \^d\(27),
      I3 => \^d\(45),
      I4 => \^d\(37),
      I5 => \^d\(29),
      O => \data_out[77]_i_3_n_0\
    );
\data_out[77]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(53),
      I1 => \^d\(54),
      O => \data_out[77]_i_4_n_0\
    );
\data_out[77]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(32),
      I1 => \^d\(38),
      I2 => \^d\(30),
      I3 => \^d\(28),
      I4 => \^d\(26),
      I5 => \^d\(43),
      O => \data_out[77]_i_5_n_0\
    );
\data_out[77]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(46),
      I2 => \^d\(44),
      I3 => \^d\(42),
      I4 => \^d\(34),
      I5 => \^d\(36),
      O => \data_out[77]_i_6_n_0\
    );
\data_out[77]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(33),
      I1 => \^d\(49),
      I2 => \^d\(41),
      I3 => \data_out[77]_i_8_n_0\,
      I4 => \data_out[77]_i_9_n_0\,
      I5 => \data_out[77]_i_10_n_0\,
      O => \data_out[77]_i_7_n_0\
    );
\data_out[77]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(55),
      I1 => \^d\(56),
      O => \data_out[77]_i_8_n_0\
    );
\data_out[77]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(39),
      I1 => \^d\(40),
      O => \data_out[77]_i_9_n_0\
    );
\data_out[78]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[78]_i_2_n_0\,
      I1 => \^d\(60),
      O => \^d\(78)
    );
\data_out[78]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(59),
      I1 => \^d\(61),
      I2 => \^d\(57),
      I3 => \^d\(63),
      I4 => \^d\(58),
      I5 => \^d\(62),
      O => \data_out[78]_i_2_n_0\
    );
\data_out[79]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[79]_i_2_n_0\,
      I1 => \data_out[79]_i_3_n_0\,
      I2 => \data_out[79]_i_4_n_0\,
      I3 => \data_out[79]_i_5_n_0\,
      I4 => \data_out[79]_i_6_n_0\,
      I5 => \data_out[79]_i_7_n_0\,
      O => \^d\(79)
    );
\data_out[79]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(16),
      I1 => \^d\(17),
      O => \data_out[79]_i_2_n_0\
    );
\data_out[79]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(9),
      I1 => \^d\(10),
      O => \data_out[79]_i_3_n_0\
    );
\data_out[79]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(22),
      I1 => \^d\(23),
      O => \data_out[79]_i_4_n_0\
    );
\data_out[79]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(4),
      I1 => \^d\(6),
      I2 => \^d\(13),
      I3 => \^d\(8),
      I4 => \^d\(15),
      I5 => \^d\(19),
      O => \data_out[79]_i_5_n_0\
    );
\data_out[79]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(11),
      I1 => \^d\(0),
      I2 => \^d\(1),
      I3 => \^d\(3),
      I4 => \^d\(5),
      I5 => \^d\(12),
      O => \data_out[79]_i_6_n_0\
    );
\data_out[79]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(2),
      I1 => \^d\(7),
      I2 => \^d\(14),
      I3 => \^d\(18),
      I4 => \data_out[79]_i_8_n_0\,
      I5 => \data_out[79]_i_9_n_0\,
      O => \data_out[79]_i_7_n_0\
    );
\data_out[79]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(24),
      I1 => \^d\(25),
      O => \data_out[79]_i_8_n_0\
    );
\data_out[79]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(20),
      I1 => \^d\(21),
      O => \data_out[79]_i_9_n_0\
    );
\data_out[80]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[80]_i_2_n_0\,
      I1 => \^d\(66),
      O => \^d\(80)
    );
\data_out[80]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(67),
      I1 => \^d\(68),
      I2 => \^d\(65),
      I3 => \^d\(69),
      I4 => \^d\(71),
      I5 => \^d\(70),
      O => \data_out[80]_i_2_n_0\
    );
\data_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(0),
      Q => \^d\(0),
      R => ecc_reset
    );
\data_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(10),
      Q => \^d\(10),
      R => ecc_reset
    );
\data_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(11),
      Q => \^d\(11),
      R => ecc_reset
    );
\data_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(12),
      Q => \^d\(12),
      R => ecc_reset
    );
\data_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(13),
      Q => \^d\(13),
      R => ecc_reset
    );
\data_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(14),
      Q => \^d\(14),
      R => ecc_reset
    );
\data_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(15),
      Q => \^d\(15),
      R => ecc_reset
    );
\data_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(16),
      Q => \^d\(16),
      R => ecc_reset
    );
\data_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(17),
      Q => \^d\(17),
      R => ecc_reset
    );
\data_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(18),
      Q => \^d\(18),
      R => ecc_reset
    );
\data_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(19),
      Q => \^d\(19),
      R => ecc_reset
    );
\data_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(1),
      Q => \^d\(1),
      R => ecc_reset
    );
\data_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(20),
      Q => \^d\(20),
      R => ecc_reset
    );
\data_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(21),
      Q => \^d\(21),
      R => ecc_reset
    );
\data_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(22),
      Q => \^d\(22),
      R => ecc_reset
    );
\data_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(23),
      Q => \^d\(23),
      R => ecc_reset
    );
\data_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(24),
      Q => \^d\(24),
      R => ecc_reset
    );
\data_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(25),
      Q => \^d\(25),
      R => ecc_reset
    );
\data_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(26),
      Q => \^d\(26),
      R => ecc_reset
    );
\data_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(27),
      Q => \^d\(27),
      R => ecc_reset
    );
\data_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(28),
      Q => \^d\(28),
      R => ecc_reset
    );
\data_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(29),
      Q => \^d\(29),
      R => ecc_reset
    );
\data_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(2),
      Q => \^d\(2),
      R => ecc_reset
    );
\data_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(30),
      Q => \^d\(30),
      R => ecc_reset
    );
\data_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(31),
      Q => \^d\(31),
      R => ecc_reset
    );
\data_out_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(32),
      Q => \^d\(32),
      R => ecc_reset
    );
\data_out_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(33),
      Q => \^d\(33),
      R => ecc_reset
    );
\data_out_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(34),
      Q => \^d\(34),
      R => ecc_reset
    );
\data_out_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(35),
      Q => \^d\(35),
      R => ecc_reset
    );
\data_out_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(36),
      Q => \^d\(36),
      R => ecc_reset
    );
\data_out_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(37),
      Q => \^d\(37),
      R => ecc_reset
    );
\data_out_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(38),
      Q => \^d\(38),
      R => ecc_reset
    );
\data_out_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(39),
      Q => \^d\(39),
      R => ecc_reset
    );
\data_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(3),
      Q => \^d\(3),
      R => ecc_reset
    );
\data_out_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(40),
      Q => \^d\(40),
      R => ecc_reset
    );
\data_out_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(41),
      Q => \^d\(41),
      R => ecc_reset
    );
\data_out_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(42),
      Q => \^d\(42),
      R => ecc_reset
    );
\data_out_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(43),
      Q => \^d\(43),
      R => ecc_reset
    );
\data_out_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(44),
      Q => \^d\(44),
      R => ecc_reset
    );
\data_out_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(45),
      Q => \^d\(45),
      R => ecc_reset
    );
\data_out_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(46),
      Q => \^d\(46),
      R => ecc_reset
    );
\data_out_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(47),
      Q => \^d\(47),
      R => ecc_reset
    );
\data_out_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(48),
      Q => \^d\(48),
      R => ecc_reset
    );
\data_out_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(49),
      Q => \^d\(49),
      R => ecc_reset
    );
\data_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(4),
      Q => \^d\(4),
      R => ecc_reset
    );
\data_out_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(50),
      Q => \^d\(50),
      R => ecc_reset
    );
\data_out_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(51),
      Q => \^d\(51),
      R => ecc_reset
    );
\data_out_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(52),
      Q => \^d\(52),
      R => ecc_reset
    );
\data_out_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(53),
      Q => \^d\(53),
      R => ecc_reset
    );
\data_out_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(54),
      Q => \^d\(54),
      R => ecc_reset
    );
\data_out_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(55),
      Q => \^d\(55),
      R => ecc_reset
    );
\data_out_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(56),
      Q => \^d\(56),
      R => ecc_reset
    );
\data_out_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(57),
      Q => \^d\(57),
      R => ecc_reset
    );
\data_out_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(58),
      Q => \^d\(58),
      R => ecc_reset
    );
\data_out_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(59),
      Q => \^d\(59),
      R => ecc_reset
    );
\data_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(5),
      Q => \^d\(5),
      R => ecc_reset
    );
\data_out_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(60),
      Q => \^d\(60),
      R => ecc_reset
    );
\data_out_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(61),
      Q => \^d\(61),
      R => ecc_reset
    );
\data_out_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(62),
      Q => \^d\(62),
      R => ecc_reset
    );
\data_out_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(63),
      Q => \^d\(63),
      R => ecc_reset
    );
\data_out_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(64),
      Q => \^d\(64),
      R => ecc_reset
    );
\data_out_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(65),
      Q => \^d\(65),
      R => ecc_reset
    );
\data_out_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(66),
      Q => \^d\(66),
      R => ecc_reset
    );
\data_out_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(67),
      Q => \^d\(67),
      R => ecc_reset
    );
\data_out_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(68),
      Q => \^d\(68),
      R => ecc_reset
    );
\data_out_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(69),
      Q => \^d\(69),
      R => ecc_reset
    );
\data_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(6),
      Q => \^d\(6),
      R => ecc_reset
    );
\data_out_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(70),
      Q => \^d\(70),
      R => ecc_reset
    );
\data_out_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(71),
      Q => \^d\(71),
      R => ecc_reset
    );
\data_out_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(72),
      Q => \^d\(81),
      R => ecc_reset
    );
\data_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(7),
      Q => \^d\(7),
      R => ecc_reset
    );
\data_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(8),
      Q => \^d\(8),
      R => ecc_reset
    );
\data_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_correct_n(9),
      Q => \^d\(9),
      R => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0\ is
  port (
    D : out STD_LOGIC_VECTOR ( 65 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    \data_out_reg[72]_0\ : in STD_LOGIC_VECTOR ( 81 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0\ : entity is "ecc_v2_0_reg_stage";
end \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0\;

architecture STRUCTURE of \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0\ is
  signal \data_out[17]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[25]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[35]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[36]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[41]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[42]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[42]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[48]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[50]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[50]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[51]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[52]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[52]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[55]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[56]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[56]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[56]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[56]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[58]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[59]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[61]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[62]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[63]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[63]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_5_n_0\ : STD_LOGIC;
  signal \data_out_reg_n_0_[0]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[10]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[11]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[12]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[13]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[14]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[15]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[16]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[17]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[18]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[19]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[1]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[20]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[21]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[22]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[23]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[24]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[25]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[26]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[27]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[28]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[29]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[2]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[30]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[31]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[32]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[33]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[34]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[35]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[36]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[37]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[38]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[39]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[3]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[40]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[41]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[42]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[43]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[44]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[45]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[46]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[47]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[48]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[49]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[4]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[50]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[51]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[52]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[53]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[54]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[55]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[56]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[57]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[58]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[59]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[5]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[60]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[61]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[62]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[63]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[64]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[65]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[66]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[67]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[68]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[69]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[6]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[70]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[71]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[7]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[80]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[81]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[8]\ : STD_LOGIC;
  signal \data_out_reg_n_0_[9]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal syndrome_pipe : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \syndrome_pipe__0\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal xor_bits_0_25_pipe : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_out[0]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \data_out[12]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \data_out[13]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \data_out[17]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \data_out[20]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \data_out[21]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \data_out[25]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \data_out[28]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \data_out[36]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \data_out[41]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \data_out[42]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \data_out[43]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \data_out[44]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \data_out[48]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \data_out[50]_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \data_out[51]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \data_out[52]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \data_out[52]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \data_out[56]_i_3\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \data_out[56]_i_5\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \data_out[58]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \data_out[59]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \data_out[61]_i_4\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \data_out[61]_i_6\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \data_out[62]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \data_out[63]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \data_out[64]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \data_out[65]_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \data_out[65]_i_4\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \data_out[6]_i_1\ : label is "soft_lutpair9";
begin
\data_out[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \data_out_reg_n_0_[0]\,
      I1 => \data_out[17]_i_2_n_0\,
      I2 => \data_out[36]_i_2_n_0\,
      O => D(0)
    );
\data_out[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[10]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(10)
    );
\data_out[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[11]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[42]_i_3_n_0\,
      I3 => \data_out[17]_i_2_n_0\,
      O => D(11)
    );
\data_out[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \data_out_reg_n_0_[12]\,
      I1 => \data_out[17]_i_2_n_0\,
      I2 => \data_out[51]_i_2_n_0\,
      O => D(12)
    );
\data_out[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \data_out_reg_n_0_[13]\,
      I1 => \data_out[17]_i_2_n_0\,
      I2 => \data_out[52]_i_2_n_0\,
      O => D(13)
    );
\data_out[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA6AAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[14]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(14)
    );
\data_out[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA6AAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[15]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(15)
    );
\data_out[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[16]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(16)
    );
\data_out[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[17]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(17)
    );
\data_out[17]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"060F0F06"
    )
        port map (
      I0 => \syndrome_pipe__0\(4),
      I1 => \data_out_reg_n_0_[68]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(6),
      I4 => \data_out_reg_n_0_[70]\,
      O => \data_out[17]_i_2_n_0\
    );
\data_out[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[18]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => \data_out[41]_i_2_n_0\,
      O => D(18)
    );
\data_out[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[19]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => \data_out[42]_i_3_n_0\,
      O => D(19)
    );
\data_out[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA6AAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[1]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(1)
    );
\data_out[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[20]\,
      I1 => \data_out[25]_i_2_n_0\,
      I2 => \data_out[51]_i_2_n_0\,
      O => D(20)
    );
\data_out[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[21]\,
      I1 => \data_out[25]_i_2_n_0\,
      I2 => \data_out[52]_i_2_n_0\,
      O => D(21)
    );
\data_out[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[22]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[25]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(22)
    );
\data_out[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[23]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[25]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(23)
    );
\data_out[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[24]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(24)
    );
\data_out[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[25]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(25)
    );
\data_out[25]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"06000006"
    )
        port map (
      I0 => \syndrome_pipe__0\(4),
      I1 => \data_out_reg_n_0_[68]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(6),
      I4 => \data_out_reg_n_0_[70]\,
      O => \data_out[25]_i_2_n_0\
    );
\data_out[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[26]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => \data_out[59]_i_2_n_0\,
      O => D(26)
    );
\data_out[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[27]\,
      I1 => \data_out[35]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => \data_out[58]_i_2_n_0\,
      O => D(27)
    );
\data_out[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[28]\,
      I1 => \data_out[48]_i_2_n_0\,
      I2 => \data_out[36]_i_2_n_0\,
      O => D(28)
    );
\data_out[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[29]\,
      I1 => \data_out[56]_i_4_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[62]_i_2_n_0\,
      I4 => \data_out[48]_i_2_n_0\,
      O => D(29)
    );
\data_out[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[2]\,
      I1 => \data_out[62]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(2)
    );
\data_out[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[30]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[48]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(30)
    );
\data_out[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[31]\,
      I1 => \data_out[62]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(31)
    );
\data_out[32]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[32]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(32)
    );
\data_out[33]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA5665AAAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[33]\,
      I1 => \data_out_reg_n_0_[81]\,
      I2 => \syndrome_pipe__0\(1),
      I3 => \data_out_reg_n_0_[65]\,
      I4 => p_0_in(4),
      I5 => \data_out[50]_i_2_n_0\,
      O => D(33)
    );
\data_out[34]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA99AAAAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[34]\,
      I1 => \data_out_reg_n_0_[81]\,
      I2 => \syndrome_pipe__0\(1),
      I3 => \data_out_reg_n_0_[65]\,
      I4 => p_0_in(4),
      I5 => \data_out[50]_i_2_n_0\,
      O => D(34)
    );
\data_out[35]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[35]\,
      I1 => \data_out[35]_i_2_n_0\,
      I2 => \data_out[56]_i_3_n_0\,
      I3 => \data_out[58]_i_2_n_0\,
      O => D(35)
    );
\data_out[35]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000020000020"
    )
        port map (
      I0 => p_0_in(1),
      I1 => p_0_in(2),
      I2 => \data_out[56]_i_5_n_0\,
      I3 => \data_out_reg_n_0_[71]\,
      I4 => \syndrome_pipe__0\(7),
      I5 => \data_out_reg_n_0_[81]\,
      O => \data_out[35]_i_2_n_0\
    );
\data_out[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[36]\,
      I1 => \data_out[56]_i_3_n_0\,
      I2 => \data_out[36]_i_2_n_0\,
      O => D(36)
    );
\data_out[36]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4100000000000000"
    )
        port map (
      I0 => \data_out_reg_n_0_[81]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[71]\,
      I3 => \data_out[59]_i_2_n_0\,
      I4 => \data_out[56]_i_5_n_0\,
      I5 => \data_out[52]_i_3_n_0\,
      O => \data_out[36]_i_2_n_0\
    );
\data_out[37]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[37]\,
      I1 => \data_out[56]_i_4_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[62]_i_2_n_0\,
      I4 => \data_out[56]_i_3_n_0\,
      O => D(37)
    );
\data_out[38]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[38]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[56]_i_3_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(38)
    );
\data_out[39]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[39]\,
      I1 => \data_out[62]_i_2_n_0\,
      I2 => \data_out[56]_i_3_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(39)
    );
\data_out[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[3]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[17]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(3)
    );
\data_out[40]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[40]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[56]_i_3_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(40)
    );
\data_out[41]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[41]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => \data_out[41]_i_2_n_0\,
      O => D(41)
    );
\data_out[41]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"06000006"
    )
        port map (
      I0 => \syndrome_pipe__0\(5),
      I1 => \data_out_reg_n_0_[69]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(1),
      I4 => \data_out_reg_n_0_[65]\,
      O => \data_out[41]_i_2_n_0\
    );
\data_out[42]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[42]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => \data_out[42]_i_3_n_0\,
      O => D(42)
    );
\data_out[42]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000010"
    )
        port map (
      I0 => p_0_in(1),
      I1 => p_0_in(2),
      I2 => \data_out[56]_i_5_n_0\,
      I3 => \data_out_reg_n_0_[71]\,
      I4 => \syndrome_pipe__0\(7),
      I5 => \data_out_reg_n_0_[81]\,
      O => \data_out[42]_i_2_n_0\
    );
\data_out[42]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00060600"
    )
        port map (
      I0 => \syndrome_pipe__0\(1),
      I1 => \data_out_reg_n_0_[65]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(5),
      I4 => \data_out_reg_n_0_[69]\,
      O => \data_out[42]_i_3_n_0\
    );
\data_out[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[43]\,
      I1 => \data_out[48]_i_2_n_0\,
      I2 => \data_out[51]_i_2_n_0\,
      O => D(43)
    );
\data_out[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[44]\,
      I1 => \data_out[48]_i_2_n_0\,
      I2 => \data_out[52]_i_2_n_0\,
      O => D(44)
    );
\data_out[45]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[45]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[48]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(45)
    );
\data_out[46]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[46]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[48]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(46)
    );
\data_out[47]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[47]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(47)
    );
\data_out[48]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[48]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => \data_out[48]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(48)
    );
\data_out[48]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"06000006"
    )
        port map (
      I0 => \syndrome_pipe__0\(6),
      I1 => \data_out_reg_n_0_[70]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(4),
      I4 => \data_out_reg_n_0_[68]\,
      O => \data_out[48]_i_2_n_0\
    );
\data_out[49]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"666A6A66AAAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[49]\,
      I1 => p_0_in(4),
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(1),
      I4 => \data_out_reg_n_0_[65]\,
      I5 => \data_out[50]_i_2_n_0\,
      O => D(49)
    );
\data_out[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[4]\,
      I1 => \data_out[42]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => \data_out[59]_i_2_n_0\,
      O => D(4)
    );
\data_out[50]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A99AAAAAAAAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[50]\,
      I1 => \data_out_reg_n_0_[81]\,
      I2 => \syndrome_pipe__0\(1),
      I3 => \data_out_reg_n_0_[65]\,
      I4 => p_0_in(4),
      I5 => \data_out[50]_i_2_n_0\,
      O => D(50)
    );
\data_out[50]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000040"
    )
        port map (
      I0 => \data_out[50]_i_3_n_0\,
      I1 => \data_out[56]_i_3_n_0\,
      I2 => \data_out[56]_i_5_n_0\,
      I3 => p_0_in(1),
      I4 => p_0_in(2),
      O => \data_out[50]_i_2_n_0\
    );
\data_out[50]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BE"
    )
        port map (
      I0 => \data_out_reg_n_0_[81]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[71]\,
      O => \data_out[50]_i_3_n_0\
    );
\data_out[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[51]\,
      I1 => \data_out[56]_i_3_n_0\,
      I2 => \data_out[51]_i_2_n_0\,
      O => D(51)
    );
\data_out[51]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4100000000000000"
    )
        port map (
      I0 => \data_out_reg_n_0_[81]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[71]\,
      I3 => \data_out[41]_i_2_n_0\,
      I4 => \data_out[56]_i_5_n_0\,
      I5 => \data_out[52]_i_3_n_0\,
      O => \data_out[51]_i_2_n_0\
    );
\data_out[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[52]\,
      I1 => \data_out[56]_i_3_n_0\,
      I2 => \data_out[52]_i_2_n_0\,
      O => D(52)
    );
\data_out[52]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4100000000000000"
    )
        port map (
      I0 => \data_out_reg_n_0_[81]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[71]\,
      I3 => \data_out[42]_i_3_n_0\,
      I4 => \data_out[56]_i_5_n_0\,
      I5 => \data_out[52]_i_3_n_0\,
      O => \data_out[52]_i_2_n_0\
    );
\data_out[52]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"06000006"
    )
        port map (
      I0 => \syndrome_pipe__0\(2),
      I1 => \data_out_reg_n_0_[66]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(3),
      I4 => \data_out_reg_n_0_[67]\,
      O => \data_out[52]_i_3_n_0\
    );
\data_out[53]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[53]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[56]_i_3_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(53)
    );
\data_out[54]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[54]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[56]_i_3_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(54)
    );
\data_out[55]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[55]\,
      I1 => \data_out[55]_i_2_n_0\,
      I2 => \data_out[56]_i_3_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(55)
    );
\data_out[55]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000009000900000"
    )
        port map (
      I0 => \data_out_reg_n_0_[65]\,
      I1 => \syndrome_pipe__0\(1),
      I2 => p_0_in(2),
      I3 => \data_out_reg_n_0_[81]\,
      I4 => \syndrome_pipe__0\(5),
      I5 => \data_out_reg_n_0_[69]\,
      O => \data_out[55]_i_2_n_0\
    );
\data_out[56]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[56]\,
      I1 => \data_out[56]_i_2_n_0\,
      I2 => \data_out[56]_i_3_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(56)
    );
\data_out[56]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0006060000000000"
    )
        port map (
      I0 => \data_out_reg_n_0_[69]\,
      I1 => \syndrome_pipe__0\(5),
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \data_out_reg_n_0_[65]\,
      I4 => \syndrome_pipe__0\(1),
      I5 => p_0_in(2),
      O => \data_out[56]_i_2_n_0\
    );
\data_out[56]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00060600"
    )
        port map (
      I0 => \syndrome_pipe__0\(4),
      I1 => \data_out_reg_n_0_[68]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(6),
      I4 => \data_out_reg_n_0_[70]\,
      O => \data_out[56]_i_3_n_0\
    );
\data_out[56]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0082"
    )
        port map (
      I0 => \data_out[56]_i_5_n_0\,
      I1 => \data_out_reg_n_0_[71]\,
      I2 => \syndrome_pipe__0\(7),
      I3 => \data_out_reg_n_0_[81]\,
      O => \data_out[56]_i_4_n_0\
    );
\data_out[56]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \data_out_reg_n_0_[64]\,
      I1 => xor_bits_0_25_pipe,
      I2 => \syndrome_pipe__0\(7),
      I3 => \data_out_reg_n_0_[80]\,
      I4 => \syndrome_pipe__0\(6),
      O => \data_out[56]_i_5_n_0\
    );
\data_out[57]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA6AAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[57]\,
      I1 => \data_out[61]_i_2_n_0\,
      I2 => p_0_in(2),
      I3 => p_0_in(1),
      I4 => \data_out[59]_i_2_n_0\,
      O => D(57)
    );
\data_out[58]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A6A6A6AAA6AAA6A6"
    )
        port map (
      I0 => \data_out_reg_n_0_[58]\,
      I1 => \data_out[63]_i_3_n_0\,
      I2 => \data_out[58]_i_2_n_0\,
      I3 => \data_out_reg_n_0_[81]\,
      I4 => \syndrome_pipe__0\(3),
      I5 => \data_out_reg_n_0_[67]\,
      O => D(58)
    );
\data_out[58]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"060F0F06"
    )
        port map (
      I0 => \syndrome_pipe__0\(1),
      I1 => \data_out_reg_n_0_[65]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(5),
      I4 => \data_out_reg_n_0_[69]\,
      O => \data_out[58]_i_2_n_0\
    );
\data_out[59]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6A6A6AAA6AAA6A6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[59]\,
      I1 => \data_out[63]_i_3_n_0\,
      I2 => \data_out[59]_i_2_n_0\,
      I3 => \data_out_reg_n_0_[81]\,
      I4 => \syndrome_pipe__0\(3),
      I5 => \data_out_reg_n_0_[67]\,
      O => D(59)
    );
\data_out[59]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"06000006"
    )
        port map (
      I0 => \syndrome_pipe__0\(1),
      I1 => \data_out_reg_n_0_[65]\,
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \syndrome_pipe__0\(5),
      I4 => \data_out_reg_n_0_[69]\,
      O => \data_out[59]_i_2_n_0\
    );
\data_out[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[5]\,
      I1 => \data_out[35]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => \data_out[58]_i_2_n_0\,
      O => D(5)
    );
\data_out[60]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAA6AAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[60]\,
      I1 => \data_out[61]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => p_0_in(4),
      I4 => p_0_in(2),
      I5 => p_0_in(0),
      O => D(60)
    );
\data_out[61]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAA6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[61]\,
      I1 => \data_out[61]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => p_0_in(2),
      I4 => p_0_in(0),
      I5 => p_0_in(4),
      O => D(61)
    );
\data_out[61]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000141400"
    )
        port map (
      I0 => \data_out_reg_n_0_[81]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[71]\,
      I3 => \data_out_reg_n_0_[64]\,
      I4 => syndrome_pipe(0),
      I5 => \data_out[17]_i_2_n_0\,
      O => \data_out[61]_i_2_n_0\
    );
\data_out[61]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \data_out_reg_n_0_[66]\,
      I1 => \syndrome_pipe__0\(2),
      I2 => \data_out_reg_n_0_[81]\,
      O => p_0_in(1)
    );
\data_out[61]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \data_out_reg_n_0_[67]\,
      I1 => \syndrome_pipe__0\(3),
      I2 => \data_out_reg_n_0_[81]\,
      O => p_0_in(2)
    );
\data_out[61]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \data_out_reg_n_0_[65]\,
      I1 => \syndrome_pipe__0\(1),
      I2 => \data_out_reg_n_0_[81]\,
      O => p_0_in(0)
    );
\data_out[61]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \data_out_reg_n_0_[69]\,
      I1 => \syndrome_pipe__0\(5),
      I2 => \data_out_reg_n_0_[81]\,
      O => p_0_in(4)
    );
\data_out[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[62]\,
      I1 => \data_out[62]_i_2_n_0\,
      I2 => \data_out[63]_i_3_n_0\,
      O => D(62)
    );
\data_out[62]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F090F000F000F090"
    )
        port map (
      I0 => \data_out_reg_n_0_[65]\,
      I1 => \syndrome_pipe__0\(1),
      I2 => p_0_in(2),
      I3 => \data_out_reg_n_0_[81]\,
      I4 => \syndrome_pipe__0\(5),
      I5 => \data_out_reg_n_0_[69]\,
      O => \data_out[62]_i_2_n_0\
    );
\data_out[63]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[63]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => \data_out[63]_i_3_n_0\,
      O => D(63)
    );
\data_out[63]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0009090000000000"
    )
        port map (
      I0 => \data_out_reg_n_0_[69]\,
      I1 => \syndrome_pipe__0\(5),
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \data_out_reg_n_0_[65]\,
      I4 => \syndrome_pipe__0\(1),
      I5 => p_0_in(2),
      O => \data_out[63]_i_2_n_0\
    );
\data_out[63]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000044000000000"
    )
        port map (
      I0 => \data_out[17]_i_2_n_0\,
      I1 => p_0_in(1),
      I2 => \data_out_reg_n_0_[64]\,
      I3 => syndrome_pipe(0),
      I4 => \data_out_reg_n_0_[81]\,
      I5 => p_0_in(6),
      O => \data_out[63]_i_3_n_0\
    );
\data_out[64]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000006"
    )
        port map (
      I0 => \data_out_reg_n_0_[64]\,
      I1 => syndrome_pipe(0),
      I2 => \data_out_reg_n_0_[81]\,
      I3 => \data_out[17]_i_2_n_0\,
      I4 => p_0_in(4),
      I5 => \data_out[56]_i_4_n_0\,
      O => D(64)
    );
\data_out[64]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \syndrome_pipe__0\(6),
      I1 => \data_out_reg_n_0_[80]\,
      I2 => \syndrome_pipe__0\(7),
      I3 => xor_bits_0_25_pipe,
      O => syndrome_pipe(0)
    );
\data_out[65]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE00FEFEFEFE"
    )
        port map (
      I0 => \data_out[65]_i_2_n_0\,
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => p_0_in(6),
      I4 => \data_out[65]_i_4_n_0\,
      I5 => \data_out[65]_i_5_n_0\,
      O => D(65)
    );
\data_out[65]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEFFFFFEEFE"
    )
        port map (
      I0 => \data_out[58]_i_2_n_0\,
      I1 => \data_out[17]_i_2_n_0\,
      I2 => \data_out_reg_n_0_[64]\,
      I3 => \data_out_reg_n_0_[81]\,
      I4 => p_0_in(6),
      I5 => syndrome_pipe(0),
      O => \data_out[65]_i_2_n_0\
    );
\data_out[65]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \data_out_reg_n_0_[71]\,
      I1 => \syndrome_pipe__0\(7),
      I2 => \data_out_reg_n_0_[81]\,
      O => p_0_in(6)
    );
\data_out[65]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5445"
    )
        port map (
      I0 => \data_out[17]_i_2_n_0\,
      I1 => \data_out_reg_n_0_[81]\,
      I2 => \syndrome_pipe__0\(5),
      I3 => \data_out_reg_n_0_[69]\,
      O => \data_out[65]_i_4_n_0\
    );
\data_out[65]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000096696996"
    )
        port map (
      I0 => \data_out_reg_n_0_[64]\,
      I1 => \syndrome_pipe__0\(6),
      I2 => \data_out_reg_n_0_[80]\,
      I3 => \syndrome_pipe__0\(7),
      I4 => xor_bits_0_25_pipe,
      I5 => \data_out_reg_n_0_[81]\,
      O => \data_out[65]_i_5_n_0\
    );
\data_out[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \data_out_reg_n_0_[6]\,
      I1 => \data_out[25]_i_2_n_0\,
      I2 => \data_out[36]_i_2_n_0\,
      O => D(6)
    );
\data_out[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[7]\,
      I1 => \data_out[56]_i_4_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[62]_i_2_n_0\,
      I4 => \data_out[25]_i_2_n_0\,
      O => D(7)
    );
\data_out[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A6AAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[8]\,
      I1 => \data_out[63]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \data_out[25]_i_2_n_0\,
      I4 => \data_out[56]_i_4_n_0\,
      O => D(8)
    );
\data_out[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \data_out_reg_n_0_[9]\,
      I1 => \data_out[62]_i_2_n_0\,
      I2 => \data_out[25]_i_2_n_0\,
      I3 => p_0_in(1),
      I4 => \data_out[56]_i_4_n_0\,
      O => D(9)
    );
\data_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(0),
      Q => \data_out_reg_n_0_[0]\,
      R => ecc_reset
    );
\data_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(10),
      Q => \data_out_reg_n_0_[10]\,
      R => ecc_reset
    );
\data_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(11),
      Q => \data_out_reg_n_0_[11]\,
      R => ecc_reset
    );
\data_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(12),
      Q => \data_out_reg_n_0_[12]\,
      R => ecc_reset
    );
\data_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(13),
      Q => \data_out_reg_n_0_[13]\,
      R => ecc_reset
    );
\data_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(14),
      Q => \data_out_reg_n_0_[14]\,
      R => ecc_reset
    );
\data_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(15),
      Q => \data_out_reg_n_0_[15]\,
      R => ecc_reset
    );
\data_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(16),
      Q => \data_out_reg_n_0_[16]\,
      R => ecc_reset
    );
\data_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(17),
      Q => \data_out_reg_n_0_[17]\,
      R => ecc_reset
    );
\data_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(18),
      Q => \data_out_reg_n_0_[18]\,
      R => ecc_reset
    );
\data_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(19),
      Q => \data_out_reg_n_0_[19]\,
      R => ecc_reset
    );
\data_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(1),
      Q => \data_out_reg_n_0_[1]\,
      R => ecc_reset
    );
\data_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(20),
      Q => \data_out_reg_n_0_[20]\,
      R => ecc_reset
    );
\data_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(21),
      Q => \data_out_reg_n_0_[21]\,
      R => ecc_reset
    );
\data_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(22),
      Q => \data_out_reg_n_0_[22]\,
      R => ecc_reset
    );
\data_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(23),
      Q => \data_out_reg_n_0_[23]\,
      R => ecc_reset
    );
\data_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(24),
      Q => \data_out_reg_n_0_[24]\,
      R => ecc_reset
    );
\data_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(25),
      Q => \data_out_reg_n_0_[25]\,
      R => ecc_reset
    );
\data_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(26),
      Q => \data_out_reg_n_0_[26]\,
      R => ecc_reset
    );
\data_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(27),
      Q => \data_out_reg_n_0_[27]\,
      R => ecc_reset
    );
\data_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(28),
      Q => \data_out_reg_n_0_[28]\,
      R => ecc_reset
    );
\data_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(29),
      Q => \data_out_reg_n_0_[29]\,
      R => ecc_reset
    );
\data_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(2),
      Q => \data_out_reg_n_0_[2]\,
      R => ecc_reset
    );
\data_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(30),
      Q => \data_out_reg_n_0_[30]\,
      R => ecc_reset
    );
\data_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(31),
      Q => \data_out_reg_n_0_[31]\,
      R => ecc_reset
    );
\data_out_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(32),
      Q => \data_out_reg_n_0_[32]\,
      R => ecc_reset
    );
\data_out_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(33),
      Q => \data_out_reg_n_0_[33]\,
      R => ecc_reset
    );
\data_out_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(34),
      Q => \data_out_reg_n_0_[34]\,
      R => ecc_reset
    );
\data_out_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(35),
      Q => \data_out_reg_n_0_[35]\,
      R => ecc_reset
    );
\data_out_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(36),
      Q => \data_out_reg_n_0_[36]\,
      R => ecc_reset
    );
\data_out_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(37),
      Q => \data_out_reg_n_0_[37]\,
      R => ecc_reset
    );
\data_out_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(38),
      Q => \data_out_reg_n_0_[38]\,
      R => ecc_reset
    );
\data_out_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(39),
      Q => \data_out_reg_n_0_[39]\,
      R => ecc_reset
    );
\data_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(3),
      Q => \data_out_reg_n_0_[3]\,
      R => ecc_reset
    );
\data_out_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(40),
      Q => \data_out_reg_n_0_[40]\,
      R => ecc_reset
    );
\data_out_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(41),
      Q => \data_out_reg_n_0_[41]\,
      R => ecc_reset
    );
\data_out_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(42),
      Q => \data_out_reg_n_0_[42]\,
      R => ecc_reset
    );
\data_out_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(43),
      Q => \data_out_reg_n_0_[43]\,
      R => ecc_reset
    );
\data_out_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(44),
      Q => \data_out_reg_n_0_[44]\,
      R => ecc_reset
    );
\data_out_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(45),
      Q => \data_out_reg_n_0_[45]\,
      R => ecc_reset
    );
\data_out_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(46),
      Q => \data_out_reg_n_0_[46]\,
      R => ecc_reset
    );
\data_out_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(47),
      Q => \data_out_reg_n_0_[47]\,
      R => ecc_reset
    );
\data_out_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(48),
      Q => \data_out_reg_n_0_[48]\,
      R => ecc_reset
    );
\data_out_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(49),
      Q => \data_out_reg_n_0_[49]\,
      R => ecc_reset
    );
\data_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(4),
      Q => \data_out_reg_n_0_[4]\,
      R => ecc_reset
    );
\data_out_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(50),
      Q => \data_out_reg_n_0_[50]\,
      R => ecc_reset
    );
\data_out_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(51),
      Q => \data_out_reg_n_0_[51]\,
      R => ecc_reset
    );
\data_out_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(52),
      Q => \data_out_reg_n_0_[52]\,
      R => ecc_reset
    );
\data_out_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(53),
      Q => \data_out_reg_n_0_[53]\,
      R => ecc_reset
    );
\data_out_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(54),
      Q => \data_out_reg_n_0_[54]\,
      R => ecc_reset
    );
\data_out_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(55),
      Q => \data_out_reg_n_0_[55]\,
      R => ecc_reset
    );
\data_out_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(56),
      Q => \data_out_reg_n_0_[56]\,
      R => ecc_reset
    );
\data_out_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(57),
      Q => \data_out_reg_n_0_[57]\,
      R => ecc_reset
    );
\data_out_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(58),
      Q => \data_out_reg_n_0_[58]\,
      R => ecc_reset
    );
\data_out_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(59),
      Q => \data_out_reg_n_0_[59]\,
      R => ecc_reset
    );
\data_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(5),
      Q => \data_out_reg_n_0_[5]\,
      R => ecc_reset
    );
\data_out_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(60),
      Q => \data_out_reg_n_0_[60]\,
      R => ecc_reset
    );
\data_out_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(61),
      Q => \data_out_reg_n_0_[61]\,
      R => ecc_reset
    );
\data_out_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(62),
      Q => \data_out_reg_n_0_[62]\,
      R => ecc_reset
    );
\data_out_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(63),
      Q => \data_out_reg_n_0_[63]\,
      R => ecc_reset
    );
\data_out_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(64),
      Q => \data_out_reg_n_0_[64]\,
      R => ecc_reset
    );
\data_out_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(65),
      Q => \data_out_reg_n_0_[65]\,
      R => ecc_reset
    );
\data_out_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(66),
      Q => \data_out_reg_n_0_[66]\,
      R => ecc_reset
    );
\data_out_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(67),
      Q => \data_out_reg_n_0_[67]\,
      R => ecc_reset
    );
\data_out_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(68),
      Q => \data_out_reg_n_0_[68]\,
      R => ecc_reset
    );
\data_out_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(69),
      Q => \data_out_reg_n_0_[69]\,
      R => ecc_reset
    );
\data_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(6),
      Q => \data_out_reg_n_0_[6]\,
      R => ecc_reset
    );
\data_out_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(70),
      Q => \data_out_reg_n_0_[70]\,
      R => ecc_reset
    );
\data_out_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(71),
      Q => \data_out_reg_n_0_[71]\,
      R => ecc_reset
    );
\data_out_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(72),
      Q => \syndrome_pipe__0\(1),
      R => ecc_reset
    );
\data_out_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(73),
      Q => \syndrome_pipe__0\(2),
      R => ecc_reset
    );
\data_out_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(74),
      Q => \syndrome_pipe__0\(3),
      R => ecc_reset
    );
\data_out_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(75),
      Q => \syndrome_pipe__0\(4),
      R => ecc_reset
    );
\data_out_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(76),
      Q => \syndrome_pipe__0\(5),
      R => ecc_reset
    );
\data_out_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(77),
      Q => \syndrome_pipe__0\(6),
      R => ecc_reset
    );
\data_out_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(78),
      Q => \syndrome_pipe__0\(7),
      R => ecc_reset
    );
\data_out_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(79),
      Q => xor_bits_0_25_pipe,
      R => ecc_reset
    );
\data_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(7),
      Q => \data_out_reg_n_0_[7]\,
      R => ecc_reset
    );
\data_out_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(80),
      Q => \data_out_reg_n_0_[80]\,
      R => ecc_reset
    );
\data_out_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(81),
      Q => \data_out_reg_n_0_[81]\,
      R => ecc_reset
    );
\data_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(8),
      Q => \data_out_reg_n_0_[8]\,
      R => ecc_reset
    );
\data_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => \data_out_reg[72]_0\(9),
      Q => \data_out_reg_n_0_[9]\,
      R => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 65 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 65 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1\ : entity is "ecc_v2_0_reg_stage";
end \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1\;

architecture STRUCTURE of \xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1\ is
begin
\data_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(0),
      Q => Q(0),
      R => ecc_reset
    );
\data_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(10),
      Q => Q(10),
      R => ecc_reset
    );
\data_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(11),
      Q => Q(11),
      R => ecc_reset
    );
\data_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(12),
      Q => Q(12),
      R => ecc_reset
    );
\data_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(13),
      Q => Q(13),
      R => ecc_reset
    );
\data_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(14),
      Q => Q(14),
      R => ecc_reset
    );
\data_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(15),
      Q => Q(15),
      R => ecc_reset
    );
\data_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(16),
      Q => Q(16),
      R => ecc_reset
    );
\data_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(17),
      Q => Q(17),
      R => ecc_reset
    );
\data_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(18),
      Q => Q(18),
      R => ecc_reset
    );
\data_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(19),
      Q => Q(19),
      R => ecc_reset
    );
\data_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(1),
      Q => Q(1),
      R => ecc_reset
    );
\data_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(20),
      Q => Q(20),
      R => ecc_reset
    );
\data_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(21),
      Q => Q(21),
      R => ecc_reset
    );
\data_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(22),
      Q => Q(22),
      R => ecc_reset
    );
\data_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(23),
      Q => Q(23),
      R => ecc_reset
    );
\data_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(24),
      Q => Q(24),
      R => ecc_reset
    );
\data_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(25),
      Q => Q(25),
      R => ecc_reset
    );
\data_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(26),
      Q => Q(26),
      R => ecc_reset
    );
\data_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(27),
      Q => Q(27),
      R => ecc_reset
    );
\data_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(28),
      Q => Q(28),
      R => ecc_reset
    );
\data_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(29),
      Q => Q(29),
      R => ecc_reset
    );
\data_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(2),
      Q => Q(2),
      R => ecc_reset
    );
\data_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(30),
      Q => Q(30),
      R => ecc_reset
    );
\data_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(31),
      Q => Q(31),
      R => ecc_reset
    );
\data_out_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(32),
      Q => Q(32),
      R => ecc_reset
    );
\data_out_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(33),
      Q => Q(33),
      R => ecc_reset
    );
\data_out_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(34),
      Q => Q(34),
      R => ecc_reset
    );
\data_out_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(35),
      Q => Q(35),
      R => ecc_reset
    );
\data_out_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(36),
      Q => Q(36),
      R => ecc_reset
    );
\data_out_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(37),
      Q => Q(37),
      R => ecc_reset
    );
\data_out_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(38),
      Q => Q(38),
      R => ecc_reset
    );
\data_out_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(39),
      Q => Q(39),
      R => ecc_reset
    );
\data_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(3),
      Q => Q(3),
      R => ecc_reset
    );
\data_out_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(40),
      Q => Q(40),
      R => ecc_reset
    );
\data_out_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(41),
      Q => Q(41),
      R => ecc_reset
    );
\data_out_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(42),
      Q => Q(42),
      R => ecc_reset
    );
\data_out_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(43),
      Q => Q(43),
      R => ecc_reset
    );
\data_out_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(44),
      Q => Q(44),
      R => ecc_reset
    );
\data_out_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(45),
      Q => Q(45),
      R => ecc_reset
    );
\data_out_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(46),
      Q => Q(46),
      R => ecc_reset
    );
\data_out_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(47),
      Q => Q(47),
      R => ecc_reset
    );
\data_out_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(48),
      Q => Q(48),
      R => ecc_reset
    );
\data_out_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(49),
      Q => Q(49),
      R => ecc_reset
    );
\data_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(4),
      Q => Q(4),
      R => ecc_reset
    );
\data_out_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(50),
      Q => Q(50),
      R => ecc_reset
    );
\data_out_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(51),
      Q => Q(51),
      R => ecc_reset
    );
\data_out_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(52),
      Q => Q(52),
      R => ecc_reset
    );
\data_out_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(53),
      Q => Q(53),
      R => ecc_reset
    );
\data_out_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(54),
      Q => Q(54),
      R => ecc_reset
    );
\data_out_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(55),
      Q => Q(55),
      R => ecc_reset
    );
\data_out_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(56),
      Q => Q(56),
      R => ecc_reset
    );
\data_out_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(57),
      Q => Q(57),
      R => ecc_reset
    );
\data_out_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(58),
      Q => Q(58),
      R => ecc_reset
    );
\data_out_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(59),
      Q => Q(59),
      R => ecc_reset
    );
\data_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(5),
      Q => Q(5),
      R => ecc_reset
    );
\data_out_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(60),
      Q => Q(60),
      R => ecc_reset
    );
\data_out_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(61),
      Q => Q(61),
      R => ecc_reset
    );
\data_out_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(62),
      Q => Q(62),
      R => ecc_reset
    );
\data_out_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(63),
      Q => Q(63),
      R => ecc_reset
    );
\data_out_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(64),
      Q => Q(64),
      R => ecc_reset
    );
\data_out_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(65),
      Q => Q(65),
      R => ecc_reset
    );
\data_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(6),
      Q => Q(6),
      R => ecc_reset
    );
\data_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(7),
      Q => Q(7),
      R => ecc_reset
    );
\data_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(8),
      Q => Q(8),
      R => ecc_reset
    );
\data_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(9),
      Q => Q(9),
      R => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_dec_64x8_ecc_v2_0_hamming_dec is
  port (
    Q : out STD_LOGIC_VECTOR ( 65 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 72 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_dec_64x8_ecc_v2_0_hamming_dec : entity is "ecc_v2_0_hamming_dec";
end xil_ecc_dec_64x8_ecc_v2_0_hamming_dec;

architecture STRUCTURE of xil_ecc_dec_64x8_ecc_v2_0_hamming_dec is
  signal dec_chkbits_w : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal p_0_in15_in : STD_LOGIC;
  signal p_0_in4_in : STD_LOGIC;
  signal p_0_in5_in : STD_LOGIC;
  signal p_10_in : STD_LOGIC;
  signal p_10_in28_in : STD_LOGIC;
  signal p_11_in : STD_LOGIC;
  signal p_11_in20_in : STD_LOGIC;
  signal p_11_in29_in : STD_LOGIC;
  signal p_11_in34_in : STD_LOGIC;
  signal p_12_in : STD_LOGIC;
  signal p_12_in30_in : STD_LOGIC;
  signal p_13_in : STD_LOGIC;
  signal p_13_in21_in : STD_LOGIC;
  signal p_14_in : STD_LOGIC;
  signal p_14_in38_in : STD_LOGIC;
  signal p_15_in : STD_LOGIC;
  signal p_15_in22_in : STD_LOGIC;
  signal p_15_in35_in : STD_LOGIC;
  signal p_15_in39_in : STD_LOGIC;
  signal p_15_in42_in : STD_LOGIC;
  signal p_15_in45_in : STD_LOGIC;
  signal p_16_in : STD_LOGIC;
  signal p_16_in43_in : STD_LOGIC;
  signal p_17_in : STD_LOGIC;
  signal p_17_in23_in : STD_LOGIC;
  signal p_18_in : STD_LOGIC;
  signal p_19_in : STD_LOGIC;
  signal p_19_in24_in : STD_LOGIC;
  signal p_19_in36_in : STD_LOGIC;
  signal p_1_in2_in : STD_LOGIC;
  signal p_1_in3_in : STD_LOGIC;
  signal p_1_in6_in : STD_LOGIC;
  signal p_20_in : STD_LOGIC;
  signal p_21_in : STD_LOGIC;
  signal p_21_in25_in : STD_LOGIC;
  signal p_22_in : STD_LOGIC;
  signal p_23_in : STD_LOGIC;
  signal p_23_in26_in : STD_LOGIC;
  signal p_23_in37_in : STD_LOGIC;
  signal p_24_in : STD_LOGIC;
  signal p_25_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_2_in7_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_3_in16_in : STD_LOGIC;
  signal p_3_in32_in : STD_LOGIC;
  signal p_3_in8_in : STD_LOGIC;
  signal p_3_out : STD_LOGIC_VECTOR ( 65 downto 0 );
  signal p_41_in : STD_LOGIC;
  signal p_43_out : STD_LOGIC_VECTOR ( 81 downto 64 );
  signal p_4_in : STD_LOGIC;
  signal p_4_in9_in : STD_LOGIC;
  signal p_5_in : STD_LOGIC;
  signal p_5_in10_in : STD_LOGIC;
  signal p_5_in17_in : STD_LOGIC;
  signal p_6_in : STD_LOGIC;
  signal p_6_in11_in : STD_LOGIC;
  signal p_7_in : STD_LOGIC;
  signal p_7_in12_in : STD_LOGIC;
  signal p_7_in18_in : STD_LOGIC;
  signal p_7_in33_in : STD_LOGIC;
  signal p_7_in41_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal p_9_in : STD_LOGIC;
  signal p_9_in19_in : STD_LOGIC;
  signal p_9_in27_in : STD_LOGIC;
begin
dec_dinput_reg_stage_inst: entity work.xil_ecc_dec_64x8_ecc_v2_0_reg_stage
     port map (
      D(81 downto 72) => p_43_out(81 downto 72),
      D(71 downto 65) => dec_chkbits_w(7 downto 1),
      D(64) => p_43_out(64),
      D(63) => p_41_in,
      D(62) => p_12_in30_in,
      D(61) => p_7_in12_in,
      D(60) => p_15_in39_in,
      D(59) => p_6_in11_in,
      D(58) => p_11_in29_in,
      D(57) => p_5_in10_in,
      D(56) => p_4_in9_in,
      D(55) => p_10_in28_in,
      D(54) => p_3_in8_in,
      D(53) => p_14_in38_in,
      D(52) => p_2_in7_in,
      D(51) => p_9_in27_in,
      D(50) => p_1_in6_in,
      D(49) => p_16_in43_in,
      D(48) => p_0_in5_in,
      D(47) => p_25_in,
      D(46) => p_24_in,
      D(45) => p_23_in37_in,
      D(44) => p_23_in,
      D(43) => p_23_in26_in,
      D(42) => p_22_in,
      D(41) => p_15_in45_in,
      D(40) => p_21_in,
      D(39) => p_21_in25_in,
      D(38) => p_20_in,
      D(37) => p_19_in36_in,
      D(36) => p_19_in,
      D(35) => p_19_in24_in,
      D(34) => p_18_in,
      D(33) => p_15_in42_in,
      D(32) => p_17_in,
      D(31) => p_17_in23_in,
      D(30) => p_16_in,
      D(29) => p_15_in35_in,
      D(28) => p_15_in,
      D(27) => p_15_in22_in,
      D(26) => p_14_in,
      D(25) => p_13_in,
      D(24) => p_13_in21_in,
      D(23) => p_12_in,
      D(22) => p_11_in34_in,
      D(21) => p_11_in,
      D(20) => p_11_in20_in,
      D(19) => p_10_in,
      D(18) => p_7_in41_in,
      D(17) => p_9_in,
      D(16) => p_9_in19_in,
      D(15) => p_8_in,
      D(14) => p_7_in33_in,
      D(13) => p_7_in,
      D(12) => p_7_in18_in,
      D(11) => p_6_in,
      D(10) => p_5_in,
      D(9) => p_5_in17_in,
      D(8) => p_4_in,
      D(7) => p_3_in32_in,
      D(6) => p_3_in,
      D(5) => p_3_in16_in,
      D(4) => p_2_in,
      D(3) => p_0_in4_in,
      D(2) => p_0_in15_in,
      D(1) => p_1_in2_in,
      D(0) => p_1_in3_in,
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_correct_n(72 downto 0) => D(72 downto 0),
      ecc_reset => ecc_reset
    );
dec_output_reg_stage_inst: entity work.\xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1\
     port map (
      D(65 downto 0) => p_3_out(65 downto 0),
      Q(65 downto 0) => Q(65 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_reset => ecc_reset
    );
dec_pipe_reg_stage_inst: entity work.\xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0\
     port map (
      D(65 downto 0) => p_3_out(65 downto 0),
      \data_out_reg[72]_0\(81 downto 72) => p_43_out(81 downto 72),
      \data_out_reg[72]_0\(71 downto 65) => dec_chkbits_w(7 downto 1),
      \data_out_reg[72]_0\(64) => p_43_out(64),
      \data_out_reg[72]_0\(63) => p_41_in,
      \data_out_reg[72]_0\(62) => p_12_in30_in,
      \data_out_reg[72]_0\(61) => p_7_in12_in,
      \data_out_reg[72]_0\(60) => p_15_in39_in,
      \data_out_reg[72]_0\(59) => p_6_in11_in,
      \data_out_reg[72]_0\(58) => p_11_in29_in,
      \data_out_reg[72]_0\(57) => p_5_in10_in,
      \data_out_reg[72]_0\(56) => p_4_in9_in,
      \data_out_reg[72]_0\(55) => p_10_in28_in,
      \data_out_reg[72]_0\(54) => p_3_in8_in,
      \data_out_reg[72]_0\(53) => p_14_in38_in,
      \data_out_reg[72]_0\(52) => p_2_in7_in,
      \data_out_reg[72]_0\(51) => p_9_in27_in,
      \data_out_reg[72]_0\(50) => p_1_in6_in,
      \data_out_reg[72]_0\(49) => p_16_in43_in,
      \data_out_reg[72]_0\(48) => p_0_in5_in,
      \data_out_reg[72]_0\(47) => p_25_in,
      \data_out_reg[72]_0\(46) => p_24_in,
      \data_out_reg[72]_0\(45) => p_23_in37_in,
      \data_out_reg[72]_0\(44) => p_23_in,
      \data_out_reg[72]_0\(43) => p_23_in26_in,
      \data_out_reg[72]_0\(42) => p_22_in,
      \data_out_reg[72]_0\(41) => p_15_in45_in,
      \data_out_reg[72]_0\(40) => p_21_in,
      \data_out_reg[72]_0\(39) => p_21_in25_in,
      \data_out_reg[72]_0\(38) => p_20_in,
      \data_out_reg[72]_0\(37) => p_19_in36_in,
      \data_out_reg[72]_0\(36) => p_19_in,
      \data_out_reg[72]_0\(35) => p_19_in24_in,
      \data_out_reg[72]_0\(34) => p_18_in,
      \data_out_reg[72]_0\(33) => p_15_in42_in,
      \data_out_reg[72]_0\(32) => p_17_in,
      \data_out_reg[72]_0\(31) => p_17_in23_in,
      \data_out_reg[72]_0\(30) => p_16_in,
      \data_out_reg[72]_0\(29) => p_15_in35_in,
      \data_out_reg[72]_0\(28) => p_15_in,
      \data_out_reg[72]_0\(27) => p_15_in22_in,
      \data_out_reg[72]_0\(26) => p_14_in,
      \data_out_reg[72]_0\(25) => p_13_in,
      \data_out_reg[72]_0\(24) => p_13_in21_in,
      \data_out_reg[72]_0\(23) => p_12_in,
      \data_out_reg[72]_0\(22) => p_11_in34_in,
      \data_out_reg[72]_0\(21) => p_11_in,
      \data_out_reg[72]_0\(20) => p_11_in20_in,
      \data_out_reg[72]_0\(19) => p_10_in,
      \data_out_reg[72]_0\(18) => p_7_in41_in,
      \data_out_reg[72]_0\(17) => p_9_in,
      \data_out_reg[72]_0\(16) => p_9_in19_in,
      \data_out_reg[72]_0\(15) => p_8_in,
      \data_out_reg[72]_0\(14) => p_7_in33_in,
      \data_out_reg[72]_0\(13) => p_7_in,
      \data_out_reg[72]_0\(12) => p_7_in18_in,
      \data_out_reg[72]_0\(11) => p_6_in,
      \data_out_reg[72]_0\(10) => p_5_in,
      \data_out_reg[72]_0\(9) => p_5_in17_in,
      \data_out_reg[72]_0\(8) => p_4_in,
      \data_out_reg[72]_0\(7) => p_3_in32_in,
      \data_out_reg[72]_0\(6) => p_3_in,
      \data_out_reg[72]_0\(5) => p_3_in16_in,
      \data_out_reg[72]_0\(4) => p_2_in,
      \data_out_reg[72]_0\(3) => p_0_in4_in,
      \data_out_reg[72]_0\(2) => p_0_in15_in,
      \data_out_reg[72]_0\(1) => p_1_in2_in,
      \data_out_reg[72]_0\(0) => p_1_in3_in,
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_reset => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_dec_64x8_ecc_v2_0 is
  port (
    ecc_clk : in STD_LOGIC;
    ecc_reset : in STD_LOGIC;
    ecc_encode : in STD_LOGIC;
    ecc_correct_n : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_data_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_chkbits_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ecc_chkbits_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ecc_sbit_err : out STD_LOGIC;
    ecc_dbit_err : out STD_LOGIC
  );
  attribute C_CHK_BIT_WIDTH : integer;
  attribute C_CHK_BIT_WIDTH of xil_ecc_dec_64x8_ecc_v2_0 : entity is 8;
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of xil_ecc_dec_64x8_ecc_v2_0 : entity is "xil_ecc_dec_64x8";
  attribute C_DATA_WIDTH : integer;
  attribute C_DATA_WIDTH of xil_ecc_dec_64x8_ecc_v2_0 : entity is 64;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of xil_ecc_dec_64x8_ecc_v2_0 : entity is 1;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of xil_ecc_dec_64x8_ecc_v2_0 : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of xil_ecc_dec_64x8_ecc_v2_0 : entity is "virtexu";
  attribute C_PIPELINE : integer;
  attribute C_PIPELINE of xil_ecc_dec_64x8_ecc_v2_0 : entity is 1;
  attribute C_REG_INPUT : integer;
  attribute C_REG_INPUT of xil_ecc_dec_64x8_ecc_v2_0 : entity is 1;
  attribute C_REG_OUTPUT : integer;
  attribute C_REG_OUTPUT of xil_ecc_dec_64x8_ecc_v2_0 : entity is 1;
  attribute C_USE_CLK_ENABLE : integer;
  attribute C_USE_CLK_ENABLE of xil_ecc_dec_64x8_ecc_v2_0 : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_dec_64x8_ecc_v2_0 : entity is "ecc_v2_0";
  attribute TCQ : integer;
  attribute TCQ of xil_ecc_dec_64x8_ecc_v2_0 : entity is 100;
end xil_ecc_dec_64x8_ecc_v2_0;

architecture STRUCTURE of xil_ecc_dec_64x8_ecc_v2_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  ecc_chkbits_out(7) <= \<const0>\;
  ecc_chkbits_out(6) <= \<const0>\;
  ecc_chkbits_out(5) <= \<const0>\;
  ecc_chkbits_out(4) <= \<const0>\;
  ecc_chkbits_out(3) <= \<const0>\;
  ecc_chkbits_out(2) <= \<const0>\;
  ecc_chkbits_out(1) <= \<const0>\;
  ecc_chkbits_out(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\hamming_ecc_dec_gen.hamming_dec_inst\: entity work.xil_ecc_dec_64x8_ecc_v2_0_hamming_dec
     port map (
      D(72) => ecc_correct_n,
      D(71 downto 64) => ecc_chkbits_in(7 downto 0),
      D(63 downto 0) => ecc_data_in(63 downto 0),
      Q(65) => ecc_dbit_err,
      Q(64) => ecc_sbit_err,
      Q(63 downto 0) => ecc_data_out(63 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_reset => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_dec_64x8 is
  port (
    ecc_clk : in STD_LOGIC;
    ecc_reset : in STD_LOGIC;
    ecc_correct_n : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_data_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_chkbits_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ecc_sbit_err : out STD_LOGIC;
    ecc_dbit_err : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of xil_ecc_dec_64x8 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of xil_ecc_dec_64x8 : entity is "xil_ecc_dec_64x8,ecc_v2_0,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of xil_ecc_dec_64x8 : entity is "xil_ecc_dec_64x8,ecc_v2_0,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ecc,x_ipVersion=2.0,x_ipCoreRevision=8,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=virtexu,C_COMPONENT_NAME=xil_ecc_dec_64x8,C_ECC_MODE=1,C_ECC_TYPE=0,C_DATA_WIDTH=64,C_CHK_BIT_WIDTH=8,C_REG_INPUT=1,C_REG_OUTPUT=1,C_PIPELINE=1,C_USE_CLK_ENABLE=1}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of xil_ecc_dec_64x8 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of xil_ecc_dec_64x8 : entity is "ecc_v2_0,Vivado 2015.2";
end xil_ecc_dec_64x8;

architecture STRUCTURE of xil_ecc_dec_64x8 is
  signal NLW_inst_ecc_chkbits_out_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute C_CHK_BIT_WIDTH : integer;
  attribute C_CHK_BIT_WIDTH of inst : label is 8;
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of inst : label is "xil_ecc_dec_64x8";
  attribute C_DATA_WIDTH : integer;
  attribute C_DATA_WIDTH of inst : label is 64;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of inst : label is 1;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of inst : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "virtexu";
  attribute C_PIPELINE : integer;
  attribute C_PIPELINE of inst : label is 1;
  attribute C_REG_INPUT : integer;
  attribute C_REG_INPUT of inst : label is 1;
  attribute C_REG_OUTPUT : integer;
  attribute C_REG_OUTPUT of inst : label is 1;
  attribute C_USE_CLK_ENABLE : integer;
  attribute C_USE_CLK_ENABLE of inst : label is 1;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of inst : label is std.standard.true;
  attribute TCQ : integer;
  attribute TCQ of inst : label is 100;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of inst : label is "xilinx.com:signal:data:1.0 ECC_DATA_OUT DATA";
begin
inst: entity work.xil_ecc_dec_64x8_ecc_v2_0
     port map (
      ecc_chkbits_in(7 downto 0) => ecc_chkbits_in(7 downto 0),
      ecc_chkbits_out(7 downto 0) => NLW_inst_ecc_chkbits_out_UNCONNECTED(7 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_correct_n => ecc_correct_n,
      ecc_data_in(63 downto 0) => ecc_data_in(63 downto 0),
      ecc_data_out(63 downto 0) => ecc_data_out(63 downto 0),
      ecc_dbit_err => ecc_dbit_err,
      ecc_encode => '0',
      ecc_reset => ecc_reset,
      ecc_sbit_err => ecc_sbit_err
    );
end STRUCTURE;
