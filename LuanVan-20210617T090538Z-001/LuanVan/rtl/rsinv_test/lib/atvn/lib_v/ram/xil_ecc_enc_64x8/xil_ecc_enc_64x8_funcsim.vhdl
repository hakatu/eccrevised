-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Tue Aug 25 15:47:19 2015
-- Host        : linuxsrv13 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Share4Syn/Thalassa/Cisco/VU190_SYN_15.2_8SLICE_150824/Synthesis/AF6CCI0011_VU190.srcs/sources_1/ip/xil_ecc_enc_64x8/xil_ecc_enc_64x8_funcsim.vhdl
-- Design      : xil_ecc_enc_64x8
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcvu190-flgb2104-2-i-es2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_enc_64x8_ecc_v2_0_reg_stage is
  port (
    D : out STD_LOGIC_VECTOR ( 71 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_enc_64x8_ecc_v2_0_reg_stage : entity is "ecc_v2_0_reg_stage";
end xil_ecc_enc_64x8_ecc_v2_0_reg_stage;

architecture STRUCTURE of xil_ecc_enc_64x8_ecc_v2_0_reg_stage is
  signal \^d\ : STD_LOGIC_VECTOR ( 71 downto 0 );
  signal \data_out[64]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[64]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[64]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[64]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[64]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[64]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[65]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[66]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[66]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[66]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[66]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[66]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[67]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[67]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[67]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[67]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[68]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[68]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[68]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[68]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_10_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_8_n_0\ : STD_LOGIC;
  signal \data_out[69]_i_9_n_0\ : STD_LOGIC;
  signal \data_out[70]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_2_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_3_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_4_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_5_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_6_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_7_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_8_n_0\ : STD_LOGIC;
  signal \data_out[71]_i_9_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_out[66]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \data_out[69]_i_8\ : label is "soft_lutpair0";
begin
  D(71 downto 0) <= \^d\(71 downto 0);
\data_out[64]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \data_out[64]_i_2_n_0\,
      I1 => \data_out[64]_i_3_n_0\,
      I2 => \data_out[64]_i_4_n_0\,
      I3 => \data_out[64]_i_5_n_0\,
      I4 => \data_out[64]_i_6_n_0\,
      O => \^d\(64)
    );
\data_out[64]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(56),
      I1 => \^d\(63),
      I2 => \^d\(54),
      I3 => \^d\(46),
      I4 => \^d\(48),
      I5 => \^d\(32),
      O => \data_out[64]_i_2_n_0\
    );
\data_out[64]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(19),
      I1 => \^d\(34),
      I2 => \^d\(42),
      I3 => \^d\(11),
      I4 => \^d\(4),
      I5 => \^d\(26),
      O => \data_out[64]_i_3_n_0\
    );
\data_out[64]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(57),
      I1 => \^d\(50),
      I2 => \^d\(1),
      I3 => \^d\(0),
      I4 => \^d\(52),
      I5 => \^d\(21),
      O => \data_out[64]_i_4_n_0\
    );
\data_out[64]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(13),
      I1 => \^d\(6),
      I2 => \^d\(44),
      I3 => \^d\(36),
      I4 => \^d\(28),
      I5 => \^d\(59),
      O => \data_out[64]_i_5_n_0\
    );
\data_out[64]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(3),
      I1 => \^d\(17),
      I2 => \^d\(15),
      I3 => \^d\(38),
      I4 => \^d\(30),
      I5 => \data_out[64]_i_7_n_0\,
      O => \data_out[64]_i_6_n_0\
    );
\data_out[64]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(25),
      I1 => \^d\(61),
      I2 => \^d\(40),
      I3 => \^d\(23),
      I4 => \^d\(10),
      I5 => \^d\(8),
      O => \data_out[64]_i_7_n_0\
    );
\data_out[65]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[69]_i_4_n_0\,
      I1 => \data_out[65]_i_2_n_0\,
      I2 => \data_out[66]_i_3_n_0\,
      I3 => \data_out[65]_i_3_n_0\,
      I4 => \data_out[65]_i_4_n_0\,
      I5 => \data_out[65]_i_5_n_0\,
      O => \^d\(65)
    );
\data_out[65]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(2),
      I1 => \^d\(12),
      I2 => \^d\(35),
      I3 => \^d\(31),
      I4 => \^d\(62),
      I5 => \^d\(27),
      O => \data_out[65]_i_2_n_0\
    );
\data_out[65]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(59),
      I1 => \^d\(63),
      I2 => \^d\(32),
      I3 => \^d\(3),
      I4 => \^d\(43),
      I5 => \^d\(5),
      O => \data_out[65]_i_3_n_0\
    );
\data_out[65]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(0),
      I1 => \^d\(13),
      I2 => \^d\(6),
      I3 => \^d\(44),
      I4 => \^d\(36),
      I5 => \^d\(28),
      O => \data_out[65]_i_4_n_0\
    );
\data_out[65]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(58),
      I1 => \data_out[71]_i_9_n_0\,
      I2 => \data_out[71]_i_2_n_0\,
      I3 => \data_out[69]_i_9_n_0\,
      I4 => \data_out[69]_i_10_n_0\,
      I5 => \data_out[71]_i_3_n_0\,
      O => \data_out[65]_i_5_n_0\
    );
\data_out[66]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[69]_i_2_n_0\,
      I1 => \data_out[66]_i_2_n_0\,
      I2 => \data_out[66]_i_3_n_0\,
      I3 => \data_out[66]_i_4_n_0\,
      I4 => \data_out[66]_i_5_n_0\,
      I5 => \data_out[66]_i_6_n_0\,
      O => \^d\(66)
    );
