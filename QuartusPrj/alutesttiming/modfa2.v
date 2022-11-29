////////////////////////////////////////////////////////////////////////////////
//
// Ho Chi Minh City University of Technology
//
// Filename     : modfa2
// Description  : .
//
// Author       : Nguyen Tuan Hung
// Created On   : Fri Mar 08 09:33:17 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module modfa2
    (
     clk,
     rst,
     op1,
     op2,
     mod,
     cin,
     en,
     sum,
     vld
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 256;
parameter INIT  = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input     clk;
input     rst;
input [WIDTH-1:0] op1;
input [WIDTH-1:0] op2;
input [WIDTH-1:0] mod;
input             cin;
input             en;   // set in a cycle

output [WIDTH-1:0] sum;
output             vld; 

////////////////////////////////////////////////////////////////////////////

wire [WIDTH-1:0] op1knx;

fflopknx #(WIDTH,5) ifflopknx1(clk,rst,op1,op1knx);

wire [WIDTH-1:0] op2knx;

fflopknx #(WIDTH,5) ifflopknx2(clk,rst,op2,op2knx);

wire [WIDTH-1:0] modknx;

fflopknx #(WIDTH,5) ifflopknx3(clk,rst,mod,modknx);

wire cinknx;

fflopknx #(1,20) ifflopknx4(clk,rst,cin,cinknx);

wire [WIDTH-1:0] sumknx;

assign sumknx = (op1knx+op2knx+cinknx)%modknx;

fflopknx #(WIDTH,20) ifflopknx5(clk,rst,sumknx,sum);

endmodule

