// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Aug 25 15:47:19 2015
// Host        : linuxsrv13 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/Share4Syn/Thalassa/Cisco/VU190_SYN_15.2_8SLICE_150824/Synthesis/AF6CCI0011_VU190.srcs/sources_1/ip/xil_ecc_enc_64x8/xil_ecc_enc_64x8_funcsim.v
// Design      : xil_ecc_enc_64x8
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcvu190-flgb2104-2-i-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xil_ecc_enc_64x8,ecc_v2_0,{}" *) (* CORE_GENERATION_INFO = "xil_ecc_enc_64x8,ecc_v2_0,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ecc,x_ipVersion=2.0,x_ipCoreRevision=8,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=virtexu,C_COMPONENT_NAME=xil_ecc_enc_64x8,C_ECC_MODE=0,C_ECC_TYPE=0,C_DATA_WIDTH=64,C_CHK_BIT_WIDTH=8,C_REG_INPUT=1,C_REG_OUTPUT=1,C_PIPELINE=1,C_USE_CLK_ENABLE=1}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* X_CORE_INFO = "ecc_v2_0,Vivado 2015.2" *) 
(* NotValidForBitStream *)
module xil_ecc_enc_64x8
   (ecc_clk,
    ecc_reset,
    ecc_clken,
    ecc_data_in,
    ecc_data_out,
    ecc_chkbits_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ecc_clk CLK" *) input ecc_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ecc_reset RST" *) input ecc_reset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 ecc_clken CE" *) input ecc_clken;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_IN DATA" *) input [63:0]ecc_data_in;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_OUT DATA" *) output [63:0]ecc_data_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_CHKBITS_OUT DATA" *) output [7:0]ecc_chkbits_out;

  wire [7:0]ecc_chkbits_out;
  wire ecc_clk;
  wire ecc_clken;
  wire [63:0]ecc_data_in;
  wire [63:0]ecc_data_out;
  wire ecc_reset;
  wire NLW_inst_ecc_dbit_err_UNCONNECTED;
  wire NLW_inst_ecc_sbit_err_UNCONNECTED;

  (* C_CHK_BIT_WIDTH = "8" *) 
  (* C_COMPONENT_NAME = "xil_ecc_enc_64x8" *) 
  (* C_DATA_WIDTH = "64" *) 
  (* C_ECC_MODE = "0" *) 
  (* C_ECC_TYPE = "0" *) 
  (* C_FAMILY = "virtexu" *) 
  (* C_PIPELINE = "1" *) 
  (* C_REG_INPUT = "1" *) 
  (* C_REG_OUTPUT = "1" *) 
  (* C_USE_CLK_ENABLE = "1" *) 
  (* DONT_TOUCH *) 
  (* TCQ = "100" *) 
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 ECC_DATA_OUT DATA" *) 
  xil_ecc_enc_64x8_ecc_v2_0 inst
       (.ecc_chkbits_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ecc_chkbits_out(ecc_chkbits_out),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_correct_n(1'b0),
        .ecc_data_in(ecc_data_in),
        .ecc_data_out(ecc_data_out),
        .ecc_dbit_err(NLW_inst_ecc_dbit_err_UNCONNECTED),
        .ecc_encode(1'b0),
        .ecc_reset(ecc_reset),
        .ecc_sbit_err(NLW_inst_ecc_sbit_err_UNCONNECTED));
endmodule

(* C_CHK_BIT_WIDTH = "8" *) (* C_COMPONENT_NAME = "xil_ecc_enc_64x8" *) (* C_DATA_WIDTH = "64" *) 
(* C_ECC_MODE = "0" *) (* C_ECC_TYPE = "0" *) (* C_FAMILY = "virtexu" *) 
(* C_PIPELINE = "1" *) (* C_REG_INPUT = "1" *) (* C_REG_OUTPUT = "1" *) 
(* C_USE_CLK_ENABLE = "1" *) (* ORIG_REF_NAME = "ecc_v2_0" *) (* TCQ = "100" *) 
module xil_ecc_enc_64x8_ecc_v2_0
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
  wire [7:0]ecc_chkbits_out;
  wire ecc_clk;
  wire ecc_clken;
  wire [63:0]ecc_data_in;
  wire [63:0]ecc_data_out;
  wire ecc_reset;

  assign ecc_dbit_err = \<const0> ;
  assign ecc_sbit_err = \<const0> ;
  GND GND
       (.G(\<const0> ));
  xil_ecc_enc_64x8_ecc_v2_0_hamming_enc \hamming_ecc_enc_gen.hamming_enc_inst 
       (.ecc_chkbits_out(ecc_chkbits_out),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_data_in(ecc_data_in),
        .ecc_data_out(ecc_data_out),
        .ecc_reset(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_hamming_enc" *) 
module xil_ecc_enc_64x8_ecc_v2_0_hamming_enc
   (ecc_chkbits_out,
    ecc_data_out,
    ecc_reset,
    ecc_clken,
    ecc_data_in,
    ecc_clk);
  output [7:0]ecc_chkbits_out;
  output [63:0]ecc_data_out;
  input ecc_reset;
  input ecc_clken;
  input [63:0]ecc_data_in;
  input ecc_clk;

  wire [7:0]ecc_chkbits_out;
  wire ecc_clk;
  wire ecc_clken;
  wire [63:0]ecc_data_in;
  wire [63:0]ecc_data_out;
  wire ecc_reset;
  wire enc_chkbits_pipe0;
  wire enc_pipe_reg_stage_inst_n_1;
  wire enc_pipe_reg_stage_inst_n_10;
  wire enc_pipe_reg_stage_inst_n_11;
  wire enc_pipe_reg_stage_inst_n_12;
  wire enc_pipe_reg_stage_inst_n_13;
  wire enc_pipe_reg_stage_inst_n_14;
  wire enc_pipe_reg_stage_inst_n_15;
  wire enc_pipe_reg_stage_inst_n_16;
  wire enc_pipe_reg_stage_inst_n_17;
  wire enc_pipe_reg_stage_inst_n_18;
  wire enc_pipe_reg_stage_inst_n_19;
  wire enc_pipe_reg_stage_inst_n_2;
  wire enc_pipe_reg_stage_inst_n_20;
  wire enc_pipe_reg_stage_inst_n_21;
  wire enc_pipe_reg_stage_inst_n_22;
  wire enc_pipe_reg_stage_inst_n_23;
  wire enc_pipe_reg_stage_inst_n_24;
  wire enc_pipe_reg_stage_inst_n_25;
  wire enc_pipe_reg_stage_inst_n_26;
  wire enc_pipe_reg_stage_inst_n_27;
  wire enc_pipe_reg_stage_inst_n_28;
  wire enc_pipe_reg_stage_inst_n_29;
  wire enc_pipe_reg_stage_inst_n_3;
  wire enc_pipe_reg_stage_inst_n_30;
  wire enc_pipe_reg_stage_inst_n_31;
  wire enc_pipe_reg_stage_inst_n_32;
  wire enc_pipe_reg_stage_inst_n_33;
  wire enc_pipe_reg_stage_inst_n_34;
  wire enc_pipe_reg_stage_inst_n_35;
  wire enc_pipe_reg_stage_inst_n_36;
  wire enc_pipe_reg_stage_inst_n_37;
  wire enc_pipe_reg_stage_inst_n_38;
  wire enc_pipe_reg_stage_inst_n_39;
  wire enc_pipe_reg_stage_inst_n_40;
  wire enc_pipe_reg_stage_inst_n_41;
  wire enc_pipe_reg_stage_inst_n_42;
  wire enc_pipe_reg_stage_inst_n_43;
  wire enc_pipe_reg_stage_inst_n_44;
  wire enc_pipe_reg_stage_inst_n_45;
  wire enc_pipe_reg_stage_inst_n_46;
  wire enc_pipe_reg_stage_inst_n_47;
  wire enc_pipe_reg_stage_inst_n_48;
  wire enc_pipe_reg_stage_inst_n_49;
  wire enc_pipe_reg_stage_inst_n_50;
  wire enc_pipe_reg_stage_inst_n_51;
  wire enc_pipe_reg_stage_inst_n_52;
  wire enc_pipe_reg_stage_inst_n_53;
  wire enc_pipe_reg_stage_inst_n_54;
  wire enc_pipe_reg_stage_inst_n_55;
  wire enc_pipe_reg_stage_inst_n_56;
  wire enc_pipe_reg_stage_inst_n_57;
  wire enc_pipe_reg_stage_inst_n_58;
  wire enc_pipe_reg_stage_inst_n_59;
  wire enc_pipe_reg_stage_inst_n_60;
  wire enc_pipe_reg_stage_inst_n_61;
  wire enc_pipe_reg_stage_inst_n_62;
  wire enc_pipe_reg_stage_inst_n_63;
  wire enc_pipe_reg_stage_inst_n_64;
  wire enc_pipe_reg_stage_inst_n_65;
  wire enc_pipe_reg_stage_inst_n_66;
  wire enc_pipe_reg_stage_inst_n_67;
  wire enc_pipe_reg_stage_inst_n_68;
  wire enc_pipe_reg_stage_inst_n_69;
  wire enc_pipe_reg_stage_inst_n_70;
  wire enc_pipe_reg_stage_inst_n_71;
  wire enc_pipe_reg_stage_inst_n_8;
  wire enc_pipe_reg_stage_inst_n_9;
  wire p_0_in;
  wire p_0_in12_in;
  wire p_0_in1_in;
  wire p_0_in47_in;
  wire p_10_in;
  wire p_11_in;
  wire p_11_in17_in;
  wire p_11_in25_in;
  wire p_11_in32_in;
  wire p_12_in;
  wire p_12_in26_in;
  wire p_13_in;
  wire p_13_in18_in;
  wire p_13_in27_in;
  wire p_14_in;
  wire p_14_in28_in;
  wire p_15_in;
  wire p_15_in19_in;
  wire p_15_in33_in;
  wire p_15_in36_in;
  wire p_15_in40_in;
  wire p_15_in43_in;
  wire p_16_in;
  wire p_16_in37_in;
  wire p_17_in;
  wire p_17_in20_in;
  wire p_17_in41_in;
  wire p_18_in;
  wire p_19_in;
  wire p_19_in21_in;
  wire p_19_in34_in;
  wire p_1_in0_in;
  wire p_1_in2_in;
  wire p_1_in48_in;
  wire p_20_in;
  wire p_21_in;
  wire p_21_in22_in;
  wire p_22_in;
  wire p_23_in;
  wire p_23_in23_in;
  wire p_23_in35_in;
  wire p_2_in;
  wire p_2_in3_in;
  wire p_2_in49_in;
  wire p_3_in;
  wire p_3_in13_in;
  wire p_3_in30_in;
  wire p_3_in4_in;
  wire p_42_in;
  wire [71:1]p_44_out;
  wire p_46_in;
  wire p_4_in;
  wire p_4_in5_in;
  wire p_5_in;
  wire p_5_in14_in;
  wire p_5_in6_in;
  wire p_6_in;
  wire p_6_in7_in;
  wire p_7_in;
  wire p_7_in15_in;
  wire p_7_in31_in;
  wire p_7_in39_in;
  wire p_7_in8_in;
  wire p_8_in;
  wire p_8_in9_in;
  wire p_9_in;
  wire p_9_in16_in;
  wire p_9_in24_in;
  wire xor_bits_0_25_pipe;

  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_1 
       (.I0(enc_pipe_reg_stage_inst_n_3),
        .I1(xor_bits_0_25_pipe),
        .I2(p_46_in),
        .I3(p_1_in48_in),
        .I4(p_2_in49_in),
        .I5(p_0_in47_in),
        .O(enc_chkbits_pipe0));
  xil_ecc_enc_64x8_ecc_v2_0_reg_stage enc_input_reg_stage_inst
       (.D({p_44_out[71:64],p_42_in,p_14_in28_in,p_8_in9_in,p_16_in37_in,p_7_in8_in,p_13_in27_in,p_6_in7_in,p_5_in6_in,p_12_in26_in,p_4_in5_in,p_15_in36_in,p_3_in4_in,p_11_in25_in,p_2_in3_in,p_17_in41_in,p_1_in2_in,p_9_in24_in,p_0_in1_in,p_23_in35_in,p_23_in,p_23_in23_in,p_22_in,p_15_in43_in,p_21_in,p_21_in22_in,p_20_in,p_19_in34_in,p_19_in,p_19_in21_in,p_18_in,p_15_in40_in,p_17_in,p_17_in20_in,p_16_in,p_15_in33_in,p_15_in,p_15_in19_in,p_14_in,p_13_in,p_13_in18_in,p_12_in,p_11_in32_in,p_11_in,p_11_in17_in,p_10_in,p_7_in39_in,p_9_in,p_9_in16_in,p_8_in,p_7_in31_in,p_7_in,p_7_in15_in,p_6_in,p_5_in,p_5_in14_in,p_4_in,p_3_in30_in,p_3_in,p_3_in13_in,p_2_in,p_0_in,p_0_in12_in,p_44_out[1],p_1_in0_in}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_data_in(ecc_data_in),
        .ecc_reset(ecc_reset));
  xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1 enc_output_reg_stage_inst
       (.D({enc_pipe_reg_stage_inst_n_1,enc_pipe_reg_stage_inst_n_2,enc_pipe_reg_stage_inst_n_3,p_2_in49_in,p_1_in48_in,p_0_in47_in,p_46_in,enc_chkbits_pipe0,enc_pipe_reg_stage_inst_n_8,enc_pipe_reg_stage_inst_n_9,enc_pipe_reg_stage_inst_n_10,enc_pipe_reg_stage_inst_n_11,enc_pipe_reg_stage_inst_n_12,enc_pipe_reg_stage_inst_n_13,enc_pipe_reg_stage_inst_n_14,enc_pipe_reg_stage_inst_n_15,enc_pipe_reg_stage_inst_n_16,enc_pipe_reg_stage_inst_n_17,enc_pipe_reg_stage_inst_n_18,enc_pipe_reg_stage_inst_n_19,enc_pipe_reg_stage_inst_n_20,enc_pipe_reg_stage_inst_n_21,enc_pipe_reg_stage_inst_n_22,enc_pipe_reg_stage_inst_n_23,enc_pipe_reg_stage_inst_n_24,enc_pipe_reg_stage_inst_n_25,enc_pipe_reg_stage_inst_n_26,enc_pipe_reg_stage_inst_n_27,enc_pipe_reg_stage_inst_n_28,enc_pipe_reg_stage_inst_n_29,enc_pipe_reg_stage_inst_n_30,enc_pipe_reg_stage_inst_n_31,enc_pipe_reg_stage_inst_n_32,enc_pipe_reg_stage_inst_n_33,enc_pipe_reg_stage_inst_n_34,enc_pipe_reg_stage_inst_n_35,enc_pipe_reg_stage_inst_n_36,enc_pipe_reg_stage_inst_n_37,enc_pipe_reg_stage_inst_n_38,enc_pipe_reg_stage_inst_n_39,enc_pipe_reg_stage_inst_n_40,enc_pipe_reg_stage_inst_n_41,enc_pipe_reg_stage_inst_n_42,enc_pipe_reg_stage_inst_n_43,enc_pipe_reg_stage_inst_n_44,enc_pipe_reg_stage_inst_n_45,enc_pipe_reg_stage_inst_n_46,enc_pipe_reg_stage_inst_n_47,enc_pipe_reg_stage_inst_n_48,enc_pipe_reg_stage_inst_n_49,enc_pipe_reg_stage_inst_n_50,enc_pipe_reg_stage_inst_n_51,enc_pipe_reg_stage_inst_n_52,enc_pipe_reg_stage_inst_n_53,enc_pipe_reg_stage_inst_n_54,enc_pipe_reg_stage_inst_n_55,enc_pipe_reg_stage_inst_n_56,enc_pipe_reg_stage_inst_n_57,enc_pipe_reg_stage_inst_n_58,enc_pipe_reg_stage_inst_n_59,enc_pipe_reg_stage_inst_n_60,enc_pipe_reg_stage_inst_n_61,enc_pipe_reg_stage_inst_n_62,enc_pipe_reg_stage_inst_n_63,enc_pipe_reg_stage_inst_n_64,enc_pipe_reg_stage_inst_n_65,enc_pipe_reg_stage_inst_n_66,enc_pipe_reg_stage_inst_n_67,enc_pipe_reg_stage_inst_n_68,enc_pipe_reg_stage_inst_n_69,enc_pipe_reg_stage_inst_n_70,enc_pipe_reg_stage_inst_n_71}),
        .Q({ecc_chkbits_out,ecc_data_out}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_reset(ecc_reset));
  xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0 enc_pipe_reg_stage_inst
       (.D({p_44_out[71:64],p_42_in,p_14_in28_in,p_8_in9_in,p_16_in37_in,p_7_in8_in,p_13_in27_in,p_6_in7_in,p_5_in6_in,p_12_in26_in,p_4_in5_in,p_15_in36_in,p_3_in4_in,p_11_in25_in,p_2_in3_in,p_17_in41_in,p_1_in2_in,p_9_in24_in,p_0_in1_in,p_23_in35_in,p_23_in,p_23_in23_in,p_22_in,p_15_in43_in,p_21_in,p_21_in22_in,p_20_in,p_19_in34_in,p_19_in,p_19_in21_in,p_18_in,p_15_in40_in,p_17_in,p_17_in20_in,p_16_in,p_15_in33_in,p_15_in,p_15_in19_in,p_14_in,p_13_in,p_13_in18_in,p_12_in,p_11_in32_in,p_11_in,p_11_in17_in,p_10_in,p_7_in39_in,p_9_in,p_9_in16_in,p_8_in,p_7_in31_in,p_7_in,p_7_in15_in,p_6_in,p_5_in,p_5_in14_in,p_4_in,p_3_in30_in,p_3_in,p_3_in13_in,p_2_in,p_0_in,p_0_in12_in,p_44_out[1],p_1_in0_in}),
        .Q({xor_bits_0_25_pipe,enc_pipe_reg_stage_inst_n_1,enc_pipe_reg_stage_inst_n_2,enc_pipe_reg_stage_inst_n_3,p_2_in49_in,p_1_in48_in,p_0_in47_in,p_46_in,enc_pipe_reg_stage_inst_n_8,enc_pipe_reg_stage_inst_n_9,enc_pipe_reg_stage_inst_n_10,enc_pipe_reg_stage_inst_n_11,enc_pipe_reg_stage_inst_n_12,enc_pipe_reg_stage_inst_n_13,enc_pipe_reg_stage_inst_n_14,enc_pipe_reg_stage_inst_n_15,enc_pipe_reg_stage_inst_n_16,enc_pipe_reg_stage_inst_n_17,enc_pipe_reg_stage_inst_n_18,enc_pipe_reg_stage_inst_n_19,enc_pipe_reg_stage_inst_n_20,enc_pipe_reg_stage_inst_n_21,enc_pipe_reg_stage_inst_n_22,enc_pipe_reg_stage_inst_n_23,enc_pipe_reg_stage_inst_n_24,enc_pipe_reg_stage_inst_n_25,enc_pipe_reg_stage_inst_n_26,enc_pipe_reg_stage_inst_n_27,enc_pipe_reg_stage_inst_n_28,enc_pipe_reg_stage_inst_n_29,enc_pipe_reg_stage_inst_n_30,enc_pipe_reg_stage_inst_n_31,enc_pipe_reg_stage_inst_n_32,enc_pipe_reg_stage_inst_n_33,enc_pipe_reg_stage_inst_n_34,enc_pipe_reg_stage_inst_n_35,enc_pipe_reg_stage_inst_n_36,enc_pipe_reg_stage_inst_n_37,enc_pipe_reg_stage_inst_n_38,enc_pipe_reg_stage_inst_n_39,enc_pipe_reg_stage_inst_n_40,enc_pipe_reg_stage_inst_n_41,enc_pipe_reg_stage_inst_n_42,enc_pipe_reg_stage_inst_n_43,enc_pipe_reg_stage_inst_n_44,enc_pipe_reg_stage_inst_n_45,enc_pipe_reg_stage_inst_n_46,enc_pipe_reg_stage_inst_n_47,enc_pipe_reg_stage_inst_n_48,enc_pipe_reg_stage_inst_n_49,enc_pipe_reg_stage_inst_n_50,enc_pipe_reg_stage_inst_n_51,enc_pipe_reg_stage_inst_n_52,enc_pipe_reg_stage_inst_n_53,enc_pipe_reg_stage_inst_n_54,enc_pipe_reg_stage_inst_n_55,enc_pipe_reg_stage_inst_n_56,enc_pipe_reg_stage_inst_n_57,enc_pipe_reg_stage_inst_n_58,enc_pipe_reg_stage_inst_n_59,enc_pipe_reg_stage_inst_n_60,enc_pipe_reg_stage_inst_n_61,enc_pipe_reg_stage_inst_n_62,enc_pipe_reg_stage_inst_n_63,enc_pipe_reg_stage_inst_n_64,enc_pipe_reg_stage_inst_n_65,enc_pipe_reg_stage_inst_n_66,enc_pipe_reg_stage_inst_n_67,enc_pipe_reg_stage_inst_n_68,enc_pipe_reg_stage_inst_n_69,enc_pipe_reg_stage_inst_n_70,enc_pipe_reg_stage_inst_n_71}),
        .ecc_clk(ecc_clk),
        .ecc_clken(ecc_clken),
        .ecc_reset(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_enc_64x8_ecc_v2_0_reg_stage
   (D,
    ecc_reset,
    ecc_clken,
    ecc_data_in,
    ecc_clk);
  output [71:0]D;
  input ecc_reset;
  input ecc_clken;
  input [63:0]ecc_data_in;
  input ecc_clk;

  wire [71:0]D;
  wire \data_out[64]_i_2_n_0 ;
  wire \data_out[64]_i_3_n_0 ;
  wire \data_out[64]_i_4_n_0 ;
  wire \data_out[64]_i_5_n_0 ;
  wire \data_out[64]_i_6_n_0 ;
  wire \data_out[64]_i_7_n_0 ;
  wire \data_out[65]_i_2_n_0 ;
  wire \data_out[65]_i_3_n_0 ;
  wire \data_out[65]_i_4_n_0 ;
  wire \data_out[65]_i_5_n_0 ;
  wire \data_out[66]_i_2_n_0 ;
  wire \data_out[66]_i_3_n_0 ;
  wire \data_out[66]_i_4_n_0 ;
  wire \data_out[66]_i_5_n_0 ;
  wire \data_out[66]_i_6_n_0 ;
  wire \data_out[67]_i_2_n_0 ;
  wire \data_out[67]_i_3_n_0 ;
  wire \data_out[67]_i_4_n_0 ;
  wire \data_out[67]_i_5_n_0 ;
  wire \data_out[68]_i_2_n_0 ;
  wire \data_out[68]_i_3_n_0 ;
  wire \data_out[68]_i_4_n_0 ;
  wire \data_out[68]_i_5_n_0 ;
  wire \data_out[69]_i_10_n_0 ;
  wire \data_out[69]_i_2_n_0 ;
  wire \data_out[69]_i_3_n_0 ;
  wire \data_out[69]_i_4_n_0 ;
  wire \data_out[69]_i_5_n_0 ;
  wire \data_out[69]_i_6_n_0 ;
  wire \data_out[69]_i_7_n_0 ;
  wire \data_out[69]_i_8_n_0 ;
  wire \data_out[69]_i_9_n_0 ;
  wire \data_out[70]_i_2_n_0 ;
  wire \data_out[71]_i_2_n_0 ;
  wire \data_out[71]_i_3_n_0 ;
  wire \data_out[71]_i_4_n_0 ;
  wire \data_out[71]_i_5_n_0 ;
  wire \data_out[71]_i_6_n_0 ;
  wire \data_out[71]_i_7_n_0 ;
  wire \data_out[71]_i_8_n_0 ;
  wire \data_out[71]_i_9_n_0 ;
  wire ecc_clk;
  wire ecc_clken;
  wire [63:0]ecc_data_in;
  wire ecc_reset;

  LUT5 #(
    .INIT(32'h96696996)) 
    \data_out[64]_i_1__0 
       (.I0(\data_out[64]_i_2_n_0 ),
        .I1(\data_out[64]_i_3_n_0 ),
        .I2(\data_out[64]_i_4_n_0 ),
        .I3(\data_out[64]_i_5_n_0 ),
        .I4(\data_out[64]_i_6_n_0 ),
        .O(D[64]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_2 
       (.I0(D[56]),
        .I1(D[63]),
        .I2(D[54]),
        .I3(D[46]),
        .I4(D[48]),
        .I5(D[32]),
        .O(\data_out[64]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_3 
       (.I0(D[19]),
        .I1(D[34]),
        .I2(D[42]),
        .I3(D[11]),
        .I4(D[4]),
        .I5(D[26]),
        .O(\data_out[64]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_4 
       (.I0(D[57]),
        .I1(D[50]),
        .I2(D[1]),
        .I3(D[0]),
        .I4(D[52]),
        .I5(D[21]),
        .O(\data_out[64]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_5 
       (.I0(D[13]),
        .I1(D[6]),
        .I2(D[44]),
        .I3(D[36]),
        .I4(D[28]),
        .I5(D[59]),
        .O(\data_out[64]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_6 
       (.I0(D[3]),
        .I1(D[17]),
        .I2(D[15]),
        .I3(D[38]),
        .I4(D[30]),
        .I5(\data_out[64]_i_7_n_0 ),
        .O(\data_out[64]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[64]_i_7 
       (.I0(D[25]),
        .I1(D[61]),
        .I2(D[40]),
        .I3(D[23]),
        .I4(D[10]),
        .I5(D[8]),
        .O(\data_out[64]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[65]_i_1 
       (.I0(\data_out[69]_i_4_n_0 ),
        .I1(\data_out[65]_i_2_n_0 ),
        .I2(\data_out[66]_i_3_n_0 ),
        .I3(\data_out[65]_i_3_n_0 ),
        .I4(\data_out[65]_i_4_n_0 ),
        .I5(\data_out[65]_i_5_n_0 ),
        .O(D[65]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[65]_i_2 
       (.I0(D[2]),
        .I1(D[12]),
        .I2(D[35]),
        .I3(D[31]),
        .I4(D[62]),
        .I5(D[27]),
        .O(\data_out[65]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[65]_i_3 
       (.I0(D[59]),
        .I1(D[63]),
        .I2(D[32]),
        .I3(D[3]),
        .I4(D[43]),
        .I5(D[5]),
        .O(\data_out[65]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[65]_i_4 
       (.I0(D[0]),
        .I1(D[13]),
        .I2(D[6]),
        .I3(D[44]),
        .I4(D[36]),
        .I5(D[28]),
        .O(\data_out[65]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[65]_i_5 
       (.I0(D[58]),
        .I1(\data_out[71]_i_9_n_0 ),
        .I2(\data_out[71]_i_2_n_0 ),
        .I3(\data_out[69]_i_9_n_0 ),
        .I4(\data_out[69]_i_10_n_0 ),
        .I5(\data_out[71]_i_3_n_0 ),
        .O(\data_out[65]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[66]_i_1 
       (.I0(\data_out[69]_i_2_n_0 ),
        .I1(\data_out[66]_i_2_n_0 ),
        .I2(\data_out[66]_i_3_n_0 ),
        .I3(\data_out[66]_i_4_n_0 ),
        .I4(\data_out[66]_i_5_n_0 ),
        .I5(\data_out[66]_i_6_n_0 ),
        .O(D[66]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[66]_i_2 
       (.I0(D[62]),
        .I1(D[60]),
        .I2(D[37]),
        .I3(D[45]),
        .I4(D[14]),
        .I5(D[7]),
        .O(\data_out[66]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \data_out[66]_i_3 
       (.I0(D[56]),
        .I1(D[55]),
        .I2(D[25]),
        .I3(D[24]),
        .O(\data_out[66]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[66]_i_4 
       (.I0(D[3]),
        .I1(D[15]),
        .I2(D[38]),
        .I3(D[30]),
        .I4(D[2]),
        .I5(D[31]),
        .O(\data_out[66]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[66]_i_5 
       (.I0(D[1]),
        .I1(D[63]),
        .I2(D[46]),
        .I3(D[32]),
        .I4(D[61]),
        .I5(D[8]),
        .O(\data_out[66]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[66]_i_6 
       (.I0(D[29]),
        .I1(\data_out[71]_i_9_n_0 ),
        .I2(\data_out[71]_i_2_n_0 ),
        .I3(\data_out[71]_i_4_n_0 ),
        .I4(\data_out[69]_i_9_n_0 ),
        .I5(\data_out[69]_i_10_n_0 ),
        .O(\data_out[66]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[67]_i_1 
       (.I0(\data_out[67]_i_2_n_0 ),
        .I1(\data_out[67]_i_3_n_0 ),
        .O(D[67]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[67]_i_2 
       (.I0(\data_out[69]_i_2_n_0 ),
        .I1(\data_out[71]_i_3_n_0 ),
        .I2(\data_out[69]_i_4_n_0 ),
        .I3(\data_out[66]_i_3_n_0 ),
        .I4(\data_out[67]_i_4_n_0 ),
        .I5(\data_out[67]_i_5_n_0 ),
        .O(\data_out[67]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[67]_i_3 
       (.I0(D[50]),
        .I1(D[6]),
        .I2(D[36]),
        .I3(D[19]),
        .I4(D[34]),
        .I5(D[4]),
        .O(\data_out[67]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[67]_i_4 
       (.I0(D[33]),
        .I1(D[18]),
        .I2(D[49]),
        .I3(\data_out[71]_i_2_n_0 ),
        .I4(\data_out[71]_i_4_n_0 ),
        .I5(\data_out[69]_i_9_n_0 ),
        .O(\data_out[67]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[67]_i_5 
       (.I0(D[8]),
        .I1(D[38]),
        .I2(D[5]),
        .I3(D[35]),
        .I4(D[37]),
        .I5(D[7]),
        .O(\data_out[67]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[68]_i_1 
       (.I0(\data_out[68]_i_2_n_0 ),
        .I1(\data_out[68]_i_3_n_0 ),
        .O(D[68]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[68]_i_2 
       (.I0(\data_out[69]_i_2_n_0 ),
        .I1(\data_out[71]_i_3_n_0 ),
        .I2(\data_out[69]_i_4_n_0 ),
        .I3(\data_out[66]_i_3_n_0 ),
        .I4(\data_out[68]_i_4_n_0 ),
        .I5(\data_out[68]_i_5_n_0 ),
        .O(\data_out[68]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[68]_i_3 
       (.I0(D[50]),
        .I1(D[13]),
        .I2(D[44]),
        .I3(D[19]),
        .I4(D[42]),
        .I5(D[11]),
        .O(\data_out[68]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[68]_i_4 
       (.I0(D[18]),
        .I1(D[49]),
        .I2(D[41]),
        .I3(\data_out[71]_i_9_n_0 ),
        .I4(\data_out[71]_i_4_n_0 ),
        .I5(\data_out[69]_i_10_n_0 ),
        .O(\data_out[68]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[68]_i_5 
       (.I0(D[46]),
        .I1(D[15]),
        .I2(D[43]),
        .I3(D[12]),
        .I4(D[45]),
        .I5(D[14]),
        .O(\data_out[68]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[69]_i_1 
       (.I0(\data_out[69]_i_2_n_0 ),
        .I1(\data_out[69]_i_3_n_0 ),
        .I2(\data_out[69]_i_4_n_0 ),
        .I3(\data_out[69]_i_5_n_0 ),
        .I4(\data_out[69]_i_6_n_0 ),
        .I5(\data_out[69]_i_7_n_0 ),
        .O(D[69]));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[69]_i_10 
       (.I0(D[47]),
        .I1(D[48]),
        .O(\data_out[69]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[69]_i_2 
       (.I0(D[53]),
        .I1(D[54]),
        .O(\data_out[69]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[69]_i_3 
       (.I0(D[35]),
        .I1(D[31]),
        .I2(D[27]),
        .I3(D[37]),
        .I4(D[45]),
        .I5(D[29]),
        .O(\data_out[69]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[69]_i_4 
       (.I0(D[51]),
        .I1(D[52]),
        .O(\data_out[69]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[69]_i_5 
       (.I0(D[26]),
        .I1(D[46]),
        .I2(D[32]),
        .I3(D[38]),
        .I4(D[30]),
        .I5(D[43]),
        .O(\data_out[69]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[69]_i_6 
       (.I0(D[50]),
        .I1(D[44]),
        .I2(D[36]),
        .I3(D[28]),
        .I4(D[34]),
        .I5(D[42]),
        .O(\data_out[69]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[69]_i_7 
       (.I0(D[33]),
        .I1(D[49]),
        .I2(D[41]),
        .I3(\data_out[69]_i_8_n_0 ),
        .I4(\data_out[69]_i_9_n_0 ),
        .I5(\data_out[69]_i_10_n_0 ),
        .O(\data_out[69]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[69]_i_8 
       (.I0(D[55]),
        .I1(D[56]),
        .O(\data_out[69]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[69]_i_9 
       (.I0(D[39]),
        .I1(D[40]),
        .O(\data_out[69]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[70]_i_1 
       (.I0(\data_out[70]_i_2_n_0 ),
        .I1(D[60]),
        .O(D[70]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[70]_i_2 
       (.I0(D[57]),
        .I1(D[59]),
        .I2(D[63]),
        .I3(D[61]),
        .I4(D[62]),
        .I5(D[58]),
        .O(\data_out[70]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[71]_i_1 
       (.I0(\data_out[71]_i_2_n_0 ),
        .I1(\data_out[71]_i_3_n_0 ),
        .I2(\data_out[71]_i_4_n_0 ),
        .I3(\data_out[71]_i_5_n_0 ),
        .I4(\data_out[71]_i_6_n_0 ),
        .I5(\data_out[71]_i_7_n_0 ),
        .O(D[71]));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[71]_i_2 
       (.I0(D[9]),
        .I1(D[10]),
        .O(\data_out[71]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[71]_i_3 
       (.I0(D[20]),
        .I1(D[21]),
        .O(\data_out[71]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[71]_i_4 
       (.I0(D[22]),
        .I1(D[23]),
        .O(\data_out[71]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[71]_i_5 
       (.I0(D[1]),
        .I1(D[0]),
        .I2(D[13]),
        .I3(D[6]),
        .I4(D[19]),
        .I5(D[11]),
        .O(\data_out[71]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[71]_i_6 
       (.I0(D[4]),
        .I1(D[8]),
        .I2(D[3]),
        .I3(D[15]),
        .I4(D[5]),
        .I5(D[2]),
        .O(\data_out[71]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \data_out[71]_i_7 
       (.I0(D[12]),
        .I1(D[14]),
        .I2(D[7]),
        .I3(D[18]),
        .I4(\data_out[71]_i_8_n_0 ),
        .I5(\data_out[71]_i_9_n_0 ),
        .O(\data_out[71]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[71]_i_8 
       (.I0(D[24]),
        .I1(D[25]),
        .O(\data_out[71]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \data_out[71]_i_9 
       (.I0(D[16]),
        .I1(D[17]),
        .O(\data_out[71]_i_9_n_0 ));
  FDRE \data_out_reg[0] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[0]),
        .Q(D[0]),
        .R(ecc_reset));
  FDRE \data_out_reg[10] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[10]),
        .Q(D[10]),
        .R(ecc_reset));
  FDRE \data_out_reg[11] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[11]),
        .Q(D[11]),
        .R(ecc_reset));
  FDRE \data_out_reg[12] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[12]),
        .Q(D[12]),
        .R(ecc_reset));
  FDRE \data_out_reg[13] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[13]),
        .Q(D[13]),
        .R(ecc_reset));
  FDRE \data_out_reg[14] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[14]),
        .Q(D[14]),
        .R(ecc_reset));
  FDRE \data_out_reg[15] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[15]),
        .Q(D[15]),
        .R(ecc_reset));
  FDRE \data_out_reg[16] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[16]),
        .Q(D[16]),
        .R(ecc_reset));
  FDRE \data_out_reg[17] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[17]),
        .Q(D[17]),
        .R(ecc_reset));
  FDRE \data_out_reg[18] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[18]),
        .Q(D[18]),
        .R(ecc_reset));
  FDRE \data_out_reg[19] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[19]),
        .Q(D[19]),
        .R(ecc_reset));
  FDRE \data_out_reg[1] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[1]),
        .Q(D[1]),
        .R(ecc_reset));
  FDRE \data_out_reg[20] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[20]),
        .Q(D[20]),
        .R(ecc_reset));
  FDRE \data_out_reg[21] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[21]),
        .Q(D[21]),
        .R(ecc_reset));
  FDRE \data_out_reg[22] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[22]),
        .Q(D[22]),
        .R(ecc_reset));
  FDRE \data_out_reg[23] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[23]),
        .Q(D[23]),
        .R(ecc_reset));
  FDRE \data_out_reg[24] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[24]),
        .Q(D[24]),
        .R(ecc_reset));
  FDRE \data_out_reg[25] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[25]),
        .Q(D[25]),
        .R(ecc_reset));
  FDRE \data_out_reg[26] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[26]),
        .Q(D[26]),
        .R(ecc_reset));
  FDRE \data_out_reg[27] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[27]),
        .Q(D[27]),
        .R(ecc_reset));
  FDRE \data_out_reg[28] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[28]),
        .Q(D[28]),
        .R(ecc_reset));
  FDRE \data_out_reg[29] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[29]),
        .Q(D[29]),
        .R(ecc_reset));
  FDRE \data_out_reg[2] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[2]),
        .Q(D[2]),
        .R(ecc_reset));
  FDRE \data_out_reg[30] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[30]),
        .Q(D[30]),
        .R(ecc_reset));
  FDRE \data_out_reg[31] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[31]),
        .Q(D[31]),
        .R(ecc_reset));
  FDRE \data_out_reg[32] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[32]),
        .Q(D[32]),
        .R(ecc_reset));
  FDRE \data_out_reg[33] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[33]),
        .Q(D[33]),
        .R(ecc_reset));
  FDRE \data_out_reg[34] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[34]),
        .Q(D[34]),
        .R(ecc_reset));
  FDRE \data_out_reg[35] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[35]),
        .Q(D[35]),
        .R(ecc_reset));
  FDRE \data_out_reg[36] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[36]),
        .Q(D[36]),
        .R(ecc_reset));
  FDRE \data_out_reg[37] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[37]),
        .Q(D[37]),
        .R(ecc_reset));
  FDRE \data_out_reg[38] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[38]),
        .Q(D[38]),
        .R(ecc_reset));
  FDRE \data_out_reg[39] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[39]),
        .Q(D[39]),
        .R(ecc_reset));
  FDRE \data_out_reg[3] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[3]),
        .Q(D[3]),
        .R(ecc_reset));
  FDRE \data_out_reg[40] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[40]),
        .Q(D[40]),
        .R(ecc_reset));
  FDRE \data_out_reg[41] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[41]),
        .Q(D[41]),
        .R(ecc_reset));
  FDRE \data_out_reg[42] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[42]),
        .Q(D[42]),
        .R(ecc_reset));
  FDRE \data_out_reg[43] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[43]),
        .Q(D[43]),
        .R(ecc_reset));
  FDRE \data_out_reg[44] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[44]),
        .Q(D[44]),
        .R(ecc_reset));
  FDRE \data_out_reg[45] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[45]),
        .Q(D[45]),
        .R(ecc_reset));
  FDRE \data_out_reg[46] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[46]),
        .Q(D[46]),
        .R(ecc_reset));
  FDRE \data_out_reg[47] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[47]),
        .Q(D[47]),
        .R(ecc_reset));
  FDRE \data_out_reg[48] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[48]),
        .Q(D[48]),
        .R(ecc_reset));
  FDRE \data_out_reg[49] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[49]),
        .Q(D[49]),
        .R(ecc_reset));
  FDRE \data_out_reg[4] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[4]),
        .Q(D[4]),
        .R(ecc_reset));
  FDRE \data_out_reg[50] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[50]),
        .Q(D[50]),
        .R(ecc_reset));
  FDRE \data_out_reg[51] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[51]),
        .Q(D[51]),
        .R(ecc_reset));
  FDRE \data_out_reg[52] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[52]),
        .Q(D[52]),
        .R(ecc_reset));
  FDRE \data_out_reg[53] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[53]),
        .Q(D[53]),
        .R(ecc_reset));
  FDRE \data_out_reg[54] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[54]),
        .Q(D[54]),
        .R(ecc_reset));
  FDRE \data_out_reg[55] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[55]),
        .Q(D[55]),
        .R(ecc_reset));
  FDRE \data_out_reg[56] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[56]),
        .Q(D[56]),
        .R(ecc_reset));
  FDRE \data_out_reg[57] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[57]),
        .Q(D[57]),
        .R(ecc_reset));
  FDRE \data_out_reg[58] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[58]),
        .Q(D[58]),
        .R(ecc_reset));
  FDRE \data_out_reg[59] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[59]),
        .Q(D[59]),
        .R(ecc_reset));
  FDRE \data_out_reg[5] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[5]),
        .Q(D[5]),
        .R(ecc_reset));
  FDRE \data_out_reg[60] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[60]),
        .Q(D[60]),
        .R(ecc_reset));
  FDRE \data_out_reg[61] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[61]),
        .Q(D[61]),
        .R(ecc_reset));
  FDRE \data_out_reg[62] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[62]),
        .Q(D[62]),
        .R(ecc_reset));
  FDRE \data_out_reg[63] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[63]),
        .Q(D[63]),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[6]),
        .Q(D[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[7] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[7]),
        .Q(D[7]),
        .R(ecc_reset));
  FDRE \data_out_reg[8] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[8]),
        .Q(D[8]),
        .R(ecc_reset));
  FDRE \data_out_reg[9] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(ecc_data_in[9]),
        .Q(D[9]),
        .R(ecc_reset));