\data_out[66]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(62),
      I1 => \^d\(60),
      I2 => \^d\(37),
      I3 => \^d\(45),
      I4 => \^d\(14),
      I5 => \^d\(7),
      O => \data_out[66]_i_2_n_0\
    );
\data_out[66]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^d\(56),
      I1 => \^d\(55),
      I2 => \^d\(25),
      I3 => \^d\(24),
      O => \data_out[66]_i_3_n_0\
    );
\data_out[66]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(3),
      I1 => \^d\(15),
      I2 => \^d\(38),
      I3 => \^d\(30),
      I4 => \^d\(2),
      I5 => \^d\(31),
      O => \data_out[66]_i_4_n_0\
    );
\data_out[66]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(1),
      I1 => \^d\(63),
      I2 => \^d\(46),
      I3 => \^d\(32),
      I4 => \^d\(61),
      I5 => \^d\(8),
      O => \data_out[66]_i_5_n_0\
    );
\data_out[66]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(29),
      I1 => \data_out[71]_i_9_n_0\,
      I2 => \data_out[71]_i_2_n_0\,
      I3 => \data_out[71]_i_4_n_0\,
      I4 => \data_out[69]_i_9_n_0\,
      I5 => \data_out[69]_i_10_n_0\,
      O => \data_out[66]_i_6_n_0\
    );
\data_out[67]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[67]_i_2_n_0\,
      I1 => \data_out[67]_i_3_n_0\,
      O => \^d\(67)
    );
\data_out[67]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[69]_i_2_n_0\,
      I1 => \data_out[71]_i_3_n_0\,
      I2 => \data_out[69]_i_4_n_0\,
      I3 => \data_out[66]_i_3_n_0\,
      I4 => \data_out[67]_i_4_n_0\,
      I5 => \data_out[67]_i_5_n_0\,
      O => \data_out[67]_i_2_n_0\
    );
\data_out[67]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(6),
      I2 => \^d\(36),
      I3 => \^d\(19),
      I4 => \^d\(34),
      I5 => \^d\(4),
      O => \data_out[67]_i_3_n_0\
    );
\data_out[67]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(33),
      I1 => \^d\(18),
      I2 => \^d\(49),
      I3 => \data_out[71]_i_2_n_0\,
      I4 => \data_out[71]_i_4_n_0\,
      I5 => \data_out[69]_i_9_n_0\,
      O => \data_out[67]_i_4_n_0\
    );
\data_out[67]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(8),
      I1 => \^d\(38),
      I2 => \^d\(5),
      I3 => \^d\(35),
      I4 => \^d\(37),
      I5 => \^d\(7),
      O => \data_out[67]_i_5_n_0\
    );
\data_out[68]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[68]_i_2_n_0\,
      I1 => \data_out[68]_i_3_n_0\,
      O => \^d\(68)
    );
\data_out[68]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[69]_i_2_n_0\,
      I1 => \data_out[71]_i_3_n_0\,
      I2 => \data_out[69]_i_4_n_0\,
      I3 => \data_out[66]_i_3_n_0\,
      I4 => \data_out[68]_i_4_n_0\,
      I5 => \data_out[68]_i_5_n_0\,
      O => \data_out[68]_i_2_n_0\
    );
\data_out[68]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(13),
      I2 => \^d\(44),
      I3 => \^d\(19),
      I4 => \^d\(42),
      I5 => \^d\(11),
      O => \data_out[68]_i_3_n_0\
    );
\data_out[68]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(18),
      I1 => \^d\(49),
      I2 => \^d\(41),
      I3 => \data_out[71]_i_9_n_0\,
      I4 => \data_out[71]_i_4_n_0\,
      I5 => \data_out[69]_i_10_n_0\,
      O => \data_out[68]_i_4_n_0\
    );
\data_out[68]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(46),
      I1 => \^d\(15),
      I2 => \^d\(43),
      I3 => \^d\(12),
      I4 => \^d\(45),
      I5 => \^d\(14),
      O => \data_out[68]_i_5_n_0\
    );
\data_out[69]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[69]_i_2_n_0\,
      I1 => \data_out[69]_i_3_n_0\,
      I2 => \data_out[69]_i_4_n_0\,
      I3 => \data_out[69]_i_5_n_0\,
      I4 => \data_out[69]_i_6_n_0\,
      I5 => \data_out[69]_i_7_n_0\,
      O => \^d\(69)
    );
\data_out[69]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(47),
      I1 => \^d\(48),
      O => \data_out[69]_i_10_n_0\
    );
\data_out[69]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(53),
      I1 => \^d\(54),
      O => \data_out[69]_i_2_n_0\
    );
\data_out[69]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(35),
      I1 => \^d\(31),
      I2 => \^d\(27),
      I3 => \^d\(37),
      I4 => \^d\(45),
      I5 => \^d\(29),
      O => \data_out[69]_i_3_n_0\
    );
\data_out[69]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(51),
      I1 => \^d\(52),
      O => \data_out[69]_i_4_n_0\
    );
\data_out[69]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(26),
      I1 => \^d\(46),
      I2 => \^d\(32),
      I3 => \^d\(38),
      I4 => \^d\(30),
      I5 => \^d\(43),
      O => \data_out[69]_i_5_n_0\
    );
\data_out[69]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(50),
      I1 => \^d\(44),
      I2 => \^d\(36),
      I3 => \^d\(28),
      I4 => \^d\(34),
      I5 => \^d\(42),
      O => \data_out[69]_i_6_n_0\
    );
\data_out[69]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(33),
      I1 => \^d\(49),
      I2 => \^d\(41),
      I3 => \data_out[69]_i_8_n_0\,
      I4 => \data_out[69]_i_9_n_0\,
      I5 => \data_out[69]_i_10_n_0\,
      O => \data_out[69]_i_7_n_0\
    );
