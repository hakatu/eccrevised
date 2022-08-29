////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_txconv2clk.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Fri Jun 05 15:49:49 2009
// History (Date, Changed By)
// 
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_txconv2clk
    (
     txrst_,
     txclk,
     maclk,
     marst_,
     // txframing
     tx_ireq,
     tx_odat,
     tx_oeop,
     tx_oerr,
     tx_onew,
     // mac interface
     ma_idat,
     ma_inob,
     ma_ivld,
     ma_isop,
     ma_ieop,
     ma_ierr,
     ma_oreq,
     // memory
     ram_wadd,
     ram_wdat,
     ram_wena,
     
     ram_radd,
     ram_rdat,
     ram_rena,
     // sticky
     rderr,
     soperr,
     wrerr,
     wrfull,
     pagewrerr,
     // config
     uptxen, 
     upact,
     uptxthsh,
     upautorst,
     upflush
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter MAC_DW = 32, // Mac interface, Data input Width
          MAC_BW = 2;  // Mac interface, Number Byte Valid Width
parameter MAC_EW = 3;

parameter DAT_DW = 8,
          DAT_EW = 3;

parameter DAT_ER = 8'h44;
// mac process interface
parameter RAM_DW  = MAC_DW + MAC_BW + 5;
parameter RAM_AW  = 5;
parameter RAM_LW  = 32;

////////////////////////////////////////////////////////////////////////////////
// input declarations
input                   txrst_;
input                   txclk;
input                   maclk;
input                   marst_;

input                   tx_ireq;
output [DAT_DW-1:0]     tx_odat;
output                  tx_oeop;
output [DAT_EW-1:0]     tx_oerr;
output                  tx_onew;

     // mac interface
input [MAC_DW-1:0]      ma_idat;
input [MAC_BW-1:0]      ma_inob;
input                   ma_ivld;
input                   ma_isop;
input                   ma_ieop;
input [DAT_EW-1:0]      ma_ierr; // ma_ierr [2] Force FCS ERROR
                                 // ma_ierr [1] INSERT TXER to PHYs
                                 // ma_ierr [0] 1: Transparent (no insert FCS, PAD)
                                 //             0: Normal (Insert FCS, PAD)

output                  ma_oreq;
     // memory
output [RAM_AW-1:0]     ram_wadd;
output [RAM_DW-1:0]     ram_wdat;
output                  ram_wena;
                
output [RAM_AW-1:0]     ram_radd;
input  [RAM_DW-1:0]     ram_rdat;
output                  ram_rena;
     // sticky
output                  rderr;
output                  soperr;
output                  wrfull;
output                  wrerr;
output                  pagewrerr;
     // config
input                   uptxen;
input                   upact;
input [3:0]             uptxthsh;
input                   upautorst;
input                   upflush;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

/////////////////////////////////////////////////////////////////
//---------------------------------------------
// Domain maclk
//---------------------------------------------

wire                ma_ivld_1;
wire [MAC_DW-1:0]   ma_idat_1;
wire [MAC_BW-1:0]   ma_inob_1;
wire                ma_ieop_1;
wire                ma_isop_1;
wire [MAC_EW-1:0]   ma_ierr_1;

fflopx #(1)      ffmaivld (maclk, marst_, ma_ivld, ma_ivld_1);
fflopx #(MAC_DW) ffmaidat (maclk, marst_, ma_idat, ma_idat_1);
fflopx #(1)      ffmaieop (maclk, marst_, ma_ieop, ma_ieop_1);
fflopx #(1)      ffmaisop (maclk, marst_, ma_isop, ma_isop_1);
fflopx #(MAC_BW) ffmainob (maclk, marst_, ma_inob, ma_inob_1);
fflopx #(MAC_EW) ffmaierr (maclk, marst_, ma_ierr, ma_ierr_1);

wire        txautorst;
wire        maautorst;

wire        rd2werr1    , rd2werr2;
wire        rd2w2rerr1  , rd2w2rerr2;

wire        wr2rerr1    , wr2rerr2;
wire        wr2r2werr1  , wr2r2werr2;

fflopx #(2) ird2werr    (maclk, marst_, {rderr, rd2werr1}, {rd2werr1, rd2werr2});
fflopx #(2) ird2w2rerr  (txclk, txrst_, {rd2werr2, rd2w2rerr1}, {rd2w2rerr1, rd2w2rerr2});


fflopx #(2) iwr2rerr    (txclk, txrst_, {wrerr, wr2rerr1}, {wr2rerr1, wr2rerr2});
fflopx #(2) iwr2r2werr  (maclk, marst_, {wr2rerr2, wr2r2werr1}, {wr2r2werr1, wr2r2werr2});


assign      txautorst  = ((rderr    | rd2w2rerr2  | wr2rerr2) & upautorst) | (upflush | (~uptxen));
assign      maautorst  = ((rd2werr2 | wr2r2werr2  | wrerr   ) & upautorst) | (upflush | (~uptxen));
// state machine
//   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _  
// _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_ 
//           ___                 ___                        
// SOP _____|   |_______________|   |__________________________
//                       ___                         ___
// EOP _________________|   |_______________________|   |______
//                                       ___                              
// RDRR ________________________________|   |__________________
//           _______________     ___________
// IPKT  ___|               |___|           |__________________

reg         state_ipkt;
wire        wrd2pageena;
wire        wrdeop;
wire        wrdsop;

always @(posedge maclk or negedge marst_)
    begin
    if (!marst_)        state_ipkt <= 1'b0;
    else if (~upact)    state_ipkt <= 1'b0;
    else if (maautorst) state_ipkt <= 1'b0;
    else if (wrerr)     state_ipkt <= 1'b0;
    else if (wrdeop)    state_ipkt <= 1'b0;
    else if (wrdsop)    state_ipkt <= 1'b1;
    end
assign wrd2pageena  = (wrdsop | state_ipkt) & ma_ivld_1 & (~maautorst);
assign wrdeop       = ma_ivld_1 & ma_ieop_1;
assign wrdsop       = ma_ivld_1 & ma_isop_1;

wire [RAM_AW:0] rdpnt_gray;
wire [RAM_AW:0] wrpnt_gray;

wire [RAM_AW:0] wfifolen;
wire        wfifofull;

convclk_grayffwr #(RAM_AW) igrayffwr
    (
     .wrclk         (maclk),
     .wrrst_        (marst_),

     .fifowr        (wrd2pageena & upact),
     .fifoflush     (maautorst),
     .fifofull      (wfifofull),
     .half_full     (),
     .wrfifolen     (wfifolen),
     .wrpnt_gray    (wrpnt_gray),     //use to synchronize @ rdclk
     
     .write         (ram_wena),
     .wraddr        (ram_wadd),

     // Read pointer @ rdclk
     .rdpnt_gray    (rdpnt_gray)
     );

assign      ram_wdat = {ma_ierr_1,
                        ma_inob_1,
                        ma_ieop_1,
                        ma_isop_1,
                        ma_idat_1};

fflopx #(1) iflmaoreq (maclk, marst_, ((wfifolen <= {1'b0, uptxthsh}) & (uptxen & upact)), ma_oreq);

wire        werr;
assign      werr        = (wrd2pageena & wfifofull) & (~maautorst);
assign      wrfull      = wfifofull & (~maautorst);

ipsmacge_syncstress  #(7) iwrerr
    (
     .rst_  (marst_),
     .iclk  (maclk),
     .idat  (werr),
     .odat  (wrerr)
     );

//=============================================================
// Domain txclk
wire [RAM_AW:0] rfifolen;
wire            rfifonotemp;
wire            ram_rena;

convclk_grayffrd #(RAM_AW) igrayffrd
    (
     .rdclk          (txclk),
     .rdrst_         (txrst_),

     .fiford         (ram_rena),
     .fifoflush      (txautorst),
     .fifonemp       (rfifonotemp),
     .rdfifolen      (rfifolen),
     .rdpnt_gray     (rdpnt_gray),     //use to synchronize @ wrclk
     
     .rdaddr         (ram_radd),
     .read           (),

     // Write pointer @ wrclk
     .wrpnt_gray     (wrpnt_gray)
     );


//===================================

wire               pagefull;
wire [2:0]         pagelen;
wire               pagenew;

wire               rend_page;
wire               ram_rena1, ram_rena2;
reg [1:0]          rcntbyte;

fflopx #(2) iflramrena2 (txclk, txrst_, {ram_rena, ram_rena1}, {ram_rena1, ram_rena2});


wire [DAT_EW-1:0]  rerr_page;
wire [MAC_BW-1:0]  rnob_page;
wire               reop_page;
wire               rsop_page;
wire [31:0]        rdat_page;


ipsmacge_tx2clk #(2, 4, RAM_DW) ipageadap
    (
     .clk            (txclk),
     .rst_           (txrst_),
     .flush          (txautorst),
     .fiford         (rend_page),
     .fifowr         (ram_rena2),
     .fifodin        (ram_rdat),
     .fifofull       (pagefull),
     .fifolen        (pagelen),
     .notempty       (pagenew),
     .fifodout       ({rerr_page,
                       rnob_page,
                       reop_page,
                       rsop_page,
                       rdat_page
                       })
     );

assign             ram_rena = (~txautorst) & rfifonotemp & upact & ((pagelen <= 3'd1)  |
                                                                    ((pagelen == 3'd2) & (~ram_rena1)));

wire               pagewerr;
assign             pagewerr = ram_rena2 & pagefull;

wire               pagewerr1;
fflopx #(2) pageerr (txclk, txrst_, {pagewerr, (pagewerr | pagewerr1)}, {pagewerr1, pagewrerr});

//============================
// Out data
assign             rend_page    = (rcntbyte >= rnob_page) & tx_ireq & pagenew;

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        rcntbyte <= 2'd0;
    else if (~upact)    rcntbyte <= 2'd0;
    else if (txautorst) rcntbyte <= 2'd0;
    else if (rend_page) rcntbyte <= 2'd0;
    else if (tx_ireq)   rcntbyte <= rcntbyte + 1'b1;
    end

wire [DAT_DW-1:0] rd_odat;
wire [DAT_EW-1:0] rd_oerr;
wire              rd_oeop;

assign rd_odat = ((rcntbyte == 2'b00) ? rdat_page [31:24] :
                  (rcntbyte == 2'b01) ? rdat_page [23:16] :
                  (rcntbyte == 2'b10) ? rdat_page [15: 8] : rdat_page [7:0]);

assign rd_oerr = (rcntbyte >= rnob_page)  ? rerr_page : {DAT_EW{1'b0}};
assign rd_oeop = ((rcntbyte >= rnob_page) & reop_page);

// Monitor Start of packet Error
reg  portidle;
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        portidle <= 1'b0;
    else if (~upact)    portidle <= 1'b0;
    else if (rd_oeop)   portidle <= 1'b0;
    else if (tx_ireq)   portidle <= 1'b1;
    end

reg  soperr;
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        soperr <= 1'b0;
    else if (~upact)    soperr <= 1'b0;
    else if (tx_ireq)   soperr <= (~rsop_page) & (~portidle);
    end

// read_page [34] INSERT TXER to PHYs
// read_page [35] Force FCS ERROR
// read_page [36] Force PRM ERROR for frame next

reg [DAT_DW-1:0]  tx_odat;
reg [DAT_EW-1:0]  tx_oerr;
reg               tx_oeop;

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        {tx_oerr, tx_oeop, tx_odat} <= {DAT_DW+DAT_EW+1{1'b0}};
    else if (~upact)    {tx_oerr, tx_oeop, tx_odat} <= {DAT_DW+DAT_EW+1{1'b0}};
    else if (~uptxen)   {tx_oerr, tx_oeop, tx_odat} <= {DAT_DW+DAT_EW+1{1'b0}};
    else if (tx_ireq)   {tx_oerr, tx_oeop, tx_odat} <= pagenew ? {rd_oerr, rd_oeop, rd_odat} : 
                                                       {3'b010, 1'b1, DAT_ER};
    else                {tx_oerr, tx_oeop, tx_odat} <= {DAT_DW+DAT_EW+1{1'b0}};
    end

assign            tx_onew = pagenew;

wire              rerr;
assign            rerr = tx_ireq & (~pagenew);

ipsmacge_syncstress  #(3) irderr
    (
     .rst_  (txrst_),
     .iclk  (txclk),
     .idat  (rerr),
     .odat  (rderr)
     );

endmodule

