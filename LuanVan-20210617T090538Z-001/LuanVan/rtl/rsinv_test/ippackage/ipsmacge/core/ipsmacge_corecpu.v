////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_corecpu.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Mon Apr 13 09:23:40 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

//`define IPSMACGE_MEMIF

module ipsmacge_corecpu
    (
     rxrst_,
     txrst_,
     marst_,
     rxclk,
     txclk,
     maclk,
     // PHYS Interface
     rxhdat,
     rxhdv,
     rxher,
     rxldat,
     rxldv,
     rxler,
     
     txhdat,
     txhen,
     txher,
     txldat,
     txlen,
     txler,
     // MAC Process Interface 
     // to mac
     ma_odat,
     ma_osop,
     ma_oeop,
     ma_oerr,
     ma_oval,
     ma_onob,
     // from mac
     ma_idat,
     ma_isop,
     ma_ieop,
     ma_ival,
     ma_inob,
     ma_ierr,
     ma_oreq, // request to Buffer
     // to selclk
     oselclk,
     // pause gen
     pa_genen,
     pa_iquavld,
     pa_iqua,
     pa_sa,
     // Memory IF
     `ifdef IPSMACGE_MEMIF
     // txfifo 4x16x39
     txwena,
     txwadd,
     txwdat,
     
     txradd,
     txrdat,
     txrena,
     // Memory 4x16x10
     lbi_wdat,
     lbi_wena,
     lbi_wadd,
     
     lbi_rdat,
     lbi_rena,
     lbi_radd,
     //
     lbo_wdat,
     lbo_wena,
     lbo_wadd, 
 
     lbo_rdat,
     lbo_rena,
     lbo_radd,
     `endif
     // CPU interface
     upact,
     upen,
     uprs,
     upws,
     upa,
     updi,
     updo,
     uprdy,
     upint
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter CPU_AW = 3;
parameter CPU_DW = 16;

parameter   RST_CTRL_0 = {4'b1100, 4'd12, 4'b1100, 4'b1111};
parameter   CTRL_0_W = 16;

parameter   RST_CTRL_1 = {6'd0, 2'd2, 2'd2, 2'b11};
parameter   CTRL_1_W = 12;

parameter   RST_CTRL_2 = {4'd7, 4'd7, 3'b0, 5'd12};
parameter   CTRL_2_W = 16;

parameter   RST_CTRL_3 = {4'd0, 4'd4, 4'd4, 2'b00, 2'b00};
parameter   CTRL_3_W   = 16;

parameter   RST_CTRL_4 = 16'h03FF;
parameter   CTRL_4_W = 16;

parameter   RST_CTRL_5 = 16'h07FF;
parameter   CTRL_5_W = 16;

parameter   RST_CTRL_6 = 8'hDD;
parameter   CTRL_6_W = 8;

parameter   STKY_7_W = 16;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input           rxrst_;
input           txrst_;
input           marst_;
input           rxclk;
input           txclk;
input           maclk;

//----------- PHYS Interface---------
// Tx
// transmitted at high level of txclk
output [7:0]    txhdat;
output          txhen;
output          txher;
//
// transmitted at low level of txclk
output [7:0]    txldat;
output          txlen;
output          txler;
// Rx
// sampled at posedge of rxclk
input [7:0]     rxhdat;
input           rxhdv; 
input           rxher;
//sampled at negedge of rxclk
input [7:0]     rxldat;
input           rxldv; 
input           rxler;

// Mac interface
input [31:0]    ma_idat; // User Interface
input [1:0]     ma_inob; // User Interface
input           ma_isop; // User Interface
input           ma_ieop; // User Interface
input [2:0]     ma_ierr; // User Interface
input           ma_ival; // User Interface
output          ma_oreq; // User Interface

output [31:0]   ma_odat; // User Interface
output [1:0]    ma_onob; // User Interface
output          ma_oeop; // User Interface
output          ma_osop; // User Interface
output          ma_oval; // User Interface
output [3:0]    ma_oerr; // User Interface

// Pause Select clock
output [1:0]    oselclk;
// Pause interface
input           pa_genen; // User Interface,1'b0-1'b1: Started gen Pause Frame ON 
                          // 1'b1 -> 1'b0: Gen pause Frame OFF   
                          // Engine will counter, if counter = iquanta, will gen 1
                          // pause Frame ON, and continous reset counter and counter
                          //    
                          //               _______________//____________
                          //   _____//____|                             |_______//____
                          //   
                          //   ___________<PAU ON>___//___<PAU ON>___<PAU OFF>________
                          // 
                          //    __________| value iquante    |
                          // 
                          //    ___________________________<Sample>___________________

input           pa_iquavld;
input [15:0]    pa_iqua;

input [47:0]    pa_sa;

`ifdef IPSMACGE_MEMIF

//--------- Memory Interface-------
// Tx fifo used convert
output [38:0]   txwdat;
output [4:0]    txwadd;
output          txwena;

output [4:0]    txradd;
output          txrena;
input [38:0]    txrdat;

// LB
output [9:0]    lbi_wdat;
output [3:0]    lbi_wadd;
output          lbi_wena;

output [3:0]    lbi_radd;
output          lbi_rena;
input [9:0]     lbi_rdat;


output [9:0]    lbo_wdat;
output [3:0]    lbo_wadd;
output          lbo_wena;

output [3:0]    lbo_radd;
output          lbo_rena;
input [9:0]     lbo_rdat;

`endif

// CPU interface
input           upen;
input           upact;
input           uprs;
input           upws;

input [CPU_AW-1:0] upa;
input [CPU_DW-1:0] updi;
output [CPU_DW-1:0] updo;
output              uprdy;
output              upint;
////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
   
////////////////////////////////////////////////////////////////////////////////
// IPSMAC_CORE

// sicky, had been stress for maclk sample

wire        txrderr;
wire        txwrerr;
wire        txwrfull;
wire        txsoperr;
wire        txpagewrerr;

wire        rxrderr;

wire        lbi_fifowrerr;
wire        lbi_fiforderr;

wire        lbo_fifowrerr;
wire        lbo_fiforderr;

wire [1:0]  stamodspd;
wire [7:0]  stacapdat;
wire [1:0]  staselclk;

// cpu config
wire        up_pen;       // 1'b1: Active, else not active  
wire        up_txen;
wire        up_rxen;
wire        up_inten;

wire [15:0] up_iquanta;   // For Pause Frame, is value quanta for engine sample
wire [15:0] up_oquanta;   // For Pause Frame, is value quanta in frame
//
wire [7:0]  up_datstt;    // data satetus need transmitted in bytes GAP
wire        up_pos;       // Only Mode GMII/ MII, 1'b1 -> sample data at posedge of clock, 
                          // Only Mode GMII/ MII, 1'b0 -> sample data at negedge of clock,
wire        up_fcsins;    // 1'b1-> Enable FCS bytes Insert, else -> disable FCS byts insert
wire        up_forcetxer; // 1'b1-> Forc TXER is 1'b1, else is normal mode
wire        up_lbin;     // 1'b1: Loop back TX => RX, else not Loop back is normal mode
wire        up_lbout;    // 1'b1: Loop back RX => TX, else not Loop back is normal mode
wire [4:0]  up_igap;     // Number of bytes gap is transmitted, 4'b5-> 5 bytes gap, 4'd12: 12 bytes gap
wire [3:0]  up_igap_rx;  // Number of bytes gap is anlalyzer, 4'd0: 0 bytes gap

wire        up_autorst; // 1'b1 -> Time out will reset all sigal in convert maclk -> txclk

wire        up_gmii;    // 1'b0->RGMII 10/100/1000, 1'b1-> GMII(1000Mbps)/MII(10/100Mbps)
wire [1:0]  up_mspd;    // 2'b00->10Mbps, 2'b01->100 Mbps, 2'b1x->1000 Mbps
wire [3:0]  up_mprm_rx; // detect n bytes preamle, 0->Insert only byte sfd (8'hd5)
wire [3:0]  up_mprm_tx; // insert n bytes preamle, 0->Insert only byte sfd (8'hd5)
wire [5:0]  up_wnum;    // 6d'32->txclk 2.5 Mhz, 5'd4->txclk 25 Mhz, 5'd0->txclk 125 Mhz 
wire [3:0]  up_txthsh;  // SHOULD: 4'd4 - 4'd5

wire [3:0]  up_lbinffnum;
wire        up_lbinfffsh;
wire [3:0]  up_lboutffnum;
wire        up_lboutfffsh;

wire        up_spdautodis;
wire        up_spdstable;

wire        up_txconvflush;

wire        up_paudis;
wire        up_paddis;

wire [1:0]  up_selclk;
//
wire [1:0]  eselclk;
assign      oselclk = up_spdautodis ? up_selclk : eselclk;

// Memory
wire [4:0]  txwadd;
wire [38:0] txwdat;
wire        txwena;

wire [4:0]  txradd;
wire [38:0] txrdat;
wire        txrena;

wire [3:0]  lbi_wadd;
wire [9:0]  lbi_wdat;
wire        lbi_wena;

wire [3:0]  lbi_radd;
wire [9:0]  lbi_rdat;
wire        lbi_rena;

wire [3:0]  lbo_wadd;
wire [9:0]  lbo_wdat;
wire        lbo_wena;

wire [3:0]  lbo_radd;
wire [9:0]  lbo_rdat;
wire        lbo_rena;

//-------------------------------------------
// Core
//-------------------------------------------
ipsmacge_core   icore
    (
     .txrst_        (txrst_),
     .rxrst_        (rxrst_),
     .marst_        (marst_),
     .rxclk         (rxclk),
     .txclk         (txclk),
     .maclk         (maclk),
     // ----------- PHYS Interface -------------
     // Must connect with macro DDR
     // xxhxx transmitted level high of clock
     // xxlxx transmitted level low  of clock
     // receiver, connect   (altddio_in)
     .rxhdt         (rxhdat),
     .rxhdv         (rxhdv),
     .rxher         (rxher),
     //
     .rxldt         (rxldat),
     .rxldv         (rxldv),
     .rxler         (rxler),
     // Transmitter,connect (altddio_out)
     .txhdt         (txhdat),
     .txhen         (txhen),
     .txher         (txher),
     //
     .txldt         (txldat),
     .txlen         (txlen),
     .txler         (txler),
     // ----------- MAC Process Interface ------
     // to mac
     .ma_odat       (ma_odat),
     .ma_osop       (ma_osop),
     .ma_oeop       (ma_oeop),
     .ma_oerr       (ma_oerr),
     .ma_oval       (ma_oval),
     .ma_onob       (ma_onob),
     // from mac
     .ma_idat       (ma_idat),
     .ma_isop       (ma_isop),
     .ma_ieop       (ma_ieop),
     .ma_ival       (ma_ival),
     .ma_inob       (ma_inob),
     .ma_ierr       (ma_ierr),
     .ma_oreq       (ma_oreq), // request to Buffer
     // to select clock
     .oselclk       (eselclk),
     // pause gen
     .pause_en      (pa_genen),
     .pau_iquavld   (pa_iquavld),
     .pau_iquadat   (pa_iqua),
     .isouradd      (pa_sa),
     // sticky bit
     .txrderr       (txrderr),
     .txwrerr       (txwrerr),
     .txwrfull      (txwrfull),
     .txsoperr      (txsoperr),
     .txpagewrerr   (txpagewrerr),

     .rxrderr       (rxrderr),
     //
     .lbi_fifowrerr (lbi_fifowrerr),
     .lbi_fiforderr (lbi_fiforderr),
     
     .lbo_fifowrerr (lbo_fifowrerr),
     .lbo_fiforderr (lbo_fiforderr),
     // sta
     .stacapdat     (stacapdat),
     .stamodspd     (stamodspd),
     .staselclk     (staselclk),
     
     // config interface
     .up_txen       (up_txen & up_pen),
     .up_rxen       (up_rxen & up_pen),
     .iquanta       (up_iquanta),
     .oquanta       (up_oquanta),
     //
     .up_datstt     (up_datstt),
     .up_act        (upact),
     .up_pos        (up_pos),
     .up_fcsins     (up_fcsins),
     .up_forcetxer  (up_forcetxer),
     .up_lbin       (up_lbin),
     .up_lbout      (up_lbout),
     .up_mprm_rx    (up_mprm_rx),
     .up_mprm_tx    (up_mprm_tx),
     .up_gmii       (up_gmii),
     .up_mspd       (up_mspd),
     .up_igap       (up_igap),
     .up_igap_rx    (up_igap_rx),
     .up_autorst    (up_autorst),
     .up_wnum       (up_wnum),
     .up_txthsh     (up_txthsh),
                     
     .up_lbinffnum  (up_lbinffnum),
     .up_lbinfffsh  (up_lbinfffsh),
     .up_lboutffnum (up_lboutffnum),
     .up_lboutfffsh (up_lboutfffsh),
     
     .up_spdautodis (up_spdautodis),
     .up_spdstable  (up_spdstable),
     .up_txconvflush(up_txconvflush),
     .up_paudis     (up_paudis),
     .up_paddis     (up_paddis),
     
     // Memory interface
     // tx fifo two clock
     .txwena        (txwena),
     .txwadd        (txwadd),
     .txwdat        (txwdat),
     
     .txradd        (txradd),
     .txrdat        (txrdat),
     .txrena        (txrena),
     //
     .lbi_wdat      (lbi_wdat),
     .lbi_wena      (lbi_wena),
     .lbi_wadd      (lbi_wadd),
     
     .lbi_rdat      (lbi_rdat),
     .lbi_rena      (lbi_rena),
     .lbi_radd      (lbi_radd),
     //
     .lbo_wdat      (lbo_wdat),
     .lbo_wena      (lbo_wena),
     .lbo_wadd      (lbo_wadd),
     
     .lbo_rdat      (lbo_rdat),
     .lbo_rena      (lbo_rena),
     .lbo_radd      (lbo_radd)
     );

`ifdef IPSMACGE_MEMIF
`else
//-------------------------------------------
// Memory
//-------------------------------------------
iarray112x #(5, 32, 39, "MLAB") iramtxctrlfifo
    (  
     .test  (1'b0),
     .mask  (1'b0),
     .wrst_ (marst_),
     .wclk  (maclk),
     .wa    (txwadd),
     .we    (txwena),
     .di    (txwdat),
     .rclk  (txclk),
     .rrst_ (txrst_),
     .re    (txrena),
     .ra    (txradd),
     .do    (txrdat)
     );
// Lbin
iarray112x #(4, 16, 10, "MLAB") iramlbin
    (  
     .test  (1'b0),
     .mask  (1'b0),
     .wrst_ (txrst_),
     .wclk  (txclk),
     .wa    (lbi_wadd),
     .we    (lbi_wena),
     .di    (lbi_wdat),
     .rclk  (rxclk),
     .rrst_ (rxrst_),
     .re    (lbi_rena),
     .ra    (lbi_radd),
     .do    (lbi_rdat)
     );

iarray112x #(4, 16, 10, "MLAB") iramlbout
    (  
     .test  (1'b0),
     .mask  (1'b0),
     .wrst_ (rxrst_),
     .wclk  (rxclk),
     .wa    (lbo_wadd),
     .we    (lbo_wena),
     .di    (lbo_wdat),
     .rclk  (txclk),
     .rrst_ (txrst_),
     .re    (lbo_rena),
     .ra    (lbo_radd),
     .do    (lbo_rdat)
     );

`endif
//-------------------------------------------
// CPU Interface
//-------------------------------------------

wire [15:0] pdo_ctrl_0;
wire [15:0] pdo_ctrl_1;
wire [15:0] pdo_ctrl_2;
wire [15:0] pdo_ctrl_3;
wire [15:0] pdo_ctrl_4;
wire [15:0] pdo_ctrl_5;
wire [15:0] pdo_ctrl_6;
wire [15:0] pdo_stky_7;

wire        psel_ctrl_0;
wire        psel_ctrl_1;
wire        psel_ctrl_2;
wire        psel_ctrl_3;
wire        psel_ctrl_4;
wire        psel_ctrl_5;
wire        psel_ctrl_6;
wire        psel_stky_7;

wire [CTRL_0_W-1:0] out_ctrl_0;
wire [CTRL_1_W-1:0] out_ctrl_1;
wire [CTRL_2_W-1:0] out_ctrl_2;
wire [CTRL_3_W-1:0] out_ctrl_3;
wire [CTRL_4_W-1:0] out_ctrl_4;
wire [CTRL_5_W-1:0] out_ctrl_5;
wire [CTRL_6_W-1:0] out_ctrl_6;
wire [STKY_7_W-1:0] out_stky_7;

// REG control 0
    
assign      up_pen          = out_ctrl_0 [0];
assign      up_txen         = out_ctrl_0 [1];
assign      up_rxen         = out_ctrl_0 [2];
assign      up_inten        = out_ctrl_0 [3];

assign      up_paudis       = out_ctrl_0 [4];
assign      up_paddis       = out_ctrl_0 [5];
assign      up_pos          = out_ctrl_0 [6];
assign      up_fcsins       = out_ctrl_0 [7];

assign      up_txthsh       = out_ctrl_0 [11:8];

assign      up_txconvflush  = out_ctrl_0 [12];
assign      up_forcetxer    = out_ctrl_0 [13];
assign      up_autorst      = out_ctrl_0 [14];
assign      up_spdstable    = out_ctrl_0 [15];

// REG control 1
assign      up_spdautodis   = out_ctrl_1 [0];
assign      up_gmii         = out_ctrl_1 [1];
assign      up_mspd         = out_ctrl_1 [3:2];
assign      up_selclk       = out_ctrl_1 [5:4];
assign      up_wnum         = out_ctrl_1 [11:6];

assign      pdo_ctrl_1 [15:14]  = psel_ctrl_1 ? staselclk [1:0] : 2'b00;
assign      pdo_ctrl_1 [13:12]  = psel_ctrl_1 ? stamodspd [1:0] : 2'b00;

// REG control 2

assign      up_igap         = out_ctrl_2 [4:0];
assign      up_mprm_rx      = out_ctrl_2 [11:8];
assign      up_mprm_tx      = out_ctrl_2 [15:12];

// REG control 3

assign      up_lbin         = out_ctrl_3 [0];
assign      up_lbinfffsh    = out_ctrl_3 [1];
assign      up_lbout        = out_ctrl_3 [2];
assign      up_lboutfffsh   = out_ctrl_3 [3];

assign      up_lbinffnum    = out_ctrl_3 [7:4];
assign      up_lboutffnum   = out_ctrl_3 [11:8];

assign      up_igap_rx      = out_ctrl_3 [15:12];

// REG control 4

assign      up_iquanta = out_ctrl_4 [15:0];

// REG control 5
assign      up_oquanta = out_ctrl_5 [15:0];

// REG control 6

assign      up_datstt  = out_ctrl_6 [7:0];

assign      pdo_ctrl_6 [15:8] = psel_ctrl_6 ? stacapdat [7:0] : 8'h0;


// STK 7

//====================================================
// Decode ADDRESS

assign psel_ctrl_0     = upen & (upa [2:0] == 3'd0);
assign psel_ctrl_1     = upen & (upa [2:0] == 3'd1);
assign psel_ctrl_2     = upen & (upa [2:0] == 3'd2);
assign psel_ctrl_3     = upen & (upa [2:0] == 3'd3);
assign psel_ctrl_4     = upen & (upa [2:0] == 3'd4);
assign psel_ctrl_5     = upen & (upa [2:0] == 3'd5);
assign psel_ctrl_6     = upen & (upa [2:0] == 3'd6);
assign psel_stky_7     = upen & (upa [2:0] == 3'd7);
//====================================================
pconfigx #(CTRL_0_W, RST_CTRL_0) pconf_ctrl_0
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_0),
     .upws (upws),
     .updi (updi [CTRL_0_W-1:0]),
     .out  (out_ctrl_0 [CTRL_0_W-1:0]),
     .updo (pdo_ctrl_0 [CTRL_0_W-1:0])
     );

pconfigx #(CTRL_1_W, RST_CTRL_1) pconf_ctrl_1
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_1),
     .upws (upws),
     .updi (updi [CTRL_1_W-1:0]),
     .out  (out_ctrl_1 [CTRL_1_W-1:0]),
     .updo (pdo_ctrl_1 [CTRL_1_W-1:0])
     );

pconfigx #(CTRL_2_W, RST_CTRL_2) pconf_ctrl_2
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_2),
     .upws (upws),
     .updi (updi [CTRL_2_W-1:0]),
     .out  (out_ctrl_2 [CTRL_2_W-1:0]),
     .updo (pdo_ctrl_2 [CTRL_2_W-1:0])
     );

pconfigx #(CTRL_3_W, RST_CTRL_3) pconf_ctrl_3
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_3),
     .upws (upws),
     .updi (updi [CTRL_3_W-1:0]),
     .out  (out_ctrl_3 [CTRL_3_W-1:0]),
     .updo (pdo_ctrl_3 [CTRL_3_W-1:0])
     );

pconfigx #(CTRL_4_W, RST_CTRL_4) pconf_ctrl_4
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_4),
     .upws (upws),
     .updi (updi [CTRL_4_W-1:0]),
     .out  (out_ctrl_4 [CTRL_4_W-1:0]),
     .updo (pdo_ctrl_4 [CTRL_4_W-1:0])
     );

pconfigx #(CTRL_5_W, RST_CTRL_5) pconf_ctrl_5
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_5),
     .upws (upws),
     .updi (updi [CTRL_5_W-1:0]),
     .out  (out_ctrl_5 [CTRL_5_W-1:0]),
     .updo (pdo_ctrl_5 [CTRL_5_W-1:0])
     );

pconfigx #(CTRL_6_W, RST_CTRL_6) pconf_ctrl_6
    (
     .clk  (maclk),
     .rst_ (marst_),
     .upen (psel_ctrl_6),
     .upws (upws),
     .updi (updi [CTRL_6_W-1:0]),
     .out  (out_ctrl_6 [CTRL_6_W-1:0]),
     .updo (pdo_ctrl_6 [CTRL_6_W-1:0])
     );
//
stickyx #(STKY_7_W) stky_7
    (
     .clk       (maclk),
     .rst_      (marst_),
     .upactive  (upact),
     .alarm     ({4'd0, lbi_fifowrerr, lbi_fiforderr, lbo_fifowrerr, lbo_fiforderr,
                  rxrderr, 2'b0, txpagewrerr, txsoperr, txwrfull, txwrerr, txrderr}),
     .upen      (psel_stky_7),
     .upws      (upws),
     .updi      (updi[STKY_7_W-1:0]),
     .updo      (pdo_stky_7 [STKY_7_W-1:0]),
     .lalarm    (out_stky_7 [STKY_7_W-1:0])
     );


//======================================================================
assign upint = up_inten & (|out_stky_7 [STKY_7_W-1:0]);


fflopx #(1) ffrdy (maclk, marst_, (uprs | upws) & upen, uprdy);

assign      updo = pdo_ctrl_0 |
                   pdo_ctrl_1 |
                   pdo_ctrl_2 |
                   pdo_ctrl_3 |
                   pdo_ctrl_4 |
                   pdo_ctrl_5 |
                   pdo_ctrl_6 |
                   pdo_stky_7
                   ;

endmodule 
