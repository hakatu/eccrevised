////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_sdp_2clk_depth.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon Jul 06 10:51:24 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_sdp_2clk_depth
    (
     wclk,
     wen ,
     wad ,
     wda ,
     rclk,
     rrst,
     ren ,
     rad ,
     rda 
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ADR = 10;
parameter DAT = 18;
parameter DEP = 1024;
parameter DEL = 1   ;
parameter MAX = 1024;
parameter INIT_FILE = "";

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               wclk;
input [ADR-1:0]     wad ;
input [ADR-1:0]     rad ;
input [DAT-1:0]     wda ;
input               rclk;
input               rrst;
input               wen ;
input               ren ;
output [DAT-1:0]    rda ;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
`include  "xil_bram_sel_depth_sdp.vh"

tc141_fflopd #(1,1)cr_rsel7_p1(rclk,rrst,rsel7,rsel7_p1);
tc141_fflopd #(1,1)cr_rsel6_p1(rclk,rrst,rsel6,rsel6_p1);
tc141_fflopd #(1,1)cr_rsel5_p1(rclk,rrst,rsel5,rsel5_p1);
tc141_fflopd #(1,1)cr_rsel4_p1(rclk,rrst,rsel4,rsel4_p1);
tc141_fflopd #(1,1)cr_rsel3_p1(rclk,rrst,rsel3,rsel3_p1);
tc141_fflopd #(1,1)cr_rsel2_p1(rclk,rrst,rsel2,rsel2_p1);
tc141_fflopd #(1,1)cr_rsel1_p1(rclk,rrst,rsel1,rsel1_p1);
tc141_fflopd #(1,1)cr_rsel0_p1(rclk,rrst,rsel0,rsel0_p1);

tc141_fflopd #(1,1)cr_rsel7_p2(rclk,rrst,rsel7_p1,rsel7_p2);
tc141_fflopd #(1,1)cr_rsel6_p2(rclk,rrst,rsel6_p1,rsel6_p2);
tc141_fflopd #(1,1)cr_rsel5_p2(rclk,rrst,rsel5_p1,rsel5_p2);
tc141_fflopd #(1,1)cr_rsel4_p2(rclk,rrst,rsel4_p1,rsel4_p2);
tc141_fflopd #(1,1)cr_rsel3_p2(rclk,rrst,rsel3_p1,rsel3_p2);
tc141_fflopd #(1,1)cr_rsel2_p2(rclk,rrst,rsel2_p1,rsel2_p2);
tc141_fflopd #(1,1)cr_rsel1_p2(rclk,rrst,rsel1_p1,rsel1_p2);
tc141_fflopd #(1,1)cr_rsel0_p2(rclk,rrst,rsel0_p1,rsel0_p2);

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation


generate
if(NUMBLK[7]==1'b1)
    begin : inst_7
xil_bram_sdp_2clk
    #(.ADR(ADR7),
      .DAT(DAT),
      .DEP(1<<ADR7),
      .DEL(DEL)
     )                 xil_bram_sdp7
    (
     .wclk(wclk),
     .wen(wen7),
     .wad(wad7),
     .wda(wda7),
     .rclk(rclk),
     .rrst(rrst),
     .ren(ren7),
     .rad(rad7),
     .rda(rda7)
     );
    end
else
    begin : dis_7
assign  rda7 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[6]==1'b1)
    begin : inst_6
xil_bram_sdp_2clk
    #(.ADR(ADR6),
      .DAT(DAT),
      .DEP(1<<ADR6),
      .DEL(DEL)
     )                 xil_bram_sdp6
    (
      .wclk(wclk),
      .wen(wen6),
      .wad(wad6),
      .wda(wda6),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren6),
      .rad(rad6),
      .rda(rda6)
     );
    end
else
    begin : dis_6
assign  rda6 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[5]==1'b1)
    begin : inst_5
xil_bram_sdp_2clk
    #(.ADR(ADR5),
      .DAT(DAT),
      .DEP(1<<ADR5),
      .DEL(DEL)
     )                 xil_bram_sdp5
    (
      .wclk(wclk),
      .wen(wen5),
      .wad(wad5),
      .wda(wda5),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren5),
      .rad(rad5),
      .rda(rda5)
     );
    end
else
    begin : dis_5
assign  rda5 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[4]==1'b1)
    begin : inst_4
xil_bram_sdp_2clk
    #(.ADR(ADR4),
      .DAT(DAT),
      .DEP(1<<ADR4),
      .DEL(DEL)
     )                 xil_bram_sdp4
    (
      .wclk(wclk),
      .wen(wen4),
      .wad(wad4),
      .wda(wda4),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren4),
      .rad(rad4),
      .rda(rda4)
     );
    end
else
    begin : dis_4
assign  rda4 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[3]==1'b1)
    begin : inst_3
xil_bram_sdp_2clk
    #(.ADR(ADR3),
      .DAT(DAT),
      .DEP(1<<ADR3),
      .DEL(DEL)
     )                 xil_bram_sdp3
    (
      .wclk(wclk),
      .wen(wen3),
      .wad(wad3),
      .wda(wda3),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren3),
      .rad(rad3),
      .rda(rda3)
     );
    end
else
    begin : dis_3
assign  rda3 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[2]==1'b1)
    begin : inst_2
xil_bram_sdp_2clk
    #(.ADR(ADR2),
      .DAT(DAT),
      .DEP(1<<ADR2),
      .DEL(DEL)
     )                 xil_bram_sdp2
    (
      .wclk(wclk),
      .wen(wen2),
      .wad(wad2),
      .wda(wda2),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren2),
      .rad(rad2),
      .rda(rda2)
     );
    end
else
    begin : dis_2
assign  rda2 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[1]==1'b1)
    begin : inst_1
xil_bram_sdp_2clk
    #(.ADR(ADR1),
      .DAT(DAT),
      .DEP(1<<ADR1),
      .DEL(DEL)
     )                 xil_bram_sdp1
    (
      .wclk(wclk),
      .wen(wen1),
      .wad(wad1),
      .wda(wda1),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren1),
      .rad(rad1),
      .rda(rda1)
     );
    end
else
    begin : dis_1
assign  rda1 = {DAT{1'b0}};
    end

endgenerate

generate
if(NUMBLK[0]==1'b1)
    begin : inst_0
xil_bram_sdp_2clk
    #(.ADR(ADR0),
      .DAT(DAT),
      .DEP(1<<ADR0),
      .DEL(DEL)
     )                 xil_bram_sdp0
    (
      .wclk(wclk),
      .wen(wen0),
      .wad(wad0),
      .wda(wda0),
      .rclk(rclk),
      .rrst(rrst),
      .ren(ren0),
      .rad(rad0),
      .rda(rda0)
     );
    end
else
    begin : dis_0
assign  rda0 = {DAT{1'b0}};
    end

endgenerate


endmodule
