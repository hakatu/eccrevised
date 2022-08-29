////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_sdp_1clk_wrap.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon Jul 06 10:51:24 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_sdp_1clk_wrap
    (
     clk,
     rst,
     wen,
     wad,
     wda,
     ren,
     rad,
     rda
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ADR = 10;
parameter DAT = 18;
parameter DEP = 1024;
parameter TYP = "M10K";
parameter MAX = 1024;
parameter DEL = 1  ;
parameter DIS_SMALL_RAM2MLAB = 1'b0;
parameter THDEP = 512;
parameter INIT_FILE = "";


////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [ADR-1:0]     wad;
input [ADR-1:0]     rad;
input [DAT-1:0]     wda;
input               clk;
input               wen;
input               ren;
input               rst;
output [DAT-1:0]    rda;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
`include  "xil_bram_sel_nprm.vh"


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [IDAT-1:0]     wda_int,rda_int;
wire [RDAT-1:0]     wda_rem,rda_rem;

generate

if(REM1==0)
    begin : no_rem
assign              wda_int = wda[DAT-1:0];
assign              rda[DAT-1:0] = rda_int;
    end
else
    begin : has_rem
    if(INT1 > 0)
        begin : has_int
assign              {wda_rem,wda_int}  = wda[DAT-1:0];
assign              rda[DAT-1:0]       = {rda_rem,rda_int};
        end
    else
        begin : no_int
assign              wda_rem     = wda[DAT-1:0];
assign              rda[DAT-1:0]= rda_rem;
        end
    end

endgenerate

generate
if((INT1 > 0) && (SELTYP==1))
    begin : int_sel_bram
    xil_bram_sdp_1clk_depth
        #(.ADR(ADR),
          .DAT(DIV),
          .DEP(IDEP),
          .DEL(DEL),
          .MAX(IMAXDEP)
          )                 xil_bram_sdp_int[INT1-1:0]
        (
         .clk(clk),
         .rst(rst),
         .wen(wen),
         .wad({INT1{wad[ADR-1:0]}}),
         .wda(wda_int),
         .ren(ren),
         .rad({INT1{rad[ADR-1:0]}}),
         .rda(rda_int)
         
         );
    end
else if((INT1 > 0) && (SELTYP==0))
    begin : int_sel_dist
    xil_dist_sdp_1clk
        #(.ADR(ADR),
          .DAT(DIV),
          .DEP(IDEP),
          .DEL(DEL)
          )                 xil_dist_sdp_int[INT1-1:0]
        (
         .clk(clk),
         .rst(rst),
         .wen(wen),
         .wad({INT1{wad[ADR-1:0]}}),
         .wda(wda_int),
         .ren(ren),
         .rad({INT1{rad[ADR-1:0]}}),
         .rda(rda_int)
         
         );
    end
endgenerate

generate
if((REM1 > 0) && (SELTYP==1))
    begin : rem_sel_bram
    xil_bram_sdp_1clk_depth
        #(.ADR(ADR),
          .DAT(REM1),
          .DEP(IDEP),
          .DEL(DEL ),
          .MAX(IMAXDEP)
          )                 xil_bram_sdp_rem
         (
          .clk(clk),
          .rst(rst),
          .wen(wen),
          .wad(wad[ADR-1:0]),
          .wda(wda_rem),
          .ren(ren),
          .rad(rad[ADR-1:0]),
          .rda(rda_rem)
          
          );
        
    end
else if((REM1 > 0) && (SELTYP==0))
    begin : rem_sel_dist
    xil_dist_sdp_1clk
        #(.ADR(ADR),
          .DAT(REM1),
          .DEP(IDEP),
          .DEL(DEL )
          )                 xil_dist_sdp_rem
         (
          .clk(clk),
          .rst(rst),
          .wen(wen),
          .wad(wad[ADR-1:0]),
          .wda(wda_rem),
          .ren(ren),
          .rad(rad[ADR-1:0]),
          .rda(rda_rem)
          
          );
        
    end
endgenerate



endmodule 
