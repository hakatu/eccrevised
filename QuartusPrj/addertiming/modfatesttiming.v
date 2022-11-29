////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : modfatesttiming.v
// Description  : to make io suitable for quartus
//
// Author       : PC@DESKTOP-9FI2JF9
// Created On   : Sun Mar 17 21:17:30 2022
// History (Date, Changed By)
//
////update RNVL X255 P256 correct
//
////////////////////////////////////////////////////////////////////////////////

module modfatesttiming
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
input op1;
input op2;
input mod;
input             cin;
input             en;   // set in a cycle

output sum;
output             vld; 

////////////////////////////////////////////////////////////////////////////////
// Output declarations

wire [WIDTH-1:0] op1rg,op2rg,modrg,sumrg;

rtldbgsipo1//1
    #(WIDTH,1)
    irtldbgsipo1
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(op1),
         .odat(op1rg)
         );

rtldbgsipo1//2
    #(WIDTH,1)
    irtldbgsipo2
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(op2),
         .odat(op2rg)
         );

rtldbgsipo1//2
    #(WIDTH,1)
    irtldbgsipo3
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(mod),
         .odat(modrg)
         );

rtldbgsipo1//sum
    #(1,WIDTH)
    irtldbgsipo4
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(sumrg),
         .odat(sum)
         );

modfa imodfa
    (
     .clk(clk),
     .rst(rst),
     .op1(op1rg),
     .op2(op2rg),
     .mod(modrg),
     .cin(cin),
     .en(en),
     .sum(sumrg),
     .vld(vld)
     );


endmodule