////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4eos_agg_wprt_ctrl.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Thu Apr 07 13:19:07 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4eos_agg_wprt_ctrl
    (
     wrst,
     wclk,
     wen,
     waddr,
     gwprt,
     grprt,
     wfull,
     whfull,
     wlen
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           ADDR = 8;
parameter           DEP = 256;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               wrst;
input               wclk;
input               wen;
output [ADDR-1:0]   waddr;
output [ADDR:0]     gwprt;
input [ADDR:0]      grprt;
output              wfull;
output              whfull;
output [ADDR:0]     wlen;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                wrst;
wire                wclk;
wire                wen;
wire [ADDR-1:0]     waddr;
wire [ADDR:0]       gwprt;
wire [ADDR:0]       grprt;
wire                wfull;
wire                whfull;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [ADDR:0]       addr;
wire [ADDR:0]       nxt_addr;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)    cr_addr(wclk,wrst,nxt_addr,addr);
wire [ADDR:0]       gaddr;
wire [ADDR:0]       nxt_gaddr;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)    cr_gaddr(wclk,wrst,nxt_gaddr,gaddr);
wire                inc;
assign              inc = (~wfull) & wen;
assign              nxt_addr = addr + inc;
af4eos_agg_bin2gray #(ADDR+1) bin2gray(.b(nxt_addr),.g(nxt_gaddr));
wire [ADDR:0]       grprt1,grprt2;
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)    cr_grprt1(wclk,wrst,grprt ,grprt1);
tc141_fflopx #(ADDR+1,{ADDR+1{1'b0}},1)    cr_grprt2(wclk,wrst,grprt1,grprt2);
wire                full;
//assign              full = (nxt_gaddr=={~grprt2[ADDR:ADDR-1],grprt2[ADDR-2:0]});
wire                hfull;
//assign              hfull = (nxt_gaddr[ADDR-1:0]=={~grprt2[ADDR-1:ADDR-2],grprt2[ADDR-3:0]});
wire [ADDR:0]       brprt;
af4eos_agg_gray2bin #(ADDR+1) gray2bin(.g(grprt2),.b(brprt));
wire [ADDR:0]       len;
assign              len     = nxt_addr - brprt;
//assign              full    = len[ADDR];
assign              full    = (len == DEP-1);//130620 minhtc fix bug_aggdec130618: vcg7 got DA of vcg23
assign              hfull   = |len[ADDR:ADDR-1];

////////////////////////////////////////////////////////////////////////////////
// output process
assign              waddr = addr[ADDR-1:0];
assign              gwprt = gaddr;
fflopnx #(1)         cr_wfull (wclk,wrst,full ,wfull);
fflopnx #(1)         cr_whfull(wclk,wrst,hfull,whfull);
fflopnx #(ADDR+1)    cr_wlen  (wclk,wrst,len,wlen);

////////////////////////////////////////////////////////////////////////////////


endmodule 