\data_out[69]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(55),
      I1 => \^d\(56),
      O => \data_out[69]_i_8_n_0\
    );
\data_out[69]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(39),
      I1 => \^d\(40),
      O => \data_out[69]_i_9_n_0\
    );
\data_out[70]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_out[70]_i_2_n_0\,
      I1 => \^d\(60),
      O => \^d\(70)
    );
\data_out[70]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(57),
      I1 => \^d\(59),
      I2 => \^d\(63),
      I3 => \^d\(61),
      I4 => \^d\(62),
      I5 => \^d\(58),
      O => \data_out[70]_i_2_n_0\
    );
\data_out[71]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_out[71]_i_2_n_0\,
      I1 => \data_out[71]_i_3_n_0\,
      I2 => \data_out[71]_i_4_n_0\,
      I3 => \data_out[71]_i_5_n_0\,
      I4 => \data_out[71]_i_6_n_0\,
      I5 => \data_out[71]_i_7_n_0\,
      O => \^d\(71)
    );
\data_out[71]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(9),
      I1 => \^d\(10),
      O => \data_out[71]_i_2_n_0\
    );
\data_out[71]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(20),
      I1 => \^d\(21),
      O => \data_out[71]_i_3_n_0\
    );
\data_out[71]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(22),
      I1 => \^d\(23),
      O => \data_out[71]_i_4_n_0\
    );
\data_out[71]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(1),
      I1 => \^d\(0),
      I2 => \^d\(13),
      I3 => \^d\(6),
      I4 => \^d\(19),
      I5 => \^d\(11),
      O => \data_out[71]_i_5_n_0\
    );
\data_out[71]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(4),
      I1 => \^d\(8),
      I2 => \^d\(3),
      I3 => \^d\(15),
      I4 => \^d\(5),
      I5 => \^d\(2),
      O => \data_out[71]_i_6_n_0\
    );
\data_out[71]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(12),
      I1 => \^d\(14),
      I2 => \^d\(7),
      I3 => \^d\(18),
      I4 => \data_out[71]_i_8_n_0\,
      I5 => \data_out[71]_i_9_n_0\,
      O => \data_out[71]_i_7_n_0\
    );
\data_out[71]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(24),
      I1 => \^d\(25),
      O => \data_out[71]_i_8_n_0\
    );
\data_out[71]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^d\(16),
      I1 => \^d\(17),
      O => \data_out[71]_i_9_n_0\
    );
\data_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(0),
      Q => \^d\(0),
      R => ecc_reset
    );
\data_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(10),
      Q => \^d\(10),
      R => ecc_reset
    );
\data_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(11),
      Q => \^d\(11),
      R => ecc_reset
    );
\data_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(12),
      Q => \^d\(12),
      R => ecc_reset
    );
\data_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(13),
      Q => \^d\(13),
      R => ecc_reset
    );
\data_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(14),
      Q => \^d\(14),
      R => ecc_reset
    );
\data_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(15),
      Q => \^d\(15),
      R => ecc_reset
    );
\data_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(16),
      Q => \^d\(16),
      R => ecc_reset
    );
\data_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(17),
      Q => \^d\(17),
      R => ecc_reset
    );
\data_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(18),
      Q => \^d\(18),
      R => ecc_reset
    );
\data_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(19),
      Q => \^d\(19),
      R => ecc_reset
    );
\data_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(1),
      Q => \^d\(1),
      R => ecc_reset
    );
\data_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(20),
      Q => \^d\(20),
      R => ecc_reset
    );
\data_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(21),
      Q => \^d\(21),
      R => ecc_reset
    );
\data_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(22),
      Q => \^d\(22),
      R => ecc_reset
    );
\data_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(23),
      Q => \^d\(23),
      R => ecc_reset
    );
\data_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(24),
      Q => \^d\(24),
      R => ecc_reset
    );
\data_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(25),
      Q => \^d\(25),
      R => ecc_reset
    );
\data_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(26),
      Q => \^d\(26),
      R => ecc_reset
    );
\data_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(27),
      Q => \^d\(27),
      R => ecc_reset
    );
\data_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(28),
      Q => \^d\(28),
      R => ecc_reset
    );
\data_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(29),
      Q => \^d\(29),
      R => ecc_reset
    );
\data_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(2),
      Q => \^d\(2),
      R => ecc_reset
    );
\data_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(30),
      Q => \^d\(30),
      R => ecc_reset
    );
\data_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(31),
      Q => \^d\(31),
      R => ecc_reset
    );
\data_out_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(32),
      Q => \^d\(32),
      R => ecc_reset
    );
\data_out_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(33),
      Q => \^d\(33),
      R => ecc_reset
    );
\data_out_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(34),
      Q => \^d\(34),
      R => ecc_reset
    );
\data_out_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(35),
      Q => \^d\(35),
      R => ecc_reset
    );
\data_out_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(36),
      Q => \^d\(36),
      R => ecc_reset
    );
\data_out_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(37),
      Q => \^d\(37),
      R => ecc_reset
    );
\data_out_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(38),
      Q => \^d\(38),
      R => ecc_reset
    );
\data_out_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(39),
      Q => \^d\(39),
      R => ecc_reset
    );
\data_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(3),
      Q => \^d\(3),
      R => ecc_reset
    );
\data_out_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(40),
      Q => \^d\(40),
      R => ecc_reset
    );
\data_out_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(41),
      Q => \^d\(41),
      R => ecc_reset
    );
\data_out_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(42),
      Q => \^d\(42),
      R => ecc_reset
    );
\data_out_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(43),
      Q => \^d\(43),
      R => ecc_reset
    );
