////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4eos_agg_rprt_ctrl.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Thu Apr 07 13:43:32 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4eos_agg_rprt_ctrl
    (
     rrst,
     rclk,
     ren,
     raddr,
     grprt,
     gwprt,
     rempty,
     rdy
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           ADDR = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               rrst;
input               rclk;
input               ren;
output [ADDR-1:0]   raddr;
output [ADDR:0]     grprt;
input [ADDR:0]      gwprt;
output              rempty;
output              rdy;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                rrst;
wire                rclk;
wire                ren;
wire [ADDR-1:0]     raddr;
wire [ADDR:0]       grprt;
wire [ADDR:0]       gwprt;
wire                rempty;
wire                rdy;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [ADDR:0]       addr;
wire [ADDR:0]       nxt_addr;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)   cr_addr(rclk,rrst,nxt_addr,addr);
wire [ADDR:0]       gaddr;
wire [ADDR:0]       nxt_gaddr;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)    cr_gaddr(rclk,rrst,nxt_gaddr,gaddr);
wire                inc;
assign              inc = (~rempty) & ren;
assign              nxt_addr = addr + inc;
af4eos_agg_bin2gray #(ADDR+1) bin2gray(nxt_addr,nxt_gaddr);
wire [ADDR:0]       gwprt1,gwprt2;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)   crgwprt1(rclk,rrst,gwprt ,gwprt1);
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)   crgwprt2(rclk,rrst,gwprt1,gwprt2);
wire                empty;
assign              empty = (nxt_gaddr==gwprt2);
////////////////////////////////////////////////////////////////////////////////
// output process
assign              raddr = addr[ADDR-1:0];
assign              grprt = gaddr;
fflopnx #(1,1)       cr_rempty(rclk,rrst,empty,rempty);
assign              rdy = ~rrst;
////////////////////////////////////////////////////////////////////////////////


endmodule 
