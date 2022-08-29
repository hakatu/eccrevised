// megafunction wizard: %ALTDDIO_IN%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altddio_in 

// ============================================================
// File Name: alt_ddr_input.v
// Megafunction Name(s):
//          altddio_in
//
// Simulation Library Files(s):
//          altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 7.2 Build 151 09/26/2007 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2007 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
//`timescale 1 ps / 1 ps
// synopsys translate_on
module alt_ddr_input (
    datain,
    inclock,
    dataout_h,
    dataout_l);

     parameter PAD_WIDTH = 8;
    input   [PAD_WIDTH-1:0]  datain;
    input     inclock;
    output  [PAD_WIDTH-1:0]  dataout_h;
    output  [PAD_WIDTH-1:0]  dataout_l;

reg [PAD_WIDTH-1:0]          dataout_h;
reg [PAD_WIDTH-1:0]          dataout_l;
reg [PAD_WIDTH-1:0]          dataout_lo;

always @(posedge inclock)
    dataout_h <= datain;

always @(negedge inclock)
    dataout_lo <= datain;

always @(posedge inclock)
    dataout_l <= dataout_lo;

endmodule
