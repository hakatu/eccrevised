////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : arraysp2x.v
// Description  : .for ram single port with 2 clk delay, wrapping output
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Thu Mar 24 15:47:06 2005
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module arraysp2x
    (
     clk,
     rst_,
     a,
     we,
     di,
     do
     );

parameter ADDRBIT = 11;
parameter DEPTH = 1536;
parameter WIDTH = 32;
parameter TYPE = "AUTO";        //This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;

input               clk;
input               rst_;
input [ADDRBIT-1:0] a;
input               we;
input [WIDTH-1:0]   di;
output [WIDTH-1:0]  do;

wire [WIDTH-1:0]    ido;
reg [WIDTH-1:0]     do;

//wrapping logics

//output
always @ (posedge clk or negedge rst_)
    if (~rst_)  do  <= {WIDTH{1'b0}};
    else        do  <= ido;

//single-port ram instantiation
ramspx #(ADDRBIT,DEPTH,WIDTH) ram (clk,a,we,di,ido);

endmodule
