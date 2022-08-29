////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_tdp_1clk_wrap.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon Jul 06 10:51:24 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_tdp_1clk_wrap
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
parameter TYP = "M10K";
parameter MAX = 1024;
parameter DEL = 1  ;
parameter DIS_SMALL_RAM2MLAB = 1'b0;
parameter THDEP = 512;
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
`include  "xil_bram_sel_nprm.vh"


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [IDAT-1:0]     wdaa_int,rdaa_int;
wire [RDAT-1:0]     wdaa_rem,rdaa_rem;

wire [IDAT-1:0]     wdab_int,rdab_int;
wire [RDAT-1:0]     wdab_rem,rdab_rem;

generate
if(REM1==0)
    begin : no_rem
assign              wdaa_int = wdaa[DAT-1:0];
assign              rdaa[DAT-1:0] = rdaa_int;

assign              wdab_int = wdab[DAT-1:0];
assign              rdab[DAT-1:0] = rdab_int;
    end
else
    begin : has_rem
    if(INT1 > 0)
        begin : has_int
assign              {wdaa_rem,wdaa_int}  = wdaa[DAT-1:0];
assign              rdaa[DAT-1:0]        = {rdaa_rem,rdaa_int};

assign              {wdab_rem,wdab_int}  = wdab[DAT-1:0];
assign              rdab[DAT-1:0]        = {rdab_rem,rdab_int};
        end
    else
        begin : no_int
assign              wdaa_rem        = wdaa[DAT-1:0];
assign              rdaa[DAT-1:0]   = rdaa_rem;

assign              wdab_rem        = wdab[DAT-1:0];
assign              rdab[DAT-1:0]   = rdab_rem;
        end
    end
endgenerate

generate
if(INT1 > 0)
    begin : int_ram
xil_bram_tdp_1clk_depth
    #(.ADR(ADR),
      .DAT(DIV),
      .DEP(IDEP),
      .DEL(DEL),
      .MAX(IMAXDEP)
      )                 xil_bram_tdp_int[INT1-1:0]
    (
     .clka(clka),
     .rsta(rsta),
     .adra({INT1{adra[ADR-1:0]}}),
     .wena(wena),
     .wdaa(wdaa_int),
     .rena(rena|wena),
     .rdaa(rdaa_int),
     
     .rstb(rstb),
     .adrb({INT1{adrb[ADR-1:0]}}),
     .wenb(wenb),
     .wdab(wdab_int),
     .renb(renb|wenb),
     .rdab(rdab_int)
     
     );
    end
endgenerate

generate
if(REM1 > 0)
    begin : rem_ram
xil_bram_tdp_1clk_depth
    #(.ADR(ADR),
      .DAT(REM1),
      .DEP(IDEP ),
      .DEL(DEL ),
      .MAX(IMAXDEP)
      )                 xil_bram_tdp_rem
    (
     .clka(clka),
     .rsta(rsta),
     .adra(adra[ADR-1:0]),
     .wena(wena),
     .wdaa(wdaa_rem),
     .rena(rena|wena),
     .rdaa(rdaa_rem),
     
     .rstb(rstb),
     .adrb(adrb[ADR-1:0]),
     .wenb(wenb),
     .wdab(wdab_rem),
     .renb(renb|wenb),
     .rdab(rdab_rem)
     
     );

    end
endgenerate





endmodule 
