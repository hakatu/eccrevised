////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : imem2r2wx.v
// Description  : .
//
// Author       : tdhcuong@HW-TDHCUONG
// Created On   : Mon Feb 12 19:03:50 2007
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module imem2r2wx
    (
     testdi,
     clk2x,
     rst2x_,
     
     rst1x_,
     clk1x,
     wa1x1,
     we1x1,
     di1x1,
     re1x1,
     ra1x1,
     do1x1,         //2-clock delay
     wa1x2,
     we1x2,
     di1x2,
     re1x2,
     ra1x2,
     do1x2,         //3-clock delay
     test,
     mask
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter ADDRBIT   = 11;
parameter DEPTH     = 2048;
parameter WIDTH     = 8;
parameter TYPE      = "AUTO";        //This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               testdi;
input               clk2x;
input               rst2x_;

input               rst1x_;
input               clk1x;

input [ADDRBIT-1:0] wa1x1;
input               we1x1;
input [WIDTH-1:0]   di1x1;
input               re1x1;
input [ADDRBIT-1:0] ra1x1;
output [WIDTH-1:0]  do1x1;

input [ADDRBIT-1:0] wa1x2;
input               we1x2;
input [WIDTH-1:0]   di1x2;
input               re1x2;
input [ADDRBIT-1:0] ra1x2;
output [WIDTH-1:0]  do1x2;  

input               test;
input               mask;

wire [WIDTH-1:0]    odo1x1;
fflopx #(WIDTH) ppodo1x1(clk1x,rst1x_,odo1x1,do1x1);

iarray2223_2r2w_spx #(ADDRBIT,DEPTH,WIDTH,TYPE)    mem
    (
     .testdi(testdi),
     .clk2x (clk2x),
     .rst2x_(rst2x_),
     
     .rst1x_(rst1x_),
     .clk1x (clk1x),
     .wa1x1 (wa1x1),
     .we1x1 (we1x1),
     .di1x1 (di1x1),
     .re1x1 (re1x1),
     .ra1x1 (ra1x1),
     .do1x1 (odo1x1),         //2-clock delay
     .wa1x2 (wa1x2),
     .we1x2 (we1x2),
     .di1x2 (di1x2),
     .re1x2 (re1x2),
     .ra1x2 (ra1x2),
     .do1x2 (do1x2),         //3-clock delay
     .test  (test),
     .mask  (mask)
     );

endmodule 