endmodule

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized0
   (Q,
    ecc_reset,
    ecc_clken,
    D,
    ecc_clk);
  output [71:0]Q;
  input ecc_reset;
  input ecc_clken;
  input [71:0]D;
  input ecc_clk;

  wire [71:0]D;
  wire [71:0]Q;
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
  FDRE \data_out_reg[66] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[66]),
        .Q(Q[66]),
        .R(ecc_reset));
  FDRE \data_out_reg[67] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[67]),
        .Q(Q[67]),
        .R(ecc_reset));
  FDRE \data_out_reg[68] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[68]),
        .Q(Q[68]),
        .R(ecc_reset));
  FDRE \data_out_reg[69] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[69]),
        .Q(Q[69]),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[6]),
        .Q(Q[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[70] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[70]),
        .Q(Q[70]),
        .R(ecc_reset));
  FDRE \data_out_reg[71] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[71]),
        .Q(Q[71]),
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

(* ORIG_REF_NAME = "ecc_v2_0_reg_stage" *) 
module xil_ecc_enc_64x8_ecc_v2_0_reg_stage__parameterized1
   (Q,
    ecc_reset,
    ecc_clken,
    D,
    ecc_clk);
  output [71:0]Q;
  input ecc_reset;
  input ecc_clken;
  input [71:0]D;
  input ecc_clk;

  wire [71:0]D;
  wire [71:0]Q;
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
  FDRE \data_out_reg[66] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[66]),
        .Q(Q[66]),
        .R(ecc_reset));
  FDRE \data_out_reg[67] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[67]),
        .Q(Q[67]),
        .R(ecc_reset));
  FDRE \data_out_reg[68] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[68]),
        .Q(Q[68]),
        .R(ecc_reset));
  FDRE \data_out_reg[69] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[69]),
        .Q(Q[69]),
        .R(ecc_reset));
  FDRE \data_out_reg[6] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[6]),
        .Q(Q[6]),
        .R(ecc_reset));
  FDRE \data_out_reg[70] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[70]),
        .Q(Q[70]),
        .R(ecc_reset));
  FDRE \data_out_reg[71] 
       (.C(ecc_clk),
        .CE(ecc_clken),
        .D(D[71]),
        .Q(Q[71]),
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