\data_out_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(44),
      Q => \^d\(44),
      R => ecc_reset
    );
\data_out_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(45),
      Q => \^d\(45),
      R => ecc_reset
    );
\data_out_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(46),
      Q => \^d\(46),
      R => ecc_reset
    );
\data_out_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(47),
      Q => \^d\(47),
      R => ecc_reset
    );
\data_out_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(48),
      Q => \^d\(48),
      R => ecc_reset
    );
\data_out_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(49),
      Q => \^d\(49),
      R => ecc_reset
    );
\data_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(4),
      Q => \^d\(4),
      R => ecc_reset
    );
\data_out_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(50),
      Q => \^d\(50),
      R => ecc_reset
    );
\data_out_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(51),
      Q => \^d\(51),
      R => ecc_reset
    );
\data_out_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(52),
      Q => \^d\(52),
      R => ecc_reset
    );
\data_out_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(53),
      Q => \^d\(53),
      R => ecc_reset
    );
\data_out_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(54),
      Q => \^d\(54),
      R => ecc_reset
    );
\data_out_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(55),
      Q => \^d\(55),
      R => ecc_reset
    );
\data_out_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(56),
      Q => \^d\(56),
      R => ecc_reset
    );
\data_out_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(57),
      Q => \^d\(57),
      R => ecc_reset
    );
\data_out_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(58),
      Q => \^d\(58),
      R => ecc_reset
    );
\data_out_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(59),
      Q => \^d\(59),
      R => ecc_reset
    );
\data_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(5),
      Q => \^d\(5),
      R => ecc_reset
    );
\data_out_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(60),
      Q => \^d\(60),
      R => ecc_reset
    );
\data_out_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(61),
      Q => \^d\(61),
      R => ecc_reset
    );
\data_out_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(62),
      Q => \^d\(62),
      R => ecc_reset
    );
\data_out_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(63),
      Q => \^d\(63),
      R => ecc_reset
    );
\data_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(6),
      Q => \^d\(6),
      R => ecc_reset
    );
\data_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(7),
      Q => \^d\(7),
      R => ecc_reset
    );
\data_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(8),
      Q => \^d\(8),
      R => ecc_reset
    );
\data_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => ecc_data_in(9),
      Q => \^d\(9),
      R => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 71 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 71 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0\ : entity is "ecc_v2_0_reg_stage";
end \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0\;

architecture STRUCTURE of \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0\ is
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
\data_out_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(66),
      Q => Q(66),
      R => ecc_reset
    );
\data_out_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(67),
      Q => Q(67),
      R => ecc_reset
    );
\data_out_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(68),
      Q => Q(68),
      R => ecc_reset
    );
\data_out_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(69),
      Q => Q(69),
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
\data_out_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(70),
      Q => Q(70),
      R => ecc_reset
    );
\data_out_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(71),
      Q => Q(71),
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
entity \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 71 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 71 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1\ : entity is "ecc_v2_0_reg_stage";
end \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1\;

architecture STRUCTURE of \xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1\ is
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
\data_out_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(66),
      Q => Q(66),
      R => ecc_reset
    );
\data_out_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(67),
      Q => Q(67),
      R => ecc_reset
    );
\data_out_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(68),
      Q => Q(68),
      R => ecc_reset
    );
\data_out_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(69),
      Q => Q(69),
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
\data_out_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(70),
      Q => Q(70),
      R => ecc_reset
    );
