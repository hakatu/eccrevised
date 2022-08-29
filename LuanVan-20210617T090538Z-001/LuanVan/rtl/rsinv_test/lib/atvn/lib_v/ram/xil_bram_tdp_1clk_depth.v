////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_tdp_1clk_depth.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon Jul 06 10:51:24 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_tdp_1clk_depth
    (
     clka,
     rsta,
     adra,
     wena,
     wdaa,
     rena,
     rdaa,
     
     rstb,
     adrb,
     wenb,
     wdab,
     renb,
     rdab
     
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
input [ADR-1:0]     adra;
input [ADR-1:0]     adrb;
input [DAT-1:0]     wdaa;
input [DAT-1:0]     wdab;
input               clka;
input               wena;
input               wenb;
input               rena;
input               renb;
input               rsta;
input               rstb;
output [DAT-1:0]    rdaa;
output [DAT-1:0]    rdab;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
`include  "xil_bram_sel_depth_tdp.vh"

tc141_fflopd #(1,1)cr_rsela7_p1(clka,rsta,rsela7,rsela7_p1);     tc141_fflopd #(1,1)cr_rselb7_p1(clka,rstb,rselb7,rselb7_p1);
tc141_fflopd #(1,1)cr_rsela6_p1(clka,rsta,rsela6,rsela6_p1);     tc141_fflopd #(1,1)cr_rselb6_p1(clka,rstb,rselb6,rselb6_p1);
tc141_fflopd #(1,1)cr_rsela5_p1(clka,rsta,rsela5,rsela5_p1);     tc141_fflopd #(1,1)cr_rselb5_p1(clka,rstb,rselb5,rselb5_p1);
tc141_fflopd #(1,1)cr_rsela4_p1(clka,rsta,rsela4,rsela4_p1);     tc141_fflopd #(1,1)cr_rselb4_p1(clka,rstb,rselb4,rselb4_p1);
tc141_fflopd #(1,1)cr_rsela3_p1(clka,rsta,rsela3,rsela3_p1);     tc141_fflopd #(1,1)cr_rselb3_p1(clka,rstb,rselb3,rselb3_p1);
tc141_fflopd #(1,1)cr_rsela2_p1(clka,rsta,rsela2,rsela2_p1);     tc141_fflopd #(1,1)cr_rselb2_p1(clka,rstb,rselb2,rselb2_p1);
tc141_fflopd #(1,1)cr_rsela1_p1(clka,rsta,rsela1,rsela1_p1);     tc141_fflopd #(1,1)cr_rselb1_p1(clka,rstb,rselb1,rselb1_p1);
tc141_fflopd #(1,1)cr_rsela0_p1(clka,rsta,rsela0,rsela0_p1);     tc141_fflopd #(1,1)cr_rselb0_p1(clka,rstb,rselb0,rselb0_p1);
                                                                 
tc141_fflopd #(1,1)cr_rsela7_p2(clka,rsta,rsela7_p1,rsela7_p2);  tc141_fflopd #(1,1)cr_rselb7_p2(clka,rstb,rselb7_p1,rselb7_p2);
tc141_fflopd #(1,1)cr_rsela6_p2(clka,rsta,rsela6_p1,rsela6_p2);  tc141_fflopd #(1,1)cr_rselb6_p2(clka,rstb,rselb6_p1,rselb6_p2);
tc141_fflopd #(1,1)cr_rsela5_p2(clka,rsta,rsela5_p1,rsela5_p2);  tc141_fflopd #(1,1)cr_rselb5_p2(clka,rstb,rselb5_p1,rselb5_p2);
tc141_fflopd #(1,1)cr_rsela4_p2(clka,rsta,rsela4_p1,rsela4_p2);  tc141_fflopd #(1,1)cr_rselb4_p2(clka,rstb,rselb4_p1,rselb4_p2);
tc141_fflopd #(1,1)cr_rsela3_p2(clka,rsta,rsela3_p1,rsela3_p2);  tc141_fflopd #(1,1)cr_rselb3_p2(clka,rstb,rselb3_p1,rselb3_p2);
tc141_fflopd #(1,1)cr_rsela2_p2(clka,rsta,rsela2_p1,rsela2_p2);  tc141_fflopd #(1,1)cr_rselb2_p2(clka,rstb,rselb2_p1,rselb2_p2);
tc141_fflopd #(1,1)cr_rsela1_p2(clka,rsta,rsela1_p1,rsela1_p2);  tc141_fflopd #(1,1)cr_rselb1_p2(clka,rstb,rselb1_p1,rselb1_p2);
tc141_fflopd #(1,1)cr_rsela0_p2(clka,rsta,rsela0_p1,rsela0_p2);  tc141_fflopd #(1,1)cr_rselb0_p2(clka,rstb,rselb0_p1,rselb0_p2);

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation


generate
if(NUMBLK[7]==1'b1)
    begin : inst_7
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR7),
      .DAT(DAT),
      .DEP(1<<ADR7),
      .DEL(DEL)
      )                 xil_bram_tdp7
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra7),
     .wena(wena7),
     .wdaa(wdaa7),
     .rena(rena7|wena7),
     .rdaa(rdaa7),
     
     .rstb(rstb),
     .adrb(adrb7),
     .wenb(wenb7),
     .wdab(wdab7),
     .renb(renb7|wenb7),
     .rdab(rdab7)
     
     );
    end
else 
    begin : dis_7
assign  rdaa7 = {DAT{1'b0}};
assign  rdab7 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[6]==1'b1)
    begin : inst_6
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR6),
      .DAT(DAT),
      .DEP(1<<ADR6),
      .DEL(DEL)
      )                 xil_bram_tdp6
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra6),
     .wena(wena6),
     .wdaa(wdaa6),
     .rena(rena6|wena6),
     .rdaa(rdaa6),
     
     .rstb(rstb),
     .adrb(adrb6),
     .wenb(wenb6),
     .wdab(wdab6),
     .renb(renb6|wenb6),
     .rdab(rdab6)
     
     );
    end
else 
    begin : dis_6
assign  rdaa6 = {DAT{1'b0}};
assign  rdab6 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[5]==1'b1)
    begin : inst_5
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR5),
      .DAT(DAT),
      .DEP(1<<ADR5),
      .DEL(DEL)
      )                 xil_bram_tdp5
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra5),
     .wena(wena5),
     .wdaa(wdaa5),
     .rena(rena5|wena5),
     .rdaa(rdaa5),
     
     .rstb(rstb),
     .adrb(adrb5),
     .wenb(wenb5),
     .wdab(wdab5),
     .renb(renb5|wenb5),
     .rdab(rdab5)
     
     );
    end
else 
    begin : dis_5
assign  rdaa5 = {DAT{1'b0}};
assign  rdab5 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[4]==1'b1)
    begin : inst_4
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR4),
      .DAT(DAT),
      .DEP(1<<ADR4),
      .DEL(DEL)
      )                 xil_bram_tdp4
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra4),
     .wena(wena4),
     .wdaa(wdaa4),
     .rena(rena4|wena4),
     .rdaa(rdaa4),
     
     .rstb(rstb),
     .adrb(adrb4),
     .wenb(wenb4),
     .wdab(wdab4),
     .renb(renb4|wenb4),
     .rdab(rdab4)
     
     );
    end
else 
    begin : dis_4
assign  rdaa4 = {DAT{1'b0}};
assign  rdab4 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[3]==1'b1)
    begin : inst_3
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR3),
      .DAT(DAT),
      .DEP(1<<ADR3),
      .DEL(DEL)
      )                 xil_bram_tdp3
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra3),
     .wena(wena3),
     .wdaa(wdaa3),
     .rena(rena3|wena3),
     .rdaa(rdaa3),
     
     .rstb(rstb),
     .adrb(adrb3),
     .wenb(wenb3),
     .wdab(wdab3),
     .renb(renb3|wenb3),
     .rdab(rdab3)
     
     );
    end
else 
    begin : dis_3
assign  rdaa3 = {DAT{1'b0}};
assign  rdab3 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[2]==1'b1)
    begin : inst_2
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR2),
      .DAT(DAT),
      .DEP(1<<ADR2),
      .DEL(DEL)
      )                 xil_bram_tdp2
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra2),
     .wena(wena2),
     .wdaa(wdaa2),
     .rena(rena2|wena2),
     .rdaa(rdaa2),
     
     .rstb(rstb),
     .adrb(adrb2),
     .wenb(wenb2),
     .wdab(wdab2),
     .renb(renb2|wenb2),
     .rdab(rdab2)
     
     );
    end
else 
    begin : dis_2
assign  rdaa2 = {DAT{1'b0}};
assign  rdab2 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[1]==1'b1)
    begin : inst_1
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR1),
      .DAT(DAT),
      .DEP(1<<ADR1),
      .DEL(DEL)
      )                 xil_bram_tdp1
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra1),
     .wena(wena1),
     .wdaa(wdaa1),
     .rena(rena1|wena1),
     .rdaa(rdaa1),
     
     .rstb(rstb),
     .adrb(adrb1),
     .wenb(wenb1),
     .wdab(wdab1),
     .renb(renb1|wenb1),
     .rdab(rdab1)
     
     );
    end
else 
    begin : dis_1
assign  rdaa1 = {DAT{1'b0}};
assign  rdab1 = {DAT{1'b0}};
    end
    
endgenerate

generate
if(NUMBLK[0]==1'b1)
    begin : inst_0
xil_bram_tdp_rdf_1clk
    #(.ADR(ADR0),
      .DAT(DAT),
      .DEP(1<<ADR0),
      .DEL(DEL)
      )                 xil_bram_tdp0
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra0),
     .wena(wena0),
     .wdaa(wdaa0),
     .rena(rena0|wena0),
     .rdaa(rdaa0),
     
     .rstb(rstb),
     .adrb(adrb0),
     .wenb(wenb0),
     .wdab(wdab0),
     .renb(renb0|wenb0),
     .rdab(rdab0)
     
     );
    end
else 
    begin : dis_0
assign  rdaa0 = {DAT{1'b0}};
assign  rdab0 = {DAT{1'b0}};
    end
    
endgenerate





endmodule 
