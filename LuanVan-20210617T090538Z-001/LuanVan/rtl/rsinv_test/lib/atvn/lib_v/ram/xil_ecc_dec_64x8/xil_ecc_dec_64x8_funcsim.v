// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Aug 25 15:50:29 2015
// Host        : linuxsrv13 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/Share4Syn/Thalassa/Cisco/VU190_SYN_15.2_8SLICE_150824/Synthesis/AF6CCI0011_VU190.srcs/sources_1/ip/xil_ecc_dec_64x8/xil_ecc_dec_64x8_funcsim.v
// Design      : xil_ecc_dec_64x8
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcvu190-flgb2104-2-i-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xil_ecc_dec_64x8,ecc_v2_0,{}" *) (* CORE_GENERATION_INFO = "xil_ecc_dec_64x8,ecc_v2_0,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ecc,x_ipVersion=2.0,x_ipCoreRevision=8,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=virtexu,C_COMPONENT_NAME=xil_ecc_dec_64x8,C_ECC_MODE=1,C_ECC_TYPE=0,C_DATA_WIDTH=64,C_CHK_BIT_WIDTH=8,C_REG_INPUT=1,C_REG_OUTPUT=1,C_PIPELINE=1,C_USE_CLK_ENABLE=1}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* X_CORE_INFO = "ecc_v2_0,Vivado 2015.2" *) 
(* NotValidForBitStream *)
module xil_ecc_dec_64x8
   (ecc_clk,
    ecc_reset,
    ecc_correct_n,
    ecc_clken,
    ecc_data_in,
    ecc_data_out,
    ecc_chkbits_in,
    ecc_sbit_err,
    ecc_dbit_err);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ecc_clk CLK" *) input ecc_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ecc_reset RST" *) input ecc_reset;
  input ecc_correct_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 ecc_clken CE" *) input ecc_clken;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_IN DATA" *) input [63:0]ecc_data_in;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_OUT DATA" *) output [63:0]ecc_data_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_CHKBITS_IN DATA" *) input [7:0]ecc_chkbits_in;
  output ecc_sbit_err;
  output ecc_dbit_err;

  wire [7:0]ecc_chkbits_in;
  wire ecc_clk;
  wire ecc_clken;
  wire ecc_correct_n;
  wire [63:0]ecc_data_in;
  wire [63:0]ecc_data_out;
  wire ecc_dbit_err;
  wire ecc_reset;
  wire ecc_sbit_err;
  wire [7:0]NLW_inst_ecc_chkbits_out_UNCONNECTED;

  (* C_CHK_BIT_WIDTH = "8" *) 
  (* C_COMPONENT_NAME = "xil_ecc_dec_64x8" *) 
  (* C_DATA_WIDTH = "64" *) 
  (* C_ECC_MODE = "1" *) 
  (* C_ECC_TYPE = "0" *) 
  (* C_FAMILY = "virtexu" *) 
  (* C_PIPELINE = "1" *) 
  (* C_REG_INPUT = "1" *) 
  (* C_REG_OUTPUT = "1" *) 
  (* C_USE_CLK_ENABLE = "1" *) 
  (* DONT_TOUCH *) 
  (* TCQ = "100" *) 
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_OUT DATA" *) 
  xil_ecc_dec_64x8_ecc_v2_0 inst
       (.ecc_chkbits_in(ecc_chkbits_in),
        .ecc_chkbits_out(NLW_inst_ecc_chkbits_out_UNCONNECTED[7:0]),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_correct_n(ecc_correct_n),
        .ecc_data_in(ecc_data_in),
        .ecc_data_out(ecc_data_out),
        .ecc_dbit_err(ecc_dbit_err),
        .ecc_encode(1'b0),
        .ecc_reset(ecc_reset),
        .ecc_sbit_err(ecc_sbit_err));
endmodule

(* C_CHK_BIT_WIDTH = "8" *) (* C_COMPONENT_NAME = "xil_ecc_dec_64x8" *) (* C_DATA_WIDTH = "64" *) 
(* C_ECC_MODE = "1" *) (* C_ECC_TYPE = "0" *) (* C_FAMILY = "virtexu" *) 
(* C_PIPELINE = "1" *) (* C_REG_INPUT = "1" *) (* C_REG_OUTPUT = "1" *) 
(* C_USE_CLK_ENABLE = "1" *) (* ORIG_REF_NAME = "ecc_v2_0" *) (* TCQ = "100" *) 
module xil_ecc_dec_64x8_ecc_v2_0
   (ecc_clk,
    ecc_reset,
    ecc_encode,
    ecc_correct_n,
    ecc_clken,
    ecc_data_in,
    ecc_data_out,
    ecc_chkbits_out,
    ecc_chkbits_in,
    ecc_sbit_err,
    ecc_dbit_err);
  input ecc_clk;
  input ecc_reset;
  input ecc_encode;
  input ecc_correct_n;
  input ecc_clken;
  input [63:0]ecc_data_in;
  output [63:0]ecc_data_out;
  output [7:0]ecc_chkbits_out;
  input [7:0]ecc_chkbits_in;
  output ecc_sbit_err;
  output ecc_dbit_err;

  wire \<const0> ;
  wire [7:0]ecc_chkbits_in;
  wire ecc_clk;
  wire ecc_clken;
  wire ecc_correct_n;
  wire [63:0]ecc_data_in;
  wire [63:0]ecc_data_out;
  wire ecc_dbit_err;
  wire ecc_reset;
  wire ecc_sbit_err;

  assign ecc_chkbits_out[7] = \<const0> ;
  assign ecc_chkbits_out[6] = \<const0> ;
  assign ecc_chkbits_out[5] = \<const0> ;
  assign ecc_chkbits_out[4] = \<const0> ;
  assign ecc_chkbits_out[3] = \<const0> ;
  assign ecc_chkbits_out[2] = \<const0> ;
  assign ecc_chkbits_out[1] = \<const0> ;
  assign ecc_chkbits_out[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  xil_ecc_dec_64x8_ecc_v2_0_hamming_dec \hamming_ecc_dec_gen.hamming_dec_inst 
       (.D({ecc_correct_n,ecc_chkbits_in,ecc_data_in}),
        .Q({ecc_dbit_err,ecc_sbit_err,ecc_data_out}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_reset(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_hamming_dec" *) 
module xil_ecc_dec_64x8_ecc_v2_0_hamming_dec
   (Q,
    ecc_reset,
    ecc_clken,
    D,
    ecc_clk);
  output [65:0]Q;
  input ecc_reset;
  input ecc_clken;
  input [72:0]D;
  input ecc_clk;

  wire [72:0]D;
  wire [65:0]Q;
  wire [7:1]dec_chkbits_w;
  wire ecc_clk;
  wire ecc_clken;
  wire ecc_reset;
  wire p_0_in15_in;
  wire p_0_in4_in;
  wire p_0_in5_in;
  wire p_10_in;
  wire p_10_in28_in;
  wire p_11_in;
  wire p_11_in20_in;
  wire p_11_in29_in;
  wire p_11_in34_in;
  wire p_12_in;
  wire p_12_in30_in;
  wire p_13_in;
  wire p_13_in21_in;
  wire p_14_in;
  wire p_14_in38_in;
  wire p_15_in;
  wire p_15_in22_in;
  wire p_15_in35_in;
  wire p_15_in39_in;
  wire p_15_in42_in;
  wire p_15_in45_in;
  wire p_16_in;
  wire p_16_in43_in;
  wire p_17_in;
  wire p_17_in23_in;
  wire p_18_in;
  wire p_19_in;
  wire p_19_in24_in;
  wire p_19_in36_in;
  wire p_1_in2_in;
  wire p_1_in3_in;
  wire p_1_in6_in;
  wire p_20_in;
  wire p_21_in;
  wire p_21_in25_in;
  wire p_22_in;
  wire p_23_in;
  wire p_23_in26_in;
  wire p_23_in37_in;
  wire p_24_in;
  wire p_25_in;
  wire p_2_in;
  wire p_2_in7_in;
  wire p_3_in;
  wire p_3_in16_in;
  wire p_3_in32_in;
  wire p_3_in8_in;
  wire [65:0]p_3_out;
  wire p_41_in;
  wire [81:64]p_43_out;
  wire p_4_in;
  wire p_4_in9_in;
  wire p_5_in;
  wire p_5_in10_in;
  wire p_5_in17_in;
  wire p_6_in;
  wire p_6_in11_in;
  wire p_7_in;
  wire p_7_in12_in;
  wire p_7_in18_in;
  wire p_7_in33_in;
  wire p_7_in41_in;
  wire p_8_in;
  wire p_9_in;
  wire p_9_in19_in;
  wire p_9_in27_in;

  xil_ecc_dec_64x8_ecc_v2_0_reg_stage dec_dinput_reg_stage_inst
       (.D({p_43_out[81:72],dec_chkbits_w,p_43_out[64],p_41_in,p_12_in30_in,p_7_in12_in,p_15_in39_in,p_6_in11_in,p_11_in29_in,p_5_in10_in,p_4_in9_in,p_10_in28_in,p_3_in8_in,p_14_in38_in,p_2_in7_in,p_9_in27_in,p_1_in6_in,p_16_in43_in,p_0_in5_in,p_25_in,p_24_in,p_23_in37_in,p_23_in,p_23_in26_in,p_22_in,p_15_in45_in,p_21_in,p_21_in25_in,p_20_in,p_19_in36_in,p_19_in,p_19_in24_in,p_18_in,p_15_in42_in,p_17_in,p_17_in23_in,p_16_in,p_15_in35_in,p_15_in,p_15_in22_in,p_14_in,p_13_in,p_13_in21_in,p_12_in,p_11_in34_in,p_11_in,p_11_in20_in,p_10_in,p_7_in41_in,p_9_in,p_9_in19_in,p_8_in,p_7_in33_in,p_7_in,p_7_in18_in,p_6_in,p_5_in,p_5_in17_in,p_4_in,p_3_in32_in,p_3_in,p_3_in16_in,p_2_in,p_0_in4_in,p_0_in15_in,p_1_in2_in,p_1_in3_in}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_correct_n(D),
        .ecc_reset(ecc_reset));
  xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1 dec_output_reg_stage_inst
       (.D(p_3_out),
        .Q(Q),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_reset(ecc_reset));
  xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0 dec_pipe_reg_stage_inst
       (.D(p_3_out),
        .\data_out_reg[72]_0 ({p_43_out[81:72],dec_chkbits_w,p_43_out[64],p_41_in,p_12_in30_in,p_7_in12_in,p_15_in39_in,p_6_in11_in,p_11_in29_in,p_5_in10_in,p_4_in9_in,p_10_in28_in,p_3_in8_in,p_14_in38_in,p_2_in7_in,p_9_in27_in,p_1_in6_in,p_16_in43_in,p_0_in5_in,p_25_in,p_24_in,p_23_in37_in,p_23_in,p_23_in26_in,p_22_in,p_15_in45_in,p_21_in,p_21_in25_in,p_20_in,p_19_in36_in,p_19_in,p_19_in24_in,p_18_in,p_15_in42_in,p_17_in,p_17_in23_in,p_16_in,p_15_in35_in,p_15_in,p_15_in22_in,p_14_in,p_13_in,p_13_in21_in,p_12_in,p_11_in34_in,p_11_in,p_11_in20_in,p_10_in,p_7_in41_in,p_9_in,p_9_in19_in,p_8_in,p_7_in33_in,p_7_in,p_7_in18_in,p_6_in,p_5_in,p_5_in17_in,p_4_in,p_3_in32_in,p_3_in,p_3_in16_in,p_2_in,p_0_in4_in,p_0_in15_in,p_1_in2_in,p_1_in3_in}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_reset(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_dec_64x8_ecc_v2_0_reg_stage
   (D,
    ecc_reset,
    ecc_clken,
    ecc_correct_n,
    ecc_clk);
  output [81:0]D;
  input ecc_reset;
  input ecc_clken;
  input [72:0]ecc_correct_n;
  input ecc_clk;

  wire [81:0]D;
  wire \data_out[72]_i_2_n_0 ;
  wire \data_out[72]_i_3_n_0 ;
  wire \data_out[72]_i_4_n_0 ;
  wire \data_out[72]_i_5_n_0 ;
  wire \data_out[72]_i_6_n_0 ;
  wire \data_out[72]_i_7_n_0 ;
  wire \data_out[73]_i_2_n_0 ;
  wire \data_out[73]_i_3_n_0 ;
  wire \data_out[73]_i_4_n_0 ;
  wire \data_out[73]_i_5_n_0 ;
  wire \data_out[74]_i_2_n_0 ;
  wire \data_out[74]_i_3_n_0 ;
  wire \data_out[74]_i_4_n_0 ;
  wire \data_out[74]_i_5_n_0 ;
  wire \data_out[74]_i_6_n_0 ;
  wire \data_out[75]_i_2_n_0 ;
  wire \data_out[75]_i_3_n_0 ;
  wire \data_out[75]_i_4_n_0 ;
  wire \data_out[75]_i_5_n_0 ;
  wire \data_out[76]_i_2_n_0 ;
  wire \data_out[76]_i_3_n_0 ;
  wire \data_out[76]_i_4_n_0 ;
  wire \data_out[76]_i_5_n_0 ;
  wire \data_out[77]_i_10_n_0 ;
  wire \data_out[77]_i_2_n_0 ;
  wire \data_out[77]_i_3_n_0 ;
  wire \data_out[77]_i_4_n_0 ;
  wire \data_out[77]_i_5_n_0 ;
  wire \data_out[77]_i_6_n_0 ;
  wire \data_out[77]_i_7_n_0 ;
  wire \data_out[77]_i_8_n_0 ;
  wire \data_out[77]_i_9_n_0 ;
  wire \data_out[78]_i_2_n_0 ;
  wire \data_out[79]_i_2_n_0 ;
  wire \data_out[79]_i_3_n_0 ;
  wire \data_out[79]_i_4_n_0 ;
  wire \data_out[79]_i_5_n_0 ;
  wire \data_out[79]_i_6_n_0 ;
  wire \data_out[79]_i_7_n_0 ;
  wire \data_out[79]_i_8_n_0 ;
  wire \data_out[79]_i_9_n_0 ;
  wire \data_out[80]_i_2_n_0 ;
  wire ecc_clk;
  wire ecc_clken;
  wire [72:0]ecc_correct_n;
  wire ecc_reset;

  LUT5 #(
    .INIT(32'h96696996)) 
    \data_out[72]_i_1 
       (.I0(\data_out[72]_i_2_n_0 ),
        .I1(\data_out[72]_i_3_n_0 ),
        .I2(\data_out[72]_i_4_n_0 ),
        .I3(\data_out[72]_i_5_n_0 ),
        .I4(\data_out[72]_i_6_n_0 ),
        .O(D[72]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_2 
       (.I0(D[13]),
        .I1(D[8]),
        .I2(D[15]),
        .I3(D[19]),
        .I4(D[38]),
        .I5(D[30]),
        .O(\data_out[72]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_3 
       (.I0(D[23]),
        .I1(D[17]),
        .I2(D[21]),
        .I3(D[36]),
        .I4(D[40]),
        .I5(D[32]),
        .O(\data_out[72]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_4 
       (.I0(D[50]),
        .I1(D[54]),
        .I2(D[52]),
        .I3(D[4]),
        .I4(D[6]),
        .I5(D[10]),
        .O(\data_out[72]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_5 
       (.I0(D[48]),
        .I1(D[46]),
        .I2(D[44]),
        .I3(D[42]),
        .I4(D[34]),
        .I5(D[25]),
        .O(\data_out[72]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_6 
       (.I0(D[0]),
        .I1(D[1]),
        .I2(D[3]),
        .I3(D[56]),
        .I4(D[63]),
        .I5(\data_out[72]_i_7_n_0 ),
        .O(\data_out[72]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[72]_i_7 
       (.I0(D[28]),
        .I1(D[59]),
        .I2(D[61]),
        .I3(D[11]),
        .I4(D[26]),
        .I5(D[57]),
        .O(\data_out[72]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[73]_i_1 
       (.I0(\data_out[77]_i_2_n_0 ),
        .I1(\data_out[73]_i_2_n_0 ),
        .I2(\data_out[74]_i_3_n_0 ),
        .I3(\data_out[73]_i_3_n_0 ),
        .I4(\data_out[73]_i_4_n_0 ),
        .I5(\data_out[73]_i_5_n_0 ),
        .O(D[73]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[73]_i_2 
       (.I0(D[31]),
        .I1(D[35]),
        .I2(D[12]),
        .I3(D[27]),
        .I4(D[58]),
        .I5(D[62]),
        .O(\data_out[73]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[73]_i_3 
       (.I0(D[59]),
        .I1(D[0]),
        .I2(D[3]),
        .I3(D[63]),
        .I4(D[5]),
        .I5(D[43]),
        .O(\data_out[73]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[73]_i_4 
       (.I0(D[6]),
        .I1(D[44]),
        .I2(D[36]),
        .I3(D[32]),
        .I4(D[13]),
        .I5(D[28]),
        .O(\data_out[73]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[73]_i_5 
       (.I0(D[2]),
        .I1(\data_out[77]_i_9_n_0 ),
        .I2(\data_out[79]_i_9_n_0 ),
        .I3(\data_out[79]_i_2_n_0 ),
        .I4(\data_out[77]_i_10_n_0 ),
        .I5(\data_out[79]_i_3_n_0 ),
        .O(\data_out[73]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[74]_i_1 
       (.I0(\data_out[77]_i_4_n_0 ),
        .I1(\data_out[74]_i_2_n_0 ),
        .I2(\data_out[74]_i_3_n_0 ),
        .I3(\data_out[74]_i_4_n_0 ),
        .I4(\data_out[74]_i_5_n_0 ),
        .I5(\data_out[74]_i_6_n_0 ),
        .O(D[74]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[74]_i_2 
       (.I0(D[2]),
        .I1(D[45]),
        .I2(D[37]),
        .I3(D[29]),
        .I4(D[7]),
        .I5(D[14]),
        .O(\data_out[74]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \data_out[74]_i_3 
       (.I0(D[25]),
        .I1(D[24]),
        .I2(D[56]),
        .I3(D[55]),
        .O(\data_out[74]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[74]_i_4 
       (.I0(D[61]),
        .I1(D[1]),
        .I2(D[3]),
        .I3(D[63]),
        .I4(D[31]),
        .I5(D[62]),
        .O(\data_out[74]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[74]_i_5 
       (.I0(D[46]),
        .I1(D[32]),
        .I2(D[8]),
        .I3(D[15]),
        .I4(D[38]),
        .I5(D[30]),
        .O(\data_out[74]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[74]_i_6 
       (.I0(D[60]),
        .I1(\data_out[77]_i_9_n_0 ),
        .I2(\data_out[79]_i_2_n_0 ),
        .I3(\data_out[79]_i_4_n_0 ),
        .I4(\data_out[77]_i_10_n_0 ),
        .I5(\data_out[79]_i_3_n_0 ),
        .O(\data_out[74]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[75]_i_1 
       (.I0(\data_out[75]_i_2_n_0 ),
        .I1(\data_out[75]_i_3_n_0 ),
        .O(D[75]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[75]_i_2 
       (.I0(\data_out[79]_i_3_n_0 ),
        .I1(\data_out[77]_i_2_n_0 ),
        .I2(\data_out[77]_i_4_n_0 ),
        .I3(\data_out[74]_i_3_n_0 ),
        .I4(\data_out[75]_i_4_n_0 ),
        .I5(\data_out[75]_i_5_n_0 ),
        .O(\data_out[75]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[75]_i_3 
       (.I0(D[50]),
        .I1(D[4]),
        .I2(D[6]),
        .I3(D[34]),
        .I4(D[36]),
        .I5(D[8]),
        .O(\data_out[75]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[75]_i_4 
       (.I0(D[18]),
        .I1(D[33]),
        .I2(D[49]),
        .I3(\data_out[77]_i_9_n_0 ),
        .I4(\data_out[79]_i_9_n_0 ),
        .I5(\data_out[79]_i_4_n_0 ),
        .O(\data_out[75]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[75]_i_5 
       (.I0(D[19]),
        .I1(D[38]),
        .I2(D[5]),
        .I3(D[35]),
        .I4(D[37]),
        .I5(D[7]),
        .O(\data_out[75]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[76]_i_1 
       (.I0(\data_out[76]_i_2_n_0 ),
        .I1(\data_out[76]_i_3_n_0 ),
        .O(D[76]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[76]_i_2 
       (.I0(\data_out[77]_i_10_n_0 ),
        .I1(\data_out[77]_i_2_n_0 ),
        .I2(\data_out[77]_i_4_n_0 ),
        .I3(\data_out[74]_i_3_n_0 ),
        .I4(\data_out[76]_i_4_n_0 ),
        .I5(\data_out[76]_i_5_n_0 ),
        .O(\data_out[76]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[76]_i_3 
       (.I0(D[50]),
        .I1(D[46]),
        .I2(D[44]),
        .I3(D[42]),
        .I4(D[13]),
        .I5(D[15]),
        .O(\data_out[76]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[76]_i_4 
       (.I0(D[18]),
        .I1(D[49]),
        .I2(D[41]),
        .I3(\data_out[79]_i_9_n_0 ),
        .I4(\data_out[79]_i_2_n_0 ),
        .I5(\data_out[79]_i_4_n_0 ),
        .O(\data_out[76]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[76]_i_5 
       (.I0(D[19]),
        .I1(D[11]),
        .I2(D[43]),
        .I3(D[12]),
        .I4(D[45]),
        .I5(D[14]),
        .O(\data_out[76]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[77]_i_1 
       (.I0(\data_out[77]_i_2_n_0 ),
        .I1(\data_out[77]_i_3_n_0 ),
        .I2(\data_out[77]_i_4_n_0 ),
        .I3(\data_out[77]_i_5_n_0 ),
        .I4(\data_out[77]_i_6_n_0 ),
        .I5(\data_out[77]_i_7_n_0 ),
        .O(D[77]));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[77]_i_10 
       (.I0(D[47]),
        .I1(D[48]),
        .O(\data_out[77]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[77]_i_2 
       (.I0(D[51]),
        .I1(D[52]),
        .O(\data_out[77]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[77]_i_3 
       (.I0(D[31]),
        .I1(D[35]),
        .I2(D[27]),
        .I3(D[45]),
        .I4(D[37]),
        .I5(D[29]),
        .O(\data_out[77]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[77]_i_4 
       (.I0(D[53]),
        .I1(D[54]),
        .O(\data_out[77]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[77]_i_5 
       (.I0(D[32]),
        .I1(D[38]),
        .I2(D[30]),
        .I3(D[28]),
        .I4(D[26]),
        .I5(D[43]),
        .O(\data_out[77]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[77]_i_6 
       (.I0(D[50]),
        .I1(D[46]),
        .I2(D[44]),
        .I3(D[42]),
        .I4(D[34]),
        .I5(D[36]),
        .O(\data_out[77]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[77]_i_7 
       (.I0(D[33]),
        .I1(D[49]),
        .I2(D[41]),
        .I3(\data_out[77]_i_8_n_0 ),
        .I4(\data_out[77]_i_9_n_0 ),
        .I5(\data_out[77]_i_10_n_0 ),
        .O(\data_out[77]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[77]_i_8 
       (.I0(D[55]),
        .I1(D[56]),
        .O(\data_out[77]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[77]_i_9 
       (.I0(D[39]),
        .I1(D[40]),
        .O(\data_out[77]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[78]_i_1 
       (.I0(\data_out[78]_i_2_n_0 ),
        .I1(D[60]),
        .O(D[78]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[78]_i_2 
       (.I0(D[59]),
        .I1(D[61]),
        .I2(D[57]),
        .I3(D[63]),
        .I4(D[58]),
        .I5(D[62]),
        .O(\data_out[78]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[79]_i_1 
       (.I0(\data_out[79]_i_2_n_0 ),
        .I1(\data_out[79]_i_3_n_0 ),
        .I2(\data_out[79]_i_4_n_0 ),
        .I3(\data_out[79]_i_5_n_0 ),
        .I4(\data_out[79]_i_6_n_0 ),
        .I5(\data_out[79]_i_7_n_0 ),
        .O(D[79]));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[79]_i_2 
       (.I0(D[16]),
        .I1(D[17]),
        .O(\data_out[79]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[79]_i_3 
       (.I0(D[9]),
        .I1(D[10]),
        .O(\data_out[79]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[79]_i_4 
       (.I0(D[22]),
        .I1(D[23]),
        .O(\data_out[79]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[79]_i_5 
       (.I0(D[4]),
        .I1(D[6]),
        .I2(D[13]),
        .I3(D[8]),
        .I4(D[15]),
        .I5(D[19]),
        .O(\data_out[79]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[79]_i_6 
       (.I0(D[11]),
        .I1(D[0]),
        .I2(D[1]),
        .I3(D[3]),
        .I4(D[5]),
        .I5(D[12]),
        .O(\data_out[79]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[79]_i_7 
       (.I0(D[2]),
        .I1(D[7]),
        .I2(D[14]),
        .I3(D[18]),
        .I4(\data_out[79]_i_8_n_0 ),
        .I5(\data_out[79]_i_9_n_0 ),
        .O(\data_out[79]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[79]_i_8 
       (.I0(D[24]),
        .I1(D[25]),
        .O(\data_out[79]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[79]_i_9 
       (.I0(D[20]),
        .I1(D[21]),
        .O(\data_out[79]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[80]_i_1 
       (.I0(\data_out[80]_i_2_n_0 ),
        .I1(D[66]),
        .O(D[80]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[80]_i_2 
       (.I0(D[67]),
        .I1(D[68]),
        .I2(D[65]),
        .I3(D[69]),
        .I4(D[71]),
        .I5(D[70]),
        .O(\data_out[80]_i_2_n_0 ));
  FDRE \data_out_reg[0] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[0]),
        .Q(D[0]),
        .R(ecc_reset));
  FDRE \data_out_reg[10] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[10]),
        .Q(D[10]),
        .R(ecc_reset));
  FDRE \data_out_reg[11] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[11]),
        .Q(D[11]),
        .R(ecc_reset));
  FDRE \data_out_reg[12] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[12]),
        .Q(D[12]),
        .R(ecc_reset));
  FDRE \data_out_reg[13] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[13]),
        .Q(D[13]),
        .R(ecc_reset));
  FDRE \data_out_reg[14] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[14]),
        .Q(D[14]),
        .R(ecc_reset));
  FDRE \data_out_reg[15] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[15]),
        .Q(D[15]),
        .R(ecc_reset));
  FDRE \data_out_reg[16] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[16]),
        .Q(D[16]),
        .R(ecc_reset));
  FDRE \data_out_reg[17] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[17]),
        .Q(D[17]),
        .R(ecc_reset));
  FDRE \data_out_reg[18] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[18]),
        .Q(D[18]),
        .R(ecc_reset));
  FDRE \data_out_reg[19] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[19]),
        .Q(D[19]),
        .R(ecc_reset));
  FDRE \data_out_reg[1] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[1]),
        .Q(D[1]),
        .R(ecc_reset));
  FDRE \data_out_reg[20] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[20]),
        .Q(D[20]),
        .R(ecc_reset));
  FDRE \data_out_reg[21] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[21]),
        .Q(D[21]),
        .R(ecc_reset));
  FDRE \data_out_reg[22] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[22]),
        .Q(D[22]),
        .R(ecc_reset));
  FDRE \data_out_reg[23] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[23]),
        .Q(D[23]),
        .R(ecc_reset));
  FDRE \data_out_reg[24] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[24]),
        .Q(D[24]),
        .R(ecc_reset));
  FDRE \data_out_reg[25] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[25]),
        .Q(D[25]),
        .R(ecc_reset));
  FDRE \data_out_reg[26] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[26]),
        .Q(D[26]),
        .R(ecc_reset));
  FDRE \data_out_reg[27] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[27]),
        .Q(D[27]),
        .R(ecc_reset));
  FDRE \data_out_reg[28] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[28]),
        .Q(D[28]),
        .R(ecc_reset));
  FDRE \data_out_reg[29] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[29]),
        .Q(D[29]),
        .R(ecc_reset));
  FDRE \data_out_reg[2] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[2]),
        .Q(D[2]),
        .R(ecc_reset));
  FDRE \data_out_reg[30] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[30]),
        .Q(D[30]),
        .R(ecc_reset));
  FDRE \data_out_reg[31] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[31]),
        .Q(D[31]),
        .R(ecc_reset));
  FDRE \data_out_reg[32] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[32]),
        .Q(D[32]),
        .R(ecc_reset));
  FDRE \data_out_reg[33] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[33]),
        .Q(D[33]),
        .R(ecc_reset));
  FDRE \data_out_reg[34] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[34]),
        .Q(D[34]),
        .R(ecc_reset));
  FDRE \data_out_reg[35] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[35]),
        .Q(D[35]),
        .R(ecc_reset));
  FDRE \data_out_reg[36] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[36]),
        .Q(D[36]),
        .R(ecc_reset));
  FDRE \data_out_reg[37] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[37]),
        .Q(D[37]),
        .R(ecc_reset));
  FDRE \data_out_reg[38] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[38]),
        .Q(D[38]),
        .R(ecc_reset));
  FDRE \data_out_reg[39] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[39]),
        .Q(D[39]),
        .R(ecc_reset));
  FDRE \data_out_reg[3] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[3]),
        .Q(D[3]),
        .R(ecc_reset));
  FDRE \data_out_reg[40] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[40]),
        .Q(D[40]),
        .R(ecc_reset));
  FDRE \data_out_reg[41] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[41]),
        .Q(D[41]),
        .R(ecc_reset));
  FDRE \data_out_reg[42] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[42]),
        .Q(D[42]),
        .R(ecc_reset));
  FDRE \data_out_reg[43] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[43]),
        .Q(D[43]),
        .R(ecc_reset));
  FDRE \data_out_reg[44] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[44]),
        .Q(D[44]),
        .R(ecc_reset));
  FDRE \data_out_reg[45] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[45]),
        .Q(D[45]),
        .R(ecc_reset));
  FDRE \data_out_reg[46] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[46]),
        .Q(D[46]),
        .R(ecc_reset));
  FDRE \data_out_reg[47] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[47]),
        .Q(D[47]),
        .R(ecc_reset));
  FDRE \data_out_reg[48] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[48]),
        .Q(D[48]),
        .R(ecc_reset));
  FDRE \data_out_reg[49] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[49]),
        .Q(D[49]),
        .R(ecc_reset));
  FDRE \data_out_reg[4] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[4]),
        .Q(D[4]),
        .R(ecc_reset));
  FDRE \data_out_reg[50] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[50]),
        .Q(D[50]),
        .R(ecc_reset));
  FDRE \data_out_reg[51] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[51]),
        .Q(D[51]),
        .R(ecc_reset));
  FDRE \data_out_reg[52] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[52]),
        .Q(D[52]),
        .R(ecc_reset));
  FDRE \data_out_reg[53] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[53]),
        .Q(D[53]),
        .R(ecc_reset));
  FDRE \data_out_reg[54] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[54]),
        .Q(D[54]),
        .R(ecc_reset));
  FDRE \data_out_reg[55] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[55]),
        .Q(D[55]),
        .R(ecc_reset));
  FDRE \data_out_reg[56] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[56]),
        .Q(D[56]),
        .R(ecc_reset));
  FDRE \data_out_reg[57] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[57]),
        .Q(D[57]),
        .R(ecc_reset));
  FDRE \data_out_reg[58] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[58]),
        .Q(D[58]),
        .R(ecc_reset));
  FDRE \data_out_reg[59] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[59]),
        .Q(D[59]),
        .R(ecc_reset));
  FDRE \data_out_reg[5] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[5]),
        .Q(D[5]),
        .R(ecc_reset));
  FDRE \data_out_reg[60] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[60]),
        .Q(D[60]),
        .R(ecc_reset));
  FDRE \data_out_reg[61] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[61]),
        .Q(D[61]),
        .R(ecc_reset));
  FDRE \data_out_reg[62] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[62]),
        .Q(D[62]),
        .R(ecc_reset));
  FDRE \data_out_reg[63] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[63]),
        .Q(D[63]),
        .R(ecc_reset));
  FDRE \data_out_reg[64] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[64]),
        .Q(D[64]),
        .R(ecc_reset));
  FDRE \data_out_reg[65] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[65]),
        .Q(D[65]),
        .R(ecc_reset));
  FDRE \data_out_reg[66] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[66]),
        .Q(D[66]),
        .R(ecc_reset));
  FDRE \data_out_reg[67] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[67]),
        .Q(D[67]),
        .R(ecc_reset));
  FDRE \data_out_reg[68] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[68]),
        .Q(D[68]),
        .R(ecc_reset));
  FDRE \data_out_reg[69] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[69]),
        .Q(D[69]),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[6]),
        .Q(D[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[70] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[70]),
        .Q(D[70]),
        .R(ecc_reset));
  FDRE \data_out_reg[71] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[71]),
        .Q(D[71]),
        .R(ecc_reset));
  FDRE \data_out_reg[72] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[72]),
        .Q(D[81]),
        .R(ecc_reset));
  FDRE \data_out_reg[7] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[7]),
        .Q(D[7]),
        .R(ecc_reset));
  FDRE \data_out_reg[8] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[8]),
        .Q(D[8]),
        .R(ecc_reset));
  FDRE \data_out_reg[9] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_correct_n[9]),
        .Q(D[9]),
        .R(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized0
   (D,
    ecc_reset,
    ecc_clken,
    \data_out_reg[72]_0 ,
    ecc_clk);
  output [65:0]D;
  input ecc_reset;
  input ecc_clken;
  input [81:0]\data_out_reg[72]_0 ;
  input ecc_clk;

  wire [65:0]D;
  wire \data_out[17]_i_2_n_0 ;
  wire \data_out[25]_i_2_n_0 ;
  wire \data_out[35]_i_2_n_0 ;
  wire \data_out[36]_i_2_n_0 ;
  wire \data_out[41]_i_2_n_0 ;
  wire \data_out[42]_i_2_n_0 ;
  wire \data_out[42]_i_3_n_0 ;
  wire \data_out[48]_i_2_n_0 ;
  wire \data_out[50]_i_2_n_0 ;
  wire \data_out[50]_i_3_n_0 ;
  wire \data_out[51]_i_2_n_0 ;
  wire \data_out[52]_i_2_n_0 ;
  wire \data_out[52]_i_3_n_0 ;
  wire \data_out[55]_i_2_n_0 ;
  wire \data_out[56]_i_2_n_0 ;
  wire \data_out[56]_i_3_n_0 ;
  wire \data_out[56]_i_4_n_0 ;
  wire \data_out[56]_i_5_n_0 ;
  wire \data_out[58]_i_2_n_0 ;
  wire \data_out[59]_i_2_n_0 ;
  wire \data_out[61]_i_2_n_0 ;
  wire \data_out[62]_i_2_n_0 ;
  wire \data_out[63]_i_2_n_0 ;
  wire \data_out[63]_i_3_n_0 ;
  wire \data_out[65]_i_2_n_0 ;
  wire \data_out[65]_i_4_n_0 ;
  wire \data_out[65]_i_5_n_0 ;
  wire [81:0]\data_out_reg[72]_0 ;
  wire \data_out_reg_n_0_[0] ;
  wire \data_out_reg_n_0_[10] ;
  wire \data_out_reg_n_0_[11] ;
  wire \data_out_reg_n_0_[12] ;
  wire \data_out_reg_n_0_[13] ;
  wire \data_out_reg_n_0_[14] ;
  wire \data_out_reg_n_0_[15] ;
  wire \data_out_reg_n_0_[16] ;
  wire \data_out_reg_n_0_[17] ;
  wire \data_out_reg_n_0_[18] ;
  wire \data_out_reg_n_0_[19] ;
  wire \data_out_reg_n_0_[1] ;
  wire \data_out_reg_n_0_[20] ;
  wire \data_out_reg_n_0_[21] ;
  wire \data_out_reg_n_0_[22] ;
  wire \data_out_reg_n_0_[23] ;
  wire \data_out_reg_n_0_[24] ;
  wire \data_out_reg_n_0_[25] ;
  wire \data_out_reg_n_0_[26] ;
  wire \data_out_reg_n_0_[27] ;
  wire \data_out_reg_n_0_[28] ;
  wire \data_out_reg_n_0_[29] ;
  wire \data_out_reg_n_0_[2] ;
  wire \data_out_reg_n_0_[30] ;
  wire \data_out_reg_n_0_[31] ;
  wire \data_out_reg_n_0_[32] ;
  wire \data_out_reg_n_0_[33] ;
  wire \data_out_reg_n_0_[34] ;
  wire \data_out_reg_n_0_[35] ;
  wire \data_out_reg_n_0_[36] ;
  wire \data_out_reg_n_0_[37] ;
  wire \data_out_reg_n_0_[38] ;
  wire \data_out_reg_n_0_[39] ;
  wire \data_out_reg_n_0_[3] ;
  wire \data_out_reg_n_0_[40] ;
  wire \data_out_reg_n_0_[41] ;
  wire \data_out_reg_n_0_[42] ;
  wire \data_out_reg_n_0_[43] ;
  wire \data_out_reg_n_0_[44] ;
  wire \data_out_reg_n_0_[45] ;
  wire \data_out_reg_n_0_[46] ;
  wire \data_out_reg_n_0_[47] ;
  wire \data_out_reg_n_0_[48] ;
  wire \data_out_reg_n_0_[49] ;
  wire \data_out_reg_n_0_[4] ;
  wire \data_out_reg_n_0_[50] ;
  wire \data_out_reg_n_0_[51] ;
  wire \data_out_reg_n_0_[52] ;
  wire \data_out_reg_n_0_[53] ;
  wire \data_out_reg_n_0_[54] ;
  wire \data_out_reg_n_0_[55] ;
  wire \data_out_reg_n_0_[56] ;
  wire \data_out_reg_n_0_[57] ;
  wire \data_out_reg_n_0_[58] ;
  wire \data_out_reg_n_0_[59] ;
  wire \data_out_reg_n_0_[5] ;
  wire \data_out_reg_n_0_[60] ;
  wire \data_out_reg_n_0_[61] ;
  wire \data_out_reg_n_0_[62] ;
  wire \data_out_reg_n_0_[63] ;
  wire \data_out_reg_n_0_[64] ;
  wire \data_out_reg_n_0_[65] ;
  wire \data_out_reg_n_0_[66] ;
  wire \data_out_reg_n_0_[67] ;
  wire \data_out_reg_n_0_[68] ;
  wire \data_out_reg_n_0_[69] ;
  wire \data_out_reg_n_0_[6] ;
  wire \data_out_reg_n_0_[70] ;
  wire \data_out_reg_n_0_[71] ;
  wire \data_out_reg_n_0_[7] ;
  wire \data_out_reg_n_0_[80] ;
  wire \data_out_reg_n_0_[81] ;
  wire \data_out_reg_n_0_[8] ;
  wire \data_out_reg_n_0_[9] ;
  wire ecc_clk;
  wire ecc_clken;
  wire ecc_reset;
  wire [6:0]p_0_in;
  wire [0:0]syndrome_pipe;
  wire [7:1]syndrome_pipe__0;
  wire xor_bits_0_25_pipe;

  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \data_out[0]_i_1 
       (.I0(\data_out_reg_n_0_[0] ),
        .I1(\data_out[17]_i_2_n_0 ),
        .I2(\data_out[36]_i_2_n_0 ),
        .O(D[0]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[10]_i_1 
       (.I0(\data_out_reg_n_0_[10] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[10]));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \data_out[11]_i_1 
       (.I0(\data_out_reg_n_0_[11] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[42]_i_3_n_0 ),
        .I3(\data_out[17]_i_2_n_0 ),
        .O(D[11]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \data_out[12]_i_1 
       (.I0(\data_out_reg_n_0_[12] ),
        .I1(\data_out[17]_i_2_n_0 ),
        .I2(\data_out[51]_i_2_n_0 ),
        .O(D[12]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \data_out[13]_i_1 
       (.I0(\data_out_reg_n_0_[13] ),
        .I1(\data_out[17]_i_2_n_0 ),
        .I2(\data_out[52]_i_2_n_0 ),
        .O(D[13]));
  LUT5 #(
    .INIT(32'hAAA6AAAA)) 
    \data_out[14]_i_1 
       (.I0(\data_out_reg_n_0_[14] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[14]));
  LUT5 #(
    .INIT(32'hAAA6AAAA)) 
    \data_out[15]_i_1 
       (.I0(\data_out_reg_n_0_[15] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[15]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[16]_i_1 
       (.I0(\data_out_reg_n_0_[16] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[16]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[17]_i_1 
       (.I0(\data_out_reg_n_0_[17] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[17]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h060F0F06)) 
    \data_out[17]_i_2 
       (.I0(syndrome_pipe__0[4]),
        .I1(\data_out_reg_n_0_[68] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[6]),
        .I4(\data_out_reg_n_0_[70] ),
        .O(\data_out[17]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[18]_i_1 
       (.I0(\data_out_reg_n_0_[18] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(\data_out[41]_i_2_n_0 ),
        .O(D[18]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[19]_i_1 
       (.I0(\data_out_reg_n_0_[19] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(\data_out[42]_i_3_n_0 ),
        .O(D[19]));
  LUT5 #(
    .INIT(32'hAAA6AAAA)) 
    \data_out[1]_i_1 
       (.I0(\data_out_reg_n_0_[1] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[20]_i_1 
       (.I0(\data_out_reg_n_0_[20] ),
        .I1(\data_out[25]_i_2_n_0 ),
        .I2(\data_out[51]_i_2_n_0 ),
        .O(D[20]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[21]_i_1 
       (.I0(\data_out_reg_n_0_[21] ),
        .I1(\data_out[25]_i_2_n_0 ),
        .I2(\data_out[52]_i_2_n_0 ),
        .O(D[21]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[22]_i_1 
       (.I0(\data_out_reg_n_0_[22] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[25]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[22]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[23]_i_1 
       (.I0(\data_out_reg_n_0_[23] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[25]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[23]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[24]_i_1 
       (.I0(\data_out_reg_n_0_[24] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[24]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[25]_i_1 
       (.I0(\data_out_reg_n_0_[25] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[25]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h06000006)) 
    \data_out[25]_i_2 
       (.I0(syndrome_pipe__0[4]),
        .I1(\data_out_reg_n_0_[68] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[6]),
        .I4(\data_out_reg_n_0_[70] ),
        .O(\data_out[25]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[26]_i_1 
       (.I0(\data_out_reg_n_0_[26] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(\data_out[59]_i_2_n_0 ),
        .O(D[26]));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \data_out[27]_i_1 
       (.I0(\data_out_reg_n_0_[27] ),
        .I1(\data_out[35]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(\data_out[58]_i_2_n_0 ),
        .O(D[27]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[28]_i_1 
       (.I0(\data_out_reg_n_0_[28] ),
        .I1(\data_out[48]_i_2_n_0 ),
        .I2(\data_out[36]_i_2_n_0 ),
        .O(D[28]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[29]_i_1 
       (.I0(\data_out_reg_n_0_[29] ),
        .I1(\data_out[56]_i_4_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[62]_i_2_n_0 ),
        .I4(\data_out[48]_i_2_n_0 ),
        .O(D[29]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[2]_i_1 
       (.I0(\data_out_reg_n_0_[2] ),
        .I1(\data_out[62]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[2]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[30]_i_1 
       (.I0(\data_out_reg_n_0_[30] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[48]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[30]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[31]_i_1 
       (.I0(\data_out_reg_n_0_[31] ),
        .I1(\data_out[62]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[31]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[32]_i_1 
       (.I0(\data_out_reg_n_0_[32] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[32]));
  LUT6 #(
    .INIT(64'hAAAA5665AAAAAAAA)) 
    \data_out[33]_i_1 
       (.I0(\data_out_reg_n_0_[33] ),
        .I1(\data_out_reg_n_0_[81] ),
        .I2(syndrome_pipe__0[1]),
        .I3(\data_out_reg_n_0_[65] ),
        .I4(p_0_in[4]),
        .I5(\data_out[50]_i_2_n_0 ),
        .O(D[33]));
  LUT6 #(
    .INIT(64'hAAAAA99AAAAAAAAA)) 
    \data_out[34]_i_1 
       (.I0(\data_out_reg_n_0_[34] ),
        .I1(\data_out_reg_n_0_[81] ),
        .I2(syndrome_pipe__0[1]),
        .I3(\data_out_reg_n_0_[65] ),
        .I4(p_0_in[4]),
        .I5(\data_out[50]_i_2_n_0 ),
        .O(D[34]));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \data_out[35]_i_1 
       (.I0(\data_out_reg_n_0_[35] ),
        .I1(\data_out[35]_i_2_n_0 ),
        .I2(\data_out[56]_i_3_n_0 ),
        .I3(\data_out[58]_i_2_n_0 ),
        .O(D[35]));
  LUT6 #(
    .INIT(64'h0000000020000020)) 
    \data_out[35]_i_2 
       (.I0(p_0_in[1]),
        .I1(p_0_in[2]),
        .I2(\data_out[56]_i_5_n_0 ),
        .I3(\data_out_reg_n_0_[71] ),
        .I4(syndrome_pipe__0[7]),
        .I5(\data_out_reg_n_0_[81] ),
        .O(\data_out[35]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[36]_i_1 
       (.I0(\data_out_reg_n_0_[36] ),
        .I1(\data_out[56]_i_3_n_0 ),
        .I2(\data_out[36]_i_2_n_0 ),
        .O(D[36]));
  LUT6 #(
    .INIT(64'h4100000000000000)) 
    \data_out[36]_i_2 
       (.I0(\data_out_reg_n_0_[81] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[71] ),
        .I3(\data_out[59]_i_2_n_0 ),
        .I4(\data_out[56]_i_5_n_0 ),
        .I5(\data_out[52]_i_3_n_0 ),
        .O(\data_out[36]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[37]_i_1 
       (.I0(\data_out_reg_n_0_[37] ),
        .I1(\data_out[56]_i_4_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[62]_i_2_n_0 ),
        .I4(\data_out[56]_i_3_n_0 ),
        .O(D[37]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[38]_i_1 
       (.I0(\data_out_reg_n_0_[38] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[56]_i_3_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[38]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[39]_i_1 
       (.I0(\data_out_reg_n_0_[39] ),
        .I1(\data_out[62]_i_2_n_0 ),
        .I2(\data_out[56]_i_3_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[39]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[3]_i_1 
       (.I0(\data_out_reg_n_0_[3] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[17]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[3]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[40]_i_1 
       (.I0(\data_out_reg_n_0_[40] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[56]_i_3_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[40]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[41]_i_1 
       (.I0(\data_out_reg_n_0_[41] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(\data_out[41]_i_2_n_0 ),
        .O(D[41]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h06000006)) 
    \data_out[41]_i_2 
       (.I0(syndrome_pipe__0[5]),
        .I1(\data_out_reg_n_0_[69] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[1]),
        .I4(\data_out_reg_n_0_[65] ),
        .O(\data_out[41]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[42]_i_1 
       (.I0(\data_out_reg_n_0_[42] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(\data_out[42]_i_3_n_0 ),
        .O(D[42]));
  LUT6 #(
    .INIT(64'h0000000010000010)) 
    \data_out[42]_i_2 
       (.I0(p_0_in[1]),
        .I1(p_0_in[2]),
        .I2(\data_out[56]_i_5_n_0 ),
        .I3(\data_out_reg_n_0_[71] ),
        .I4(syndrome_pipe__0[7]),
        .I5(\data_out_reg_n_0_[81] ),
        .O(\data_out[42]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h00060600)) 
    \data_out[42]_i_3 
       (.I0(syndrome_pipe__0[1]),
        .I1(\data_out_reg_n_0_[65] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[5]),
        .I4(\data_out_reg_n_0_[69] ),
        .O(\data_out[42]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[43]_i_1 
       (.I0(\data_out_reg_n_0_[43] ),
        .I1(\data_out[48]_i_2_n_0 ),
        .I2(\data_out[51]_i_2_n_0 ),
        .O(D[43]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[44]_i_1 
       (.I0(\data_out_reg_n_0_[44] ),
        .I1(\data_out[48]_i_2_n_0 ),
        .I2(\data_out[52]_i_2_n_0 ),
        .O(D[44]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[45]_i_1 
       (.I0(\data_out_reg_n_0_[45] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[48]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[45]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[46]_i_1 
       (.I0(\data_out_reg_n_0_[46] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[48]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[46]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[47]_i_1 
       (.I0(\data_out_reg_n_0_[47] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[47]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[48]_i_1 
       (.I0(\data_out_reg_n_0_[48] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(\data_out[48]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[48]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h06000006)) 
    \data_out[48]_i_2 
       (.I0(syndrome_pipe__0[6]),
        .I1(\data_out_reg_n_0_[70] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[4]),
        .I4(\data_out_reg_n_0_[68] ),
        .O(\data_out[48]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h666A6A66AAAAAAAA)) 
    \data_out[49]_i_1 
       (.I0(\data_out_reg_n_0_[49] ),
        .I1(p_0_in[4]),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[1]),
        .I4(\data_out_reg_n_0_[65] ),
        .I5(\data_out[50]_i_2_n_0 ),
        .O(D[49]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \data_out[4]_i_1 
       (.I0(\data_out_reg_n_0_[4] ),
        .I1(\data_out[42]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(\data_out[59]_i_2_n_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hA99AAAAAAAAAAAAA)) 
    \data_out[50]_i_1 
       (.I0(\data_out_reg_n_0_[50] ),
        .I1(\data_out_reg_n_0_[81] ),
        .I2(syndrome_pipe__0[1]),
        .I3(\data_out_reg_n_0_[65] ),
        .I4(p_0_in[4]),
        .I5(\data_out[50]_i_2_n_0 ),
        .O(D[50]));
  LUT5 #(
    .INIT(32'h00000040)) 
    \data_out[50]_i_2 
       (.I0(\data_out[50]_i_3_n_0 ),
        .I1(\data_out[56]_i_3_n_0 ),
        .I2(\data_out[56]_i_5_n_0 ),
        .I3(p_0_in[1]),
        .I4(p_0_in[2]),
        .O(\data_out[50]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hBE)) 
    \data_out[50]_i_3 
       (.I0(\data_out_reg_n_0_[81] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[71] ),
        .O(\data_out[50]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[51]_i_1 
       (.I0(\data_out_reg_n_0_[51] ),
        .I1(\data_out[56]_i_3_n_0 ),
        .I2(\data_out[51]_i_2_n_0 ),
        .O(D[51]));
  LUT6 #(
    .INIT(64'h4100000000000000)) 
    \data_out[51]_i_2 
       (.I0(\data_out_reg_n_0_[81] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[71] ),
        .I3(\data_out[41]_i_2_n_0 ),
        .I4(\data_out[56]_i_5_n_0 ),
        .I5(\data_out[52]_i_3_n_0 ),
        .O(\data_out[51]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[52]_i_1 
       (.I0(\data_out_reg_n_0_[52] ),
        .I1(\data_out[56]_i_3_n_0 ),
        .I2(\data_out[52]_i_2_n_0 ),
        .O(D[52]));
  LUT6 #(
    .INIT(64'h4100000000000000)) 
    \data_out[52]_i_2 
       (.I0(\data_out_reg_n_0_[81] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[71] ),
        .I3(\data_out[42]_i_3_n_0 ),
        .I4(\data_out[56]_i_5_n_0 ),
        .I5(\data_out[52]_i_3_n_0 ),
        .O(\data_out[52]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h06000006)) 
    \data_out[52]_i_3 
       (.I0(syndrome_pipe__0[2]),
        .I1(\data_out_reg_n_0_[66] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[3]),
        .I4(\data_out_reg_n_0_[67] ),
        .O(\data_out[52]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[53]_i_1 
       (.I0(\data_out_reg_n_0_[53] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[56]_i_3_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[53]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[54]_i_1 
       (.I0(\data_out_reg_n_0_[54] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[56]_i_3_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[54]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[55]_i_1 
       (.I0(\data_out_reg_n_0_[55] ),
        .I1(\data_out[55]_i_2_n_0 ),
        .I2(\data_out[56]_i_3_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[55]));
  LUT6 #(
    .INIT(64'h0000009000900000)) 
    \data_out[55]_i_2 
       (.I0(\data_out_reg_n_0_[65] ),
        .I1(syndrome_pipe__0[1]),
        .I2(p_0_in[2]),
        .I3(\data_out_reg_n_0_[81] ),
        .I4(syndrome_pipe__0[5]),
        .I5(\data_out_reg_n_0_[69] ),
        .O(\data_out[55]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[56]_i_1 
       (.I0(\data_out_reg_n_0_[56] ),
        .I1(\data_out[56]_i_2_n_0 ),
        .I2(\data_out[56]_i_3_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[56]));
  LUT6 #(
    .INIT(64'h0006060000000000)) 
    \data_out[56]_i_2 
       (.I0(\data_out_reg_n_0_[69] ),
        .I1(syndrome_pipe__0[5]),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(\data_out_reg_n_0_[65] ),
        .I4(syndrome_pipe__0[1]),
        .I5(p_0_in[2]),
        .O(\data_out[56]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00060600)) 
    \data_out[56]_i_3 
       (.I0(syndrome_pipe__0[4]),
        .I1(\data_out_reg_n_0_[68] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[6]),
        .I4(\data_out_reg_n_0_[70] ),
        .O(\data_out[56]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0082)) 
    \data_out[56]_i_4 
       (.I0(\data_out[56]_i_5_n_0 ),
        .I1(\data_out_reg_n_0_[71] ),
        .I2(syndrome_pipe__0[7]),
        .I3(\data_out_reg_n_0_[81] ),
        .O(\data_out[56]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \data_out[56]_i_5 
       (.I0(\data_out_reg_n_0_[64] ),
        .I1(xor_bits_0_25_pipe),
        .I2(syndrome_pipe__0[7]),
        .I3(\data_out_reg_n_0_[80] ),
        .I4(syndrome_pipe__0[6]),
        .O(\data_out[56]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hAAA6AAAA)) 
    \data_out[57]_i_1 
       (.I0(\data_out_reg_n_0_[57] ),
        .I1(\data_out[61]_i_2_n_0 ),
        .I2(p_0_in[2]),
        .I3(p_0_in[1]),
        .I4(\data_out[59]_i_2_n_0 ),
        .O(D[57]));
  LUT6 #(
    .INIT(64'hA6A6A6AAA6AAA6A6)) 
    \data_out[58]_i_1 
       (.I0(\data_out_reg_n_0_[58] ),
        .I1(\data_out[63]_i_3_n_0 ),
        .I2(\data_out[58]_i_2_n_0 ),
        .I3(\data_out_reg_n_0_[81] ),
        .I4(syndrome_pipe__0[3]),
        .I5(\data_out_reg_n_0_[67] ),
        .O(D[58]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h060F0F06)) 
    \data_out[58]_i_2 
       (.I0(syndrome_pipe__0[1]),
        .I1(\data_out_reg_n_0_[65] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[5]),
        .I4(\data_out_reg_n_0_[69] ),
        .O(\data_out[58]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6A6A6AAA6AAA6A6A)) 
    \data_out[59]_i_1 
       (.I0(\data_out_reg_n_0_[59] ),
        .I1(\data_out[63]_i_3_n_0 ),
        .I2(\data_out[59]_i_2_n_0 ),
        .I3(\data_out_reg_n_0_[81] ),
        .I4(syndrome_pipe__0[3]),
        .I5(\data_out_reg_n_0_[67] ),
        .O(D[59]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h06000006)) 
    \data_out[59]_i_2 
       (.I0(syndrome_pipe__0[1]),
        .I1(\data_out_reg_n_0_[65] ),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(syndrome_pipe__0[5]),
        .I4(\data_out_reg_n_0_[69] ),
        .O(\data_out[59]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \data_out[5]_i_1 
       (.I0(\data_out_reg_n_0_[5] ),
        .I1(\data_out[35]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(\data_out[58]_i_2_n_0 ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAA6AAAA)) 
    \data_out[60]_i_1 
       (.I0(\data_out_reg_n_0_[60] ),
        .I1(\data_out[61]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(p_0_in[4]),
        .I4(p_0_in[2]),
        .I5(p_0_in[0]),
        .O(D[60]));
  LUT6 #(
    .INIT(64'hAAAAAAAAA6AAAAAA)) 
    \data_out[61]_i_1 
       (.I0(\data_out_reg_n_0_[61] ),
        .I1(\data_out[61]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[0]),
        .I5(p_0_in[4]),
        .O(D[61]));
  LUT6 #(
    .INIT(64'h0000000000141400)) 
    \data_out[61]_i_2 
       (.I0(\data_out_reg_n_0_[81] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[71] ),
        .I3(\data_out_reg_n_0_[64] ),
        .I4(syndrome_pipe),
        .I5(\data_out[17]_i_2_n_0 ),
        .O(\data_out[61]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h06)) 
    \data_out[61]_i_3 
       (.I0(\data_out_reg_n_0_[66] ),
        .I1(syndrome_pipe__0[2]),
        .I2(\data_out_reg_n_0_[81] ),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \data_out[61]_i_4 
       (.I0(\data_out_reg_n_0_[67] ),
        .I1(syndrome_pipe__0[3]),
        .I2(\data_out_reg_n_0_[81] ),
        .O(p_0_in[2]));
  LUT3 #(
    .INIT(8'h06)) 
    \data_out[61]_i_5 
       (.I0(\data_out_reg_n_0_[65] ),
        .I1(syndrome_pipe__0[1]),
        .I2(\data_out_reg_n_0_[81] ),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \data_out[61]_i_6 
       (.I0(\data_out_reg_n_0_[69] ),
        .I1(syndrome_pipe__0[5]),
        .I2(\data_out_reg_n_0_[81] ),
        .O(p_0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[62]_i_1 
       (.I0(\data_out_reg_n_0_[62] ),
        .I1(\data_out[62]_i_2_n_0 ),
        .I2(\data_out[63]_i_3_n_0 ),
        .O(D[62]));
  LUT6 #(
    .INIT(64'hF090F000F000F090)) 
    \data_out[62]_i_2 
       (.I0(\data_out_reg_n_0_[65] ),
        .I1(syndrome_pipe__0[1]),
        .I2(p_0_in[2]),
        .I3(\data_out_reg_n_0_[81] ),
        .I4(syndrome_pipe__0[5]),
        .I5(\data_out_reg_n_0_[69] ),
        .O(\data_out[62]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[63]_i_1 
       (.I0(\data_out_reg_n_0_[63] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(\data_out[63]_i_3_n_0 ),
        .O(D[63]));
  LUT6 #(
    .INIT(64'h0009090000000000)) 
    \data_out[63]_i_2 
       (.I0(\data_out_reg_n_0_[69] ),
        .I1(syndrome_pipe__0[5]),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(\data_out_reg_n_0_[65] ),
        .I4(syndrome_pipe__0[1]),
        .I5(p_0_in[2]),
        .O(\data_out[63]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000044000000000)) 
    \data_out[63]_i_3 
       (.I0(\data_out[17]_i_2_n_0 ),
        .I1(p_0_in[1]),
        .I2(\data_out_reg_n_0_[64] ),
        .I3(syndrome_pipe),
        .I4(\data_out_reg_n_0_[81] ),
        .I5(p_0_in[6]),
        .O(\data_out[63]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000006)) 
    \data_out[64]_i_1 
       (.I0(\data_out_reg_n_0_[64] ),
        .I1(syndrome_pipe),
        .I2(\data_out_reg_n_0_[81] ),
        .I3(\data_out[17]_i_2_n_0 ),
        .I4(p_0_in[4]),
        .I5(\data_out[56]_i_4_n_0 ),
        .O(D[64]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \data_out[64]_i_2 
       (.I0(syndrome_pipe__0[6]),
        .I1(\data_out_reg_n_0_[80] ),
        .I2(syndrome_pipe__0[7]),
        .I3(xor_bits_0_25_pipe),
        .O(syndrome_pipe));
  LUT6 #(
    .INIT(64'h0000FE00FEFEFEFE)) 
    \data_out[65]_i_1 
       (.I0(\data_out[65]_i_2_n_0 ),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(p_0_in[6]),
        .I4(\data_out[65]_i_4_n_0 ),
        .I5(\data_out[65]_i_5_n_0 ),
        .O(D[65]));
  LUT6 #(
    .INIT(64'hFFFFEEEFFFFFEEFE)) 
    \data_out[65]_i_2 
       (.I0(\data_out[58]_i_2_n_0 ),
        .I1(\data_out[17]_i_2_n_0 ),
        .I2(\data_out_reg_n_0_[64] ),
        .I3(\data_out_reg_n_0_[81] ),
        .I4(p_0_in[6]),
        .I5(syndrome_pipe),
        .O(\data_out[65]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \data_out[65]_i_3 
       (.I0(\data_out_reg_n_0_[71] ),
        .I1(syndrome_pipe__0[7]),
        .I2(\data_out_reg_n_0_[81] ),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h5445)) 
    \data_out[65]_i_4 
       (.I0(\data_out[17]_i_2_n_0 ),
        .I1(\data_out_reg_n_0_[81] ),
        .I2(syndrome_pipe__0[5]),
        .I3(\data_out_reg_n_0_[69] ),
        .O(\data_out[65]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000096696996)) 
    \data_out[65]_i_5 
       (.I0(\data_out_reg_n_0_[64] ),
        .I1(syndrome_pipe__0[6]),
        .I2(\data_out_reg_n_0_[80] ),
        .I3(syndrome_pipe__0[7]),
        .I4(xor_bits_0_25_pipe),
        .I5(\data_out_reg_n_0_[81] ),
        .O(\data_out[65]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \data_out[6]_i_1 
       (.I0(\data_out_reg_n_0_[6] ),
        .I1(\data_out[25]_i_2_n_0 ),
        .I2(\data_out[36]_i_2_n_0 ),
        .O(D[6]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[7]_i_1 
       (.I0(\data_out_reg_n_0_[7] ),
        .I1(\data_out[56]_i_4_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[62]_i_2_n_0 ),
        .I4(\data_out[25]_i_2_n_0 ),
        .O(D[7]));
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \data_out[8]_i_1 
       (.I0(\data_out_reg_n_0_[8] ),
        .I1(\data_out[63]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\data_out[25]_i_2_n_0 ),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[8]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \data_out[9]_i_1 
       (.I0(\data_out_reg_n_0_[9] ),
        .I1(\data_out[62]_i_2_n_0 ),
        .I2(\data_out[25]_i_2_n_0 ),
        .I3(p_0_in[1]),
        .I4(\data_out[56]_i_4_n_0 ),
        .O(D[9]));
  FDRE \data_out_reg[0] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [0]),
        .Q(\data_out_reg_n_0_[0] ),
        .R(ecc_reset));
  FDRE \data_out_reg[10] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [10]),
        .Q(\data_out_reg_n_0_[10] ),
        .R(ecc_reset));
  FDRE \data_out_reg[11] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [11]),
        .Q(\data_out_reg_n_0_[11] ),
        .R(ecc_reset));
  FDRE \data_out_reg[12] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [12]),
        .Q(\data_out_reg_n_0_[12] ),
        .R(ecc_reset));
  FDRE \data_out_reg[13] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [13]),
        .Q(\data_out_reg_n_0_[13] ),
        .R(ecc_reset));
  FDRE \data_out_reg[14] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [14]),
        .Q(\data_out_reg_n_0_[14] ),
        .R(ecc_reset));
  FDRE \data_out_reg[15] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [15]),
        .Q(\data_out_reg_n_0_[15] ),
        .R(ecc_reset));
  FDRE \data_out_reg[16] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [16]),
        .Q(\data_out_reg_n_0_[16] ),
        .R(ecc_reset));
  FDRE \data_out_reg[17] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [17]),
        .Q(\data_out_reg_n_0_[17] ),
        .R(ecc_reset));
  FDRE \data_out_reg[18] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [18]),
        .Q(\data_out_reg_n_0_[18] ),
        .R(ecc_reset));
  FDRE \data_out_reg[19] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [19]),
        .Q(\data_out_reg_n_0_[19] ),
        .R(ecc_reset));
  FDRE \data_out_reg[1] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [1]),
        .Q(\data_out_reg_n_0_[1] ),
        .R(ecc_reset));
  FDRE \data_out_reg[20] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [20]),
        .Q(\data_out_reg_n_0_[20] ),
        .R(ecc_reset));
  FDRE \data_out_reg[21] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [21]),
        .Q(\data_out_reg_n_0_[21] ),
        .R(ecc_reset));
  FDRE \data_out_reg[22] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [22]),
        .Q(\data_out_reg_n_0_[22] ),
        .R(ecc_reset));
  FDRE \data_out_reg[23] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [23]),
        .Q(\data_out_reg_n_0_[23] ),
        .R(ecc_reset));
  FDRE \data_out_reg[24] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [24]),
        .Q(\data_out_reg_n_0_[24] ),
        .R(ecc_reset));
  FDRE \data_out_reg[25] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [25]),
        .Q(\data_out_reg_n_0_[25] ),
        .R(ecc_reset));
  FDRE \data_out_reg[26] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [26]),
        .Q(\data_out_reg_n_0_[26] ),
        .R(ecc_reset));
  FDRE \data_out_reg[27] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [27]),
        .Q(\data_out_reg_n_0_[27] ),
        .R(ecc_reset));
  FDRE \data_out_reg[28] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [28]),
        .Q(\data_out_reg_n_0_[28] ),
        .R(ecc_reset));
  FDRE \data_out_reg[29] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [29]),
        .Q(\data_out_reg_n_0_[29] ),
        .R(ecc_reset));
  FDRE \data_out_reg[2] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [2]),
        .Q(\data_out_reg_n_0_[2] ),
        .R(ecc_reset));
  FDRE \data_out_reg[30] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [30]),
        .Q(\data_out_reg_n_0_[30] ),
        .R(ecc_reset));
  FDRE \data_out_reg[31] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [31]),
        .Q(\data_out_reg_n_0_[31] ),
        .R(ecc_reset));
  FDRE \data_out_reg[32] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [32]),
        .Q(\data_out_reg_n_0_[32] ),
        .R(ecc_reset));
  FDRE \data_out_reg[33] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [33]),
        .Q(\data_out_reg_n_0_[33] ),
        .R(ecc_reset));
  FDRE \data_out_reg[34] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [34]),
        .Q(\data_out_reg_n_0_[34] ),
        .R(ecc_reset));
  FDRE \data_out_reg[35] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [35]),
        .Q(\data_out_reg_n_0_[35] ),
        .R(ecc_reset));
  FDRE \data_out_reg[36] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [36]),
        .Q(\data_out_reg_n_0_[36] ),
        .R(ecc_reset));
  FDRE \data_out_reg[37] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [37]),
        .Q(\data_out_reg_n_0_[37] ),
        .R(ecc_reset));
  FDRE \data_out_reg[38] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [38]),
        .Q(\data_out_reg_n_0_[38] ),
        .R(ecc_reset));
  FDRE \data_out_reg[39] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [39]),
        .Q(\data_out_reg_n_0_[39] ),
        .R(ecc_reset));
  FDRE \data_out_reg[3] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [3]),
        .Q(\data_out_reg_n_0_[3] ),
        .R(ecc_reset));
  FDRE \data_out_reg[40] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [40]),
        .Q(\data_out_reg_n_0_[40] ),
        .R(ecc_reset));
  FDRE \data_out_reg[41] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [41]),
        .Q(\data_out_reg_n_0_[41] ),
        .R(ecc_reset));
  FDRE \data_out_reg[42] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [42]),
        .Q(\data_out_reg_n_0_[42] ),
        .R(ecc_reset));
  FDRE \data_out_reg[43] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [43]),
        .Q(\data_out_reg_n_0_[43] ),
        .R(ecc_reset));
  FDRE \data_out_reg[44] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [44]),
        .Q(\data_out_reg_n_0_[44] ),
        .R(ecc_reset));
  FDRE \data_out_reg[45] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [45]),
        .Q(\data_out_reg_n_0_[45] ),
        .R(ecc_reset));
  FDRE \data_out_reg[46] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [46]),
        .Q(\data_out_reg_n_0_[46] ),
        .R(ecc_reset));
  FDRE \data_out_reg[47] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [47]),
        .Q(\data_out_reg_n_0_[47] ),
        .R(ecc_reset));
  FDRE \data_out_reg[48] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [48]),
        .Q(\data_out_reg_n_0_[48] ),
        .R(ecc_reset));
  FDRE \data_out_reg[49] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [49]),
        .Q(\data_out_reg_n_0_[49] ),
        .R(ecc_reset));
  FDRE \data_out_reg[4] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [4]),
        .Q(\data_out_reg_n_0_[4] ),
        .R(ecc_reset));
  FDRE \data_out_reg[50] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [50]),
        .Q(\data_out_reg_n_0_[50] ),
        .R(ecc_reset));
  FDRE \data_out_reg[51] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [51]),
        .Q(\data_out_reg_n_0_[51] ),
        .R(ecc_reset));
  FDRE \data_out_reg[52] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [52]),
        .Q(\data_out_reg_n_0_[52] ),
        .R(ecc_reset));
  FDRE \data_out_reg[53] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [53]),
        .Q(\data_out_reg_n_0_[53] ),
        .R(ecc_reset));
  FDRE \data_out_reg[54] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [54]),
        .Q(\data_out_reg_n_0_[54] ),
        .R(ecc_reset));
  FDRE \data_out_reg[55] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [55]),
        .Q(\data_out_reg_n_0_[55] ),
        .R(ecc_reset));
  FDRE \data_out_reg[56] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [56]),
        .Q(\data_out_reg_n_0_[56] ),
        .R(ecc_reset));
  FDRE \data_out_reg[57] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [57]),
        .Q(\data_out_reg_n_0_[57] ),
        .R(ecc_reset));
  FDRE \data_out_reg[58] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [58]),
        .Q(\data_out_reg_n_0_[58] ),
        .R(ecc_reset));
  FDRE \data_out_reg[59] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [59]),
        .Q(\data_out_reg_n_0_[59] ),
        .R(ecc_reset));
  FDRE \data_out_reg[5] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [5]),
        .Q(\data_out_reg_n_0_[5] ),
        .R(ecc_reset));
  FDRE \data_out_reg[60] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [60]),
        .Q(\data_out_reg_n_0_[60] ),
        .R(ecc_reset));
  FDRE \data_out_reg[61] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [61]),
        .Q(\data_out_reg_n_0_[61] ),
        .R(ecc_reset));
  FDRE \data_out_reg[62] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [62]),
        .Q(\data_out_reg_n_0_[62] ),
        .R(ecc_reset));
  FDRE \data_out_reg[63] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [63]),
        .Q(\data_out_reg_n_0_[63] ),
        .R(ecc_reset));
  FDRE \data_out_reg[64] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [64]),
        .Q(\data_out_reg_n_0_[64] ),
        .R(ecc_reset));
  FDRE \data_out_reg[65] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [65]),
        .Q(\data_out_reg_n_0_[65] ),
        .R(ecc_reset));
  FDRE \data_out_reg[66] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [66]),
        .Q(\data_out_reg_n_0_[66] ),
        .R(ecc_reset));
  FDRE \data_out_reg[67] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [67]),
        .Q(\data_out_reg_n_0_[67] ),
        .R(ecc_reset));
  FDRE \data_out_reg[68] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [68]),
        .Q(\data_out_reg_n_0_[68] ),
        .R(ecc_reset));
  FDRE \data_out_reg[69] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [69]),
        .Q(\data_out_reg_n_0_[69] ),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [6]),
        .Q(\data_out_reg_n_0_[6] ),
        .R(ecc_reset));
  FDRE \data_out_reg[70] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [70]),
        .Q(\data_out_reg_n_0_[70] ),
        .R(ecc_reset));
  FDRE \data_out_reg[71] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [71]),
        .Q(\data_out_reg_n_0_[71] ),
        .R(ecc_reset));
  FDRE \data_out_reg[72] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [72]),
        .Q(syndrome_pipe__0[1]),
        .R(ecc_reset));
  FDRE \data_out_reg[73] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [73]),
        .Q(syndrome_pipe__0[2]),
        .R(ecc_reset));
  FDRE \data_out_reg[74] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [74]),
        .Q(syndrome_pipe__0[3]),
        .R(ecc_reset));
  FDRE \data_out_reg[75] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [75]),
        .Q(syndrome_pipe__0[4]),
        .R(ecc_reset));
  FDRE \data_out_reg[76] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [76]),
        .Q(syndrome_pipe__0[5]),
        .R(ecc_reset));
  FDRE \data_out_reg[77] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [77]),
        .Q(syndrome_pipe__0[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[78] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [78]),
        .Q(syndrome_pipe__0[7]),
        .R(ecc_reset));
  FDRE \data_out_reg[79] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [79]),
        .Q(xor_bits_0_25_pipe),
        .R(ecc_reset));
  FDRE \data_out_reg[7] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [7]),
        .Q(\data_out_reg_n_0_[7] ),
        .R(ecc_reset));
  FDRE \data_out_reg[80] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [80]),
        .Q(\data_out_reg_n_0_[80] ),
        .R(ecc_reset));
  FDRE \data_out_reg[81] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [81]),
        .Q(\data_out_reg_n_0_[81] ),
        .R(ecc_reset));
  FDRE \data_out_reg[8] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [8]),
        .Q(\data_out_reg_n_0_[8] ),
        .R(ecc_reset));
  FDRE \data_out_reg[9] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(\data_out_reg[72]_0 [9]),
        .Q(\data_out_reg_n_0_[9] ),
        .R(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_dec_64x8_ecc_v2_0_reg_stage__parameterized1
   (Q,
    ecc_reset,
    ecc_clken,
    D,
    ecc_clk);
  output [65:0]Q;
  input ecc_reset;
  input ecc_clken;
  input [65:0]D;
  input ecc_clk;

  wire [65:0]D;
  wire [65:0]Q;
  wire ecc_clk;
  wire ecc_clken;
  wire ecc_reset;

  FDRE \data_out_reg[0] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[0]),
        .Q(Q[0]),
        .R(ecc_reset));
  FDRE \data_out_reg[10] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[10]),
        .Q(Q[10]),
        .R(ecc_reset));
  FDRE \data_out_reg[11] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[11]),
        .Q(Q[11]),
        .R(ecc_reset));
  FDRE \data_out_reg[12] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[12]),
        .Q(Q[12]),
        .R(ecc_reset));
  FDRE \data_out_reg[13] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[13]),
        .Q(Q[13]),
        .R(ecc_reset));
  FDRE \data_out_reg[14] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[14]),
        .Q(Q[14]),
        .R(ecc_reset));
  FDRE \data_out_reg[15] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[15]),
        .Q(Q[15]),
        .R(ecc_reset));
  FDRE \data_out_reg[16] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[16]),
        .Q(Q[16]),
        .R(ecc_reset));
  FDRE \data_out_reg[17] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[17]),
        .Q(Q[17]),
        .R(ecc_reset));
  FDRE \data_out_reg[18] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[18]),
        .Q(Q[18]),
        .R(ecc_reset));
  FDRE \data_out_reg[19] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[19]),
        .Q(Q[19]),
        .R(ecc_reset));
  FDRE \data_out_reg[1] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[1]),
        .Q(Q[1]),
        .R(ecc_reset));
  FDRE \data_out_reg[20] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[20]),
        .Q(Q[20]),
        .R(ecc_reset));
  FDRE \data_out_reg[21] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[21]),
        .Q(Q[21]),
        .R(ecc_reset));
  FDRE \data_out_reg[22] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[22]),
        .Q(Q[22]),
        .R(ecc_reset));
  FDRE \data_out_reg[23] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[23]),
        .Q(Q[23]),
        .R(ecc_reset));
  FDRE \data_out_reg[24] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[24]),
        .Q(Q[24]),
        .R(ecc_reset));
  FDRE \data_out_reg[25] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[25]),
        .Q(Q[25]),
        .R(ecc_reset));
  FDRE \data_out_reg[26] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[26]),
        .Q(Q[26]),
        .R(ecc_reset));
  FDRE \data_out_reg[27] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[27]),
        .Q(Q[27]),
        .R(ecc_reset));
  FDRE \data_out_reg[28] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[28]),
        .Q(Q[28]),
        .R(ecc_reset));
  FDRE \data_out_reg[29] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[29]),
        .Q(Q[29]),
        .R(ecc_reset));
  FDRE \data_out_reg[2] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[2]),
        .Q(Q[2]),
        .R(ecc_reset));
  FDRE \data_out_reg[30] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[30]),
        .Q(Q[30]),
        .R(ecc_reset));
  FDRE \data_out_reg[31] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[31]),
        .Q(Q[31]),
        .R(ecc_reset));
  FDRE \data_out_reg[32] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[32]),
        .Q(Q[32]),
        .R(ecc_reset));
  FDRE \data_out_reg[33] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[33]),
        .Q(Q[33]),
        .R(ecc_reset));
  FDRE \data_out_reg[34] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[34]),
        .Q(Q[34]),
        .R(ecc_reset));
  FDRE \data_out_reg[35] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[35]),
        .Q(Q[35]),
        .R(ecc_reset));
  FDRE \data_out_reg[36] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[36]),
        .Q(Q[36]),
        .R(ecc_reset));
  FDRE \data_out_reg[37] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[37]),
        .Q(Q[37]),
        .R(ecc_reset));
  FDRE \data_out_reg[38] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[38]),
        .Q(Q[38]),
        .R(ecc_reset));
  FDRE \data_out_reg[39] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[39]),
        .Q(Q[39]),
        .R(ecc_reset));
  FDRE \data_out_reg[3] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[3]),
        .Q(Q[3]),
        .R(ecc_reset));
  FDRE \data_out_reg[40] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[40]),
        .Q(Q[40]),
        .R(ecc_reset));
  FDRE \data_out_reg[41] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[41]),
        .Q(Q[41]),
        .R(ecc_reset));
  FDRE \data_out_reg[42] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[42]),
        .Q(Q[42]),
        .R(ecc_reset));
  FDRE \data_out_reg[43] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[43]),
        .Q(Q[43]),
        .R(ecc_reset));
  FDRE \data_out_reg[44] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[44]),
        .Q(Q[44]),
        .R(ecc_reset));
  FDRE \data_out_reg[45] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[45]),
        .Q(Q[45]),
        .R(ecc_reset));
  FDRE \data_out_reg[46] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[46]),
        .Q(Q[46]),
        .R(ecc_reset));
  FDRE \data_out_reg[47] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[47]),
        .Q(Q[47]),
        .R(ecc_reset));
  FDRE \data_out_reg[48] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[48]),
        .Q(Q[48]),
        .R(ecc_reset));
  FDRE \data_out_reg[49] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[49]),
        .Q(Q[49]),
        .R(ecc_reset));
  FDRE \data_out_reg[4] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[4]),
        .Q(Q[4]),
        .R(ecc_reset));
  FDRE \data_out_reg[50] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[50]),
        .Q(Q[50]),
        .R(ecc_reset));
  FDRE \data_out_reg[51] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[51]),
        .Q(Q[51]),
        .R(ecc_reset));
  FDRE \data_out_reg[52] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[52]),
        .Q(Q[52]),
        .R(ecc_reset));
  FDRE \data_out_reg[53] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[53]),
        .Q(Q[53]),
        .R(ecc_reset));
  FDRE \data_out_reg[54] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[54]),
        .Q(Q[54]),
        .R(ecc_reset));
  FDRE \data_out_reg[55] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[55]),
        .Q(Q[55]),
        .R(ecc_reset));
  FDRE \data_out_reg[56] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[56]),
        .Q(Q[56]),
        .R(ecc_reset));
  FDRE \data_out_reg[57] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[57]),
        .Q(Q[57]),
        .R(ecc_reset));
  FDRE \data_out_reg[58] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[58]),
        .Q(Q[58]),
        .R(ecc_reset));
  FDRE \data_out_reg[59] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[59]),
        .Q(Q[59]),
        .R(ecc_reset));
  FDRE \data_out_reg[5] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[5]),
        .Q(Q[5]),
        .R(ecc_reset));
  FDRE \data_out_reg[60] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[60]),
        .Q(Q[60]),
        .R(ecc_reset));
  FDRE \data_out_reg[61] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[61]),
        .Q(Q[61]),
        .R(ecc_reset));
  FDRE \data_out_reg[62] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[62]),
        .Q(Q[62]),
        .R(ecc_reset));
  FDRE \data_out_reg[63] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[63]),
        .Q(Q[63]),
        .R(ecc_reset));
  FDRE \data_out_reg[64] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[64]),
        .Q(Q[64]),
        .R(ecc_reset));
  FDRE \data_out_reg[65] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[65]),
        .Q(Q[65]),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[6]),
        .Q(Q[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[7] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[7]),
        .Q(Q[7]),
        .R(ecc_reset));
  FDRE \data_out_reg[8] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[8]),
        .Q(Q[8]),
        .R(ecc_reset));
  FDRE \data_out_reg[9] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[9]),
        .Q(Q[9]),
        .R(ecc_reset));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
