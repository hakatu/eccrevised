// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Aug 25 15:47:19 2015
// Host        : linuxsrv13 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/Share4Syn/Thalassa/Cisco/VU190_SYN_15.2_8SLICE_150824/Synthesis/AF6CCI0011_VU190.srcs/sources_1/ip/xil_ecc_enc_64x8/xil_ecc_enc_64x8_stub.v
// Design      : xil_ecc_enc_64x8
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu190-flgb2104-2-i-es2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ecc_v2_0,Vivado 2015.2" *)
module xil_ecc_enc_64x8(ecc_clk, ecc_reset, ecc_clken, ecc_data_in, ecc_data_out, ecc_chkbits_out)
/* synthesis syn_black_box black_box_pad_pin="ecc_clk,ecc_reset,ecc_clken,ecc_data_in[63:0],ecc_data_out[63:0],ecc_chkbits_out[7:0]" */;
  input ecc_clk;
  input ecc_reset;
  input ecc_clken;
  input [63:0]ecc_data_in;
  output [63:0]ecc_data_out;
  output [7:0]ecc_chkbits_out;
endmodule