\data_out_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => ecc_clk,
      CE => ecc_clken,
      D => D(71),
      Q => Q(71),
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
entity xil_ecc_enc_64x8_ecc_v2_0_hamming_enc is
  port (
    ecc_chkbits_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ecc_data_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_enc_64x8_ecc_v2_0_hamming_enc : entity is "ecc_v2_0_hamming_enc";
end xil_ecc_enc_64x8_ecc_v2_0_hamming_enc;

architecture STRUCTURE of xil_ecc_enc_64x8_ecc_v2_0_hamming_enc is
  signal enc_chkbits_pipe0 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_1 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_10 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_11 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_12 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_13 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_14 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_15 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_16 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_17 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_18 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_19 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_2 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_20 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_21 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_22 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_23 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_24 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_25 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_26 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_27 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_28 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_29 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_3 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_30 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_31 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_32 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_33 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_34 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_35 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_36 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_37 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_38 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_39 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_40 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_41 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_42 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_43 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_44 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_45 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_46 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_47 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_48 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_49 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_50 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_51 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_52 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_53 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_54 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_55 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_56 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_57 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_58 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_59 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_60 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_61 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_62 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_63 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_64 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_65 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_66 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_67 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_68 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_69 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_70 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_71 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_8 : STD_LOGIC;
  signal enc_pipe_reg_stage_inst_n_9 : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in12_in : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC;
  signal p_0_in47_in : STD_LOGIC;
  signal p_10_in : STD_LOGIC;
  signal p_11_in : STD_LOGIC;
  signal p_11_in17_in : STD_LOGIC;
  signal p_11_in25_in : STD_LOGIC;
  signal p_11_in32_in : STD_LOGIC;
  signal p_12_in : STD_LOGIC;
  signal p_12_in26_in : STD_LOGIC;
  signal p_13_in : STD_LOGIC;
  signal p_13_in18_in : STD_LOGIC;
  signal p_13_in27_in : STD_LOGIC;
  signal p_14_in : STD_LOGIC;
  signal p_14_in28_in : STD_LOGIC;
  signal p_15_in : STD_LOGIC;
  signal p_15_in19_in : STD_LOGIC;
  signal p_15_in33_in : STD_LOGIC;
  signal p_15_in36_in : STD_LOGIC;
  signal p_15_in40_in : STD_LOGIC;
  signal p_15_in43_in : STD_LOGIC;
  signal p_16_in : STD_LOGIC;
  signal p_16_in37_in : STD_LOGIC;
  signal p_17_in : STD_LOGIC;
  signal p_17_in20_in : STD_LOGIC;
  signal p_17_in41_in : STD_LOGIC;
  signal p_18_in : STD_LOGIC;
  signal p_19_in : STD_LOGIC;
  signal p_19_in21_in : STD_LOGIC;
  signal p_19_in34_in : STD_LOGIC;
  signal p_1_in0_in : STD_LOGIC;
  signal p_1_in2_in : STD_LOGIC;
  signal p_1_in48_in : STD_LOGIC;
  signal p_20_in : STD_LOGIC;
  signal p_21_in : STD_LOGIC;
  signal p_21_in22_in : STD_LOGIC;
  signal p_22_in : STD_LOGIC;
  signal p_23_in : STD_LOGIC;
  signal p_23_in23_in : STD_LOGIC;
  signal p_23_in35_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_2_in3_in : STD_LOGIC;
  signal p_2_in49_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_3_in13_in : STD_LOGIC;
  signal p_3_in30_in : STD_LOGIC;
  signal p_3_in4_in : STD_LOGIC;
  signal p_42_in : STD_LOGIC;
  signal p_44_out : STD_LOGIC_VECTOR ( 71 downto 1 );
  signal p_46_in : STD_LOGIC;
  signal p_4_in : STD_LOGIC;
  signal p_4_in5_in : STD_LOGIC;
  signal p_5_in : STD_LOGIC;
  signal p_5_in14_in : STD_LOGIC;
  signal p_5_in6_in : STD_LOGIC;
  signal p_6_in : STD_LOGIC;
  signal p_6_in7_in : STD_LOGIC;
  signal p_7_in : STD_LOGIC;
  signal p_7_in15_in : STD_LOGIC;
  signal p_7_in31_in : STD_LOGIC;
  signal p_7_in39_in : STD_LOGIC;
  signal p_7_in8_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal p_8_in9_in : STD_LOGIC;
  signal p_9_in : STD_LOGIC;
  signal p_9_in16_in : STD_LOGIC;
  signal p_9_in24_in : STD_LOGIC;
  signal xor_bits_0_25_pipe : STD_LOGIC;
begin
\data_out[64]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => enc_pipe_reg_stage_inst_n_3,
      I1 => xor_bits_0_25_pipe,
      I2 => p_46_in,
      I3 => p_1_in48_in,
      I4 => p_2_in49_in,
      I5 => p_0_in47_in,
      O => enc_chkbits_pipe0
    );
enc_input_reg_stage_inst: entity work.xil_ecc_enc_64x8_ecc_v2_0_reg_stage
     port map (
      D(71 downto 64) => p_44_out(71 downto 64),
      D(63) => p_42_in,
      D(62) => p_14_in28_in,
      D(61) => p_8_in9_in,
      D(60) => p_16_in37_in,
      D(59) => p_7_in8_in,
      D(58) => p_13_in27_in,
      D(57) => p_6_in7_in,
      D(56) => p_5_in6_in,
      D(55) => p_12_in26_in,
      D(54) => p_4_in5_in,
      D(53) => p_15_in36_in,
      D(52) => p_3_in4_in,
      D(51) => p_11_in25_in,
      D(50) => p_2_in3_in,
      D(49) => p_17_in41_in,
      D(48) => p_1_in2_in,
      D(47) => p_9_in24_in,
      D(46) => p_0_in1_in,
      D(45) => p_23_in35_in,
      D(44) => p_23_in,
      D(43) => p_23_in23_in,
      D(42) => p_22_in,
      D(41) => p_15_in43_in,
      D(40) => p_21_in,
      D(39) => p_21_in22_in,
      D(38) => p_20_in,
      D(37) => p_19_in34_in,
      D(36) => p_19_in,
      D(35) => p_19_in21_in,
      D(34) => p_18_in,
      D(33) => p_15_in40_in,
      D(32) => p_17_in,
      D(31) => p_17_in20_in,
      D(30) => p_16_in,
      D(29) => p_15_in33_in,
      D(28) => p_15_in,
      D(27) => p_15_in19_in,
      D(26) => p_14_in,
      D(25) => p_13_in,
      D(24) => p_13_in18_in,
      D(23) => p_12_in,
      D(22) => p_11_in32_in,
      D(21) => p_11_in,
      D(20) => p_11_in17_in,
      D(19) => p_10_in,
      D(18) => p_7_in39_in,
      D(17) => p_9_in,
      D(16) => p_9_in16_in,
      D(15) => p_8_in,
      D(14) => p_7_in31_in,
      D(13) => p_7_in,
      D(12) => p_7_in15_in,
      D(11) => p_6_in,
      D(10) => p_5_in,
      D(9) => p_5_in14_in,
      D(8) => p_4_in,
      D(7) => p_3_in30_in,
      D(6) => p_3_in,
      D(5) => p_3_in13_in,
      D(4) => p_2_in,
      D(3) => p_0_in,
      D(2) => p_0_in12_in,
      D(1) => p_44_out(1),
      D(0) => p_1_in0_in,
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_data_in(63 downto 0) => ecc_data_in(63 downto 0),
      ecc_reset => ecc_reset
    );
enc_output_reg_stage_inst: entity work.\xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1\
     port map (
      D(71) => enc_pipe_reg_stage_inst_n_1,
      D(70) => enc_pipe_reg_stage_inst_n_2,
      D(69) => enc_pipe_reg_stage_inst_n_3,
      D(68) => p_2_in49_in,
      D(67) => p_1_in48_in,
      D(66) => p_0_in47_in,
      D(65) => p_46_in,
      D(64) => enc_chkbits_pipe0,
      D(63) => enc_pipe_reg_stage_inst_n_8,
      D(62) => enc_pipe_reg_stage_inst_n_9,
      D(61) => enc_pipe_reg_stage_inst_n_10,
      D(60) => enc_pipe_reg_stage_inst_n_11,
      D(59) => enc_pipe_reg_stage_inst_n_12,
      D(58) => enc_pipe_reg_stage_inst_n_13,
      D(57) => enc_pipe_reg_stage_inst_n_14,
      D(56) => enc_pipe_reg_stage_inst_n_15,
      D(55) => enc_pipe_reg_stage_inst_n_16,
      D(54) => enc_pipe_reg_stage_inst_n_17,
      D(53) => enc_pipe_reg_stage_inst_n_18,
      D(52) => enc_pipe_reg_stage_inst_n_19,
      D(51) => enc_pipe_reg_stage_inst_n_20,
      D(50) => enc_pipe_reg_stage_inst_n_21,
      D(49) => enc_pipe_reg_stage_inst_n_22,
      D(48) => enc_pipe_reg_stage_inst_n_23,
      D(47) => enc_pipe_reg_stage_inst_n_24,
      D(46) => enc_pipe_reg_stage_inst_n_25,
      D(45) => enc_pipe_reg_stage_inst_n_26,
      D(44) => enc_pipe_reg_stage_inst_n_27,
      D(43) => enc_pipe_reg_stage_inst_n_28,
      D(42) => enc_pipe_reg_stage_inst_n_29,
      D(41) => enc_pipe_reg_stage_inst_n_30,
      D(40) => enc_pipe_reg_stage_inst_n_31,
      D(39) => enc_pipe_reg_stage_inst_n_32,
      D(38) => enc_pipe_reg_stage_inst_n_33,
      D(37) => enc_pipe_reg_stage_inst_n_34,
      D(36) => enc_pipe_reg_stage_inst_n_35,
      D(35) => enc_pipe_reg_stage_inst_n_36,
      D(34) => enc_pipe_reg_stage_inst_n_37,
      D(33) => enc_pipe_reg_stage_inst_n_38,
      D(32) => enc_pipe_reg_stage_inst_n_39,
      D(31) => enc_pipe_reg_stage_inst_n_40,
      D(30) => enc_pipe_reg_stage_inst_n_41,
      D(29) => enc_pipe_reg_stage_inst_n_42,
      D(28) => enc_pipe_reg_stage_inst_n_43,
      D(27) => enc_pipe_reg_stage_inst_n_44,
      D(26) => enc_pipe_reg_stage_inst_n_45,
      D(25) => enc_pipe_reg_stage_inst_n_46,
      D(24) => enc_pipe_reg_stage_inst_n_47,
      D(23) => enc_pipe_reg_stage_inst_n_48,
      D(22) => enc_pipe_reg_stage_inst_n_49,
      D(21) => enc_pipe_reg_stage_inst_n_50,
      D(20) => enc_pipe_reg_stage_inst_n_51,
      D(19) => enc_pipe_reg_stage_inst_n_52,
      D(18) => enc_pipe_reg_stage_inst_n_53,
      D(17) => enc_pipe_reg_stage_inst_n_54,
      D(16) => enc_pipe_reg_stage_inst_n_55,
      D(15) => enc_pipe_reg_stage_inst_n_56,
      D(14) => enc_pipe_reg_stage_inst_n_57,
      D(13) => enc_pipe_reg_stage_inst_n_58,
      D(12) => enc_pipe_reg_stage_inst_n_59,
      D(11) => enc_pipe_reg_stage_inst_n_60,
      D(10) => enc_pipe_reg_stage_inst_n_61,
      D(9) => enc_pipe_reg_stage_inst_n_62,
      D(8) => enc_pipe_reg_stage_inst_n_63,
      D(7) => enc_pipe_reg_stage_inst_n_64,
      D(6) => enc_pipe_reg_stage_inst_n_65,
      D(5) => enc_pipe_reg_stage_inst_n_66,
      D(4) => enc_pipe_reg_stage_inst_n_67,
      D(3) => enc_pipe_reg_stage_inst_n_68,
      D(2) => enc_pipe_reg_stage_inst_n_69,
      D(1) => enc_pipe_reg_stage_inst_n_70,
      D(0) => enc_pipe_reg_stage_inst_n_71,
      Q(71 downto 64) => ecc_chkbits_out(7 downto 0),
      Q(63 downto 0) => ecc_data_out(63 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_reset => ecc_reset
    );
enc_pipe_reg_stage_inst: entity work.\xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0\
     port map (
      D(71 downto 64) => p_44_out(71 downto 64),
      D(63) => p_42_in,
      D(62) => p_14_in28_in,
      D(61) => p_8_in9_in,
      D(60) => p_16_in37_in,
      D(59) => p_7_in8_in,
      D(58) => p_13_in27_in,
      D(57) => p_6_in7_in,
      D(56) => p_5_in6_in,
      D(55) => p_12_in26_in,
      D(54) => p_4_in5_in,
      D(53) => p_15_in36_in,
      D(52) => p_3_in4_in,
      D(51) => p_11_in25_in,
      D(50) => p_2_in3_in,
      D(49) => p_17_in41_in,
      D(48) => p_1_in2_in,
      D(47) => p_9_in24_in,
      D(46) => p_0_in1_in,
      D(45) => p_23_in35_in,
      D(44) => p_23_in,
      D(43) => p_23_in23_in,
      D(42) => p_22_in,
      D(41) => p_15_in43_in,
      D(40) => p_21_in,
      D(39) => p_21_in22_in,
      D(38) => p_20_in,
      D(37) => p_19_in34_in,
      D(36) => p_19_in,
      D(35) => p_19_in21_in,
      D(34) => p_18_in,
      D(33) => p_15_in40_in,
      D(32) => p_17_in,
      D(31) => p_17_in20_in,
      D(30) => p_16_in,
      D(29) => p_15_in33_in,
      D(28) => p_15_in,
      D(27) => p_15_in19_in,
      D(26) => p_14_in,
      D(25) => p_13_in,
      D(24) => p_13_in18_in,
      D(23) => p_12_in,
      D(22) => p_11_in32_in,
      D(21) => p_11_in,
      D(20) => p_11_in17_in,
      D(19) => p_10_in,
      D(18) => p_7_in39_in,
      D(17) => p_9_in,
      D(16) => p_9_in16_in,
      D(15) => p_8_in,
      D(14) => p_7_in31_in,
      D(13) => p_7_in,
      D(12) => p_7_in15_in,
      D(11) => p_6_in,
      D(10) => p_5_in,
      D(9) => p_5_in14_in,
      D(8) => p_4_in,
      D(7) => p_3_in30_in,
      D(6) => p_3_in,
      D(5) => p_3_in13_in,
      D(4) => p_2_in,
      D(3) => p_0_in,
      D(2) => p_0_in12_in,
      D(1) => p_44_out(1),
      D(0) => p_1_in0_in,
      Q(71) => xor_bits_0_25_pipe,
      Q(70) => enc_pipe_reg_stage_inst_n_1,
      Q(69) => enc_pipe_reg_stage_inst_n_2,
      Q(68) => enc_pipe_reg_stage_inst_n_3,
      Q(67) => p_2_in49_in,
      Q(66) => p_1_in48_in,
      Q(65) => p_0_in47_in,
      Q(64) => p_46_in,
      Q(63) => enc_pipe_reg_stage_inst_n_8,
      Q(62) => enc_pipe_reg_stage_inst_n_9,
      Q(61) => enc_pipe_reg_stage_inst_n_10,
      Q(60) => enc_pipe_reg_stage_inst_n_11,
      Q(59) => enc_pipe_reg_stage_inst_n_12,
      Q(58) => enc_pipe_reg_stage_inst_n_13,
      Q(57) => enc_pipe_reg_stage_inst_n_14,
      Q(56) => enc_pipe_reg_stage_inst_n_15,
      Q(55) => enc_pipe_reg_stage_inst_n_16,
      Q(54) => enc_pipe_reg_stage_inst_n_17,
      Q(53) => enc_pipe_reg_stage_inst_n_18,
      Q(52) => enc_pipe_reg_stage_inst_n_19,
      Q(51) => enc_pipe_reg_stage_inst_n_20,
      Q(50) => enc_pipe_reg_stage_inst_n_21,
      Q(49) => enc_pipe_reg_stage_inst_n_22,
      Q(48) => enc_pipe_reg_stage_inst_n_23,
      Q(47) => enc_pipe_reg_stage_inst_n_24,
      Q(46) => enc_pipe_reg_stage_inst_n_25,
      Q(45) => enc_pipe_reg_stage_inst_n_26,
      Q(44) => enc_pipe_reg_stage_inst_n_27,
      Q(43) => enc_pipe_reg_stage_inst_n_28,
      Q(42) => enc_pipe_reg_stage_inst_n_29,
      Q(41) => enc_pipe_reg_stage_inst_n_30,
      Q(40) => enc_pipe_reg_stage_inst_n_31,
      Q(39) => enc_pipe_reg_stage_inst_n_32,
      Q(38) => enc_pipe_reg_stage_inst_n_33,
      Q(37) => enc_pipe_reg_stage_inst_n_34,
      Q(36) => enc_pipe_reg_stage_inst_n_35,
      Q(35) => enc_pipe_reg_stage_inst_n_36,
      Q(34) => enc_pipe_reg_stage_inst_n_37,
      Q(33) => enc_pipe_reg_stage_inst_n_38,
      Q(32) => enc_pipe_reg_stage_inst_n_39,
      Q(31) => enc_pipe_reg_stage_inst_n_40,
      Q(30) => enc_pipe_reg_stage_inst_n_41,
      Q(29) => enc_pipe_reg_stage_inst_n_42,
      Q(28) => enc_pipe_reg_stage_inst_n_43,
      Q(27) => enc_pipe_reg_stage_inst_n_44,
      Q(26) => enc_pipe_reg_stage_inst_n_45,
      Q(25) => enc_pipe_reg_stage_inst_n_46,
      Q(24) => enc_pipe_reg_stage_inst_n_47,
      Q(23) => enc_pipe_reg_stage_inst_n_48,
      Q(22) => enc_pipe_reg_stage_inst_n_49,
      Q(21) => enc_pipe_reg_stage_inst_n_50,
      Q(20) => enc_pipe_reg_stage_inst_n_51,
      Q(19) => enc_pipe_reg_stage_inst_n_52,
      Q(18) => enc_pipe_reg_stage_inst_n_53,
      Q(17) => enc_pipe_reg_stage_inst_n_54,
      Q(16) => enc_pipe_reg_stage_inst_n_55,
      Q(15) => enc_pipe_reg_stage_inst_n_56,
      Q(14) => enc_pipe_reg_stage_inst_n_57,
      Q(13) => enc_pipe_reg_stage_inst_n_58,
      Q(12) => enc_pipe_reg_stage_inst_n_59,
      Q(11) => enc_pipe_reg_stage_inst_n_60,
      Q(10) => enc_pipe_reg_stage_inst_n_61,
      Q(9) => enc_pipe_reg_stage_inst_n_62,
      Q(8) => enc_pipe_reg_stage_inst_n_63,
      Q(7) => enc_pipe_reg_stage_inst_n_64,
      Q(6) => enc_pipe_reg_stage_inst_n_65,
      Q(5) => enc_pipe_reg_stage_inst_n_66,
      Q(4) => enc_pipe_reg_stage_inst_n_67,
      Q(3) => enc_pipe_reg_stage_inst_n_68,
      Q(2) => enc_pipe_reg_stage_inst_n_69,
      Q(1) => enc_pipe_reg_stage_inst_n_70,
      Q(0) => enc_pipe_reg_stage_inst_n_71,
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_reset => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_enc_64x8_ecc_v2_0 is
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
  attribute C_CHK_BIT_WIDTH of xil_ecc_enc_64x8_ecc_v2_0 : entity is 8;
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of xil_ecc_enc_64x8_ecc_v2_0 : entity is "xil_ecc_enc_64x8";
  attribute C_DATA_WIDTH : integer;
  attribute C_DATA_WIDTH of xil_ecc_enc_64x8_ecc_v2_0 : entity is 64;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of xil_ecc_enc_64x8_ecc_v2_0 : entity is 0;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of xil_ecc_enc_64x8_ecc_v2_0 : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of xil_ecc_enc_64x8_ecc_v2_0 : entity is "virtexu";
  attribute C_PIPELINE : integer;
  attribute C_PIPELINE of xil_ecc_enc_64x8_ecc_v2_0 : entity is 1;
  attribute C_REG_INPUT : integer;
  attribute C_REG_INPUT of xil_ecc_enc_64x8_ecc_v2_0 : entity is 1;
  attribute C_REG_OUTPUT : integer;
  attribute C_REG_OUTPUT of xil_ecc_enc_64x8_ecc_v2_0 : entity is 1;
  attribute C_USE_CLK_ENABLE : integer;
  attribute C_USE_CLK_ENABLE of xil_ecc_enc_64x8_ecc_v2_0 : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xil_ecc_enc_64x8_ecc_v2_0 : entity is "ecc_v2_0";
  attribute TCQ : integer;
  attribute TCQ of xil_ecc_enc_64x8_ecc_v2_0 : entity is 100;
end xil_ecc_enc_64x8_ecc_v2_0;

architecture STRUCTURE of xil_ecc_enc_64x8_ecc_v2_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  ecc_dbit_err <= \<const0>\;
  ecc_sbit_err <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\hamming_ecc_enc_gen.hamming_enc_inst\: entity work.xil_ecc_enc_64x8_ecc_v2_0_hamming_enc
     port map (
      ecc_chkbits_out(7 downto 0) => ecc_chkbits_out(7 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_data_in(63 downto 0) => ecc_data_in(63 downto 0),
      ecc_data_out(63 downto 0) => ecc_data_out(63 downto 0),
      ecc_reset => ecc_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xil_ecc_enc_64x8 is
  port (
    ecc_clk : in STD_LOGIC;
    ecc_reset : in STD_LOGIC;
    ecc_clken : in STD_LOGIC;
    ecc_data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_data_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ecc_chkbits_out : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of xil_ecc_enc_64x8 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of xil_ecc_enc_64x8 : entity is "xil_ecc_enc_64x8,ecc_v2_0,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of xil_ecc_enc_64x8 : entity is "xil_ecc_enc_64x8,ecc_v2_0,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ecc,x_ipVersion=2.0,x_ipCoreRevision=8,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=virtexu,C_COMPONENT_NAME=xil_ecc_enc_64x8,C_ECC_MODE=0,C_ECC_TYPE=0,C_DATA_WIDTH=64,C_CHK_BIT_WIDTH=8,C_REG_INPUT=1,C_REG_OUTPUT=1,C_PIPELINE=1,C_USE_CLK_ENABLE=1}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of xil_ecc_enc_64x8 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of xil_ecc_enc_64x8 : entity is "ecc_v2_0,Vivado 2015.2";
end xil_ecc_enc_64x8;

architecture STRUCTURE of xil_ecc_enc_64x8 is
  signal NLW_inst_ecc_dbit_err_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_ecc_sbit_err_UNCONNECTED : STD_LOGIC;
  attribute C_CHK_BIT_WIDTH : integer;
  attribute C_CHK_BIT_WIDTH of inst : label is 8;
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of inst : label is "xil_ecc_enc_64x8";
  attribute C_DATA_WIDTH : integer;
  attribute C_DATA_WIDTH of inst : label is 64;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of inst : label is 0;
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
inst: entity work.xil_ecc_enc_64x8_ecc_v2_0
     port map (
      ecc_chkbits_in(7) => '0',
      ecc_chkbits_in(6) => '0',
      ecc_chkbits_in(5) => '0',
      ecc_chkbits_in(4) => '0',
      ecc_chkbits_in(3) => '0',
      ecc_chkbits_in(2) => '0',
      ecc_chkbits_in(1) => '0',
      ecc_chkbits_in(0) => '0',
      ecc_chkbits_out(7 downto 0) => ecc_chkbits_out(7 downto 0),
      ecc_clk => ecc_clk,
      ecc_clken => ecc_clken,
      ecc_correct_n => '0',
      ecc_data_in(63 downto 0) => ecc_data_in(63 downto 0),
      ecc_data_out(63 downto 0) => ecc_data_out(63 downto 0),
      ecc_dbit_err => NLW_inst_ecc_dbit_err_UNCONNECTED,
      ecc_encode => '0',
      ecc_reset => ecc_reset,
      ecc_sbit_err => NLW_inst_ecc_sbit_err_UNCONNECTED
    );
end STRUCTURE;
