////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : alutesttiming.v
// Description  : to make io suitable for quartus
//
// Author       : PC@DESKTOP-9FI2JF9
// Created On   : Sun Mar 17 21:17:30 2022
// History (Date, Changed By)
//
////update RNVL X255 P256 correct
//
////////////////////////////////////////////////////////////////////////////////

module alutesttiming
    (
     clk,
     rst,

     status,//00 01 10 11 idle computing done error

     a,//INV only input
     b,
     c, //cin for FA
     en,//start ops
     swapop, //priority for swapoperation
     swapvl, //swap value
     opcode, //[1:0]00 01 10 11 fa mul inv exp 
     //[2] 1 X255 0 P256
     //[3] 1 N 0 P

     r,//result //swap a
     rswap,//second result from swap //swap b
     vld
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WID  = 256;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input clk;
input rst;

output [1:0] status;

input a;
input b;
input           c;
input           swapop;
input           swapvl;
input           en;
input [3:0] opcode;
                
output r;
output rswap;
output           vld;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

wire [WID-1:0] asrg,bsrg,rsrg,rswapsrg;

rtldbgsipo1//a
    #(WID,1)
    irtldbgsipo1
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(a),
         .odat(asrg)
         );

rtldbgsipo1//b
    #(WID,1)
    irtldbgsipo2
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(b),
         .odat(bsrg)
         );

rtldbgsipo1//r
    #(1,WID)
    irtldbgsipo3
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(rsrg),
         .odat(r)
         );

rtldbgsipo1//rswap
    #(1,WID)
    irtldbgsipo4
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(rswapsrg),
         .odat(rswap)
         );


aluwrap ialuwrap
    (
     .clk(clk),
     .rst(rst),

     .status(status),//00 01 10 11 idle computing done error

     .a(asrg),//INV only input
     .b(bsrg),
     .c(c), //cin for FA
     .en(en),//start ops
     .swapop(swapop), //priority for swapoperation
     .swapvl(swapvl), //swap value
     .opcode(opcode), //[1:0]00 01 10 11 fa mul inv exp 
     //[2] 1 X255 0 P256
     //[3] 1 N 0 P

     .r(rsrg),//result //swap a
     .rswap(rswapsrg),//second result from swap //swap b
     .vld(vld)
     );

endmodule