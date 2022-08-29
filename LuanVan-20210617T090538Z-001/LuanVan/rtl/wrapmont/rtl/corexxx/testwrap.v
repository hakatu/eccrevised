////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : testwrap.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Fri May 10 10:24:55 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module testwrap
    (
     clk,
     rst,
     en,
     done
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WID = 256;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input clk;
input rst;

input en;
output done;
////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire  auvld;
wire [WID-1:0] audat;
wire [WID-1:0] aurswap;

wire [3:0]     opcode;
wire           auen;
wire           carry;
wire           swapop;
wire           swapvl;

wire [4:0]     ra;
wire [4:0]     wa;
wire           we;
wire [WID-1:0] wd;
wire [WID-1:0] rd;

auc_mmul iauc_mmul
    (
     .clk(clk),
     .rst(rst),
     
     // Input
     .mmul_en(en),//controller

     //from ALU
     .mmul_auvld(auvld),
     .mmul_audat(audat),
     .mmul_aurswap(aurswap),
     // Output
     .mmul_done(done),//done

     //to ALU
     .mmul_opcode(opcode),
     .mmul_auen(auen),
     .mmul_carry(carry),
     .mmul_swapop(swapop),
     .mmul_swapvl(swapvl),
     
     // RAM control
     .mmul_ra(ra),
     .mmul_wa(wa),
     .mmul_we(we),
     .mmul_wd(wd)
     );

alram113x ialram113x
    (
     .clkw(clk),//clock write
     .clkr(clk),//clock read
     .rst(rst),
     
     .rdo(rd),//data from ram
     .ra(ra),//read address
     
     .wdi(wd),//data to ram
     .wa(wa),//write address
     .we(we) //write enable
     );

wire [WID-1:0] rd1;

fflopx #(256) iff1(clk,rst,rd,rd1);

wire           auen1,auen2,auen3,auen4;
fflopx #(1) iff2(clk,rst,auen,auen1);
fflopx #(1) iff3(clk,rst,auen1,auen2);
fflopx #(1) iff4(clk,rst,auen2,auen3);
fflopx #(1) iff5(clk,rst,auen3,auen4);
aluwrap ialuwrap
    (
     .clk(clk),
     .rst(rst),

     .status(),//00 01 10 11 idle computing done error

     .a(rd),//INV only input
     .b(rd1),
     .c(carry), //cin for FA
     .en(auen4),//start ops
     .swapop(swapop), //priority for swapoperation
     .swapvl(swapvl), //swap value
     .opcode(opcode), //[1:0]00 01 10 11 fa mul inv exp 
     //[2] 1 X255 0 P256
     //[3] 1 N 0 P

     .r(audat),//result //swap a
     .rswap(aurswap),//second result from swap //swap b
     .vld(auvld)
     );
endmodule 
