////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_loopback.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Sat Jun 21 13:59:00 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_loopback
    (
     txclk,
     rxclk,
     txrst_,
     rxrst_,
     // from phys
     rx_idat,
     rx_idv,
     rx_ier,
     rx_ival,
     // to rxframing
     rx_odat,
     rx_odv,
     rx_oer,
     rx_oval,
     // to phys
     tx_idat,
     tx_ien,
     tx_ier,
     tx_ival,
     // to phys
     tx_odat,
     tx_oen,
     tx_oer,
     tx_oval,
     // sticky
     lbi_fifowrerr,
     lbi_fiforderr,
     
     lbo_fifowrerr,
     lbo_fiforderr,
     //
     uplbin,
     uplbinffnum,
     uplbinfffsh,
     uplbout,
     uplboutffnum,
     uplboutfffsh,
     // Memory
     lbi_wdat,
     lbi_wena,
     lbi_wadd,
     lbi_rdat,
     lbi_rena,
     lbi_radd,
     
     lbo_wdat,
     lbo_wena,
     lbo_wadd,
     lbo_rdat,
     lbo_rena,
     lbo_radd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;

parameter LBX_AW = 4;
parameter LBX_LW = 16;
parameter LBX_DW = 10;

////////////////////////////////////////////////////////////////////////////////
// input declarations
input                rxclk;
input                rxrst_;
// received
input   [DAT_DW-1:0] rx_idat;
input                rx_idv;
input                rx_ier;
input                rx_ival;
// out
output  [DAT_DW-1:0] rx_odat;
output               rx_odv;
output               rx_oer;
output               rx_oval;
// transmit
input                txclk;
input                txrst_;

input   [DAT_DW-1:0] tx_idat;
input                tx_ien;
input                tx_ier;
input                tx_ival;
// out
output  [DAT_DW-1:0] tx_odat;
output               tx_oen;
output               tx_oer;
output               tx_oval;
//
input                uplbin;
input  [3:0]         uplbinffnum;
input                uplbinfffsh;
//
input                uplbout;
input  [3:0]         uplboutffnum;
input                uplboutfffsh;
// Memory
input  [LBX_DW-1:0]  lbi_rdat;
output               lbi_rena;
output [LBX_AW-1:0]  lbi_radd;

output [LBX_DW-1:0]  lbi_wdat;
output               lbi_wena;
output [LBX_AW-1:0]  lbi_wadd;


input  [LBX_DW-1:0]  lbo_rdat;
output               lbo_rena;
output [LBX_AW-1:0]  lbo_radd; 

output [LBX_DW-1:0]  lbo_wdat;
output               lbo_wena;
output [LBX_AW-1:0]  lbo_wadd;
// stiky
output               lbi_fifowrerr;
output               lbi_fiforderr;

output               lbo_fifowrerr;
output               lbo_fiforderr;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
wire                 lbi_wrerr;
wire                 lbi_rderr;
 
wire                 lbo_wrerr;
wire                 lbo_rderr;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
// =============================================================
// &&&&&&&&&&&&&&&&& LoopBack In &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  *************************************
ipsmacge_lbin #(LBX_AW, LBX_LW) ipsmacge_lbin 
    (
     //-- RX--
     .rxrst_  (rxrst_),
     .rxclk   (rxclk),
     // RX IN
     .rx_idat (rx_idat),
     .rx_idv  (rx_idv),
     .rx_ier  (rx_ier),
     .rx_ival (rx_ival),
     // RX OUT
     .rx_odat (rx_odat),
     .rx_odv  (rx_odv),
     .rx_oer  (rx_oer),
     .rx_oval (rx_oval),
     //-- TX--
     .txclk   (txclk),
     .txrst_  (txrst_),
     // TX IN
     .tx_idat (tx_idat),
     .tx_ien  (tx_ien),
     .tx_ier  (tx_ier),
     .tx_ival (tx_ival), 
     // sticky
     .lbin_fifowrerr (lbi_wrerr),
     .lbin_fiforderr (lbi_rderr),
     //-- Config--
     .uplbin     (uplbin),
     .upfifofsh  (uplbinfffsh),
     .uplbffnum  (uplbinffnum),
     //
     .lbin_wdat (lbi_wdat),
     .lbin_wena (lbi_wena),
     .lbin_wadd (lbi_wadd),
     
     .lbin_rdat (lbi_rdat),
     .lbin_rena (lbi_rena),
     .lbin_radd (lbi_radd)
     );

ipsmacge_syncstress   #(1) sticky_ffwerr_lbin
    (
     .rst_ (txrst_),
     .iclk (txclk),
     .idat (lbi_wrerr),
     .odat (lbi_fifowrerr)
     );

ipsmacge_syncstress   #(1) sticky_ffrerr_lbin
    (
     .rst_ (rxrst_),
     .iclk (rxclk),
     .idat (lbi_rderr),
     .odat (lbi_fiforderr)
     );
// =============================================================
// &&&&&&&&&&&&&&&&& LoopBack Out &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  *************************************
ipsmacge_lbin #(LBX_AW, LBX_LW) ipsmacge_lbout 
    (
     //-- RX--
     .rxrst_  (txrst_),
     .rxclk   (txclk),
     // RX IN
     .rx_idat (tx_idat),
     .rx_idv  (tx_ien),
     .rx_ier  (tx_ier),
     .rx_ival (tx_ival),
     // RX OUT
     .rx_odat (tx_odat),
     .rx_odv  (tx_oen),
     .rx_oer  (tx_oer),
     .rx_oval (tx_oval),
     //-- TX--
     .txclk   (rxclk),
     .txrst_  (rxrst_),
     // TX IN
     .tx_idat (rx_idat),
     .tx_ien  (rx_idv),
     .tx_ier  (rx_ier),
     .tx_ival (rx_ival), 
     // sticky
     .lbin_fifowrerr (lbo_wrerr),
     .lbin_fiforderr (lbo_rderr),
     //-- Config--
     .uplbin     (uplbout),
     .upfifofsh  (uplboutfffsh),
     .uplbffnum  (uplboutffnum),
     //
     .lbin_wdat (lbo_wdat),
     .lbin_wena (lbo_wena),
     .lbin_wadd (lbo_wadd),
     
     .lbin_rdat (lbo_rdat),
     .lbin_rena (lbo_rena),
     .lbin_radd (lbo_radd)
     );

ipsmacge_syncstress   #(1) sticky_ffwerr_lbout
    (
     .rst_ (rxrst_),
     .iclk (rxclk),
     .idat (lbo_wrerr),
     .odat (lbo_fifowrerr)
     );

ipsmacge_syncstress   #(1) sticky_ffrerr_lbout
    (
     .rst_ (txrst_),
     .iclk (txclk),
     .idat (lbo_rderr),
     .odat (lbo_fiforderr)
     );
endmodule
