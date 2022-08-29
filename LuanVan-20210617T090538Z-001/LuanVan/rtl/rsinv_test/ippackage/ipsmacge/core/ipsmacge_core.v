////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_core.v
// Description  : -> interface 1 port triple speech 10/100/1000 Mps, with rgmii/gmii/mii interface
//
// Author       : ndtu@SVT-NDTU
// Created On   : Mon Jun 23 16:30:31 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_core
    (
     rxrst_,
     txrst_,
     marst_,
     rxclk,
     txclk,
     maclk,
     // ----------- PHYS Interface -------------
     // Must connect with macro DDR
     // xxhxx transmitted level high of clock
     // xxlxx transmitted level low  of clock
     // receiver, connect (altddio_in)
     rxhdt,
     rxhdv,
     rxher,
     //
     rxldt,
     rxldv,
     rxler,
     // Transmitter,connect (altddio_out)
     txhdt,
     txhen,
     txher,
     //
     txldt,
     txlen,
     txler,
     // ----------- MAC Process Interface ------
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
     // To select clock
     oselclk,
     // pause gen
     pause_en,
     pau_iquavld,
     pau_iquadat,
     // sticky bit
     txrderr,
     txwrerr,
     txwrfull,
     txsoperr,
     txpagewrerr,

     rxrderr,
     
     lbi_fifowrerr,
     lbi_fiforderr,
     
     lbo_fifowrerr,
     lbo_fiforderr,
     // cpu read
     stacapdat,
     stamodspd,
     staselclk,
     
     // config interface
     up_txen,
     up_rxen,
     
     isouradd,
     iquanta,
     oquanta,
     //
     up_datstt,
     up_act,
     up_pos,
     up_fcsins,
     up_forcetxer,
     up_lbin,
     up_lbout,
     up_mprm_rx,
     up_mprm_tx,
     up_gmii,
     up_mspd,
     up_igap,
     up_igap_rx,
     up_autorst,
     up_wnum,
     up_txthsh,
     up_lbinffnum,
     up_lbinfffsh,
     up_lboutffnum,
     up_lboutfffsh,
     up_spdautodis,
     up_spdstable,
     up_txconvflush,
     up_paudis,
     up_paddis,
     
     // Memory interface
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
     lbo_radd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8,  // phy interface, width data
          DAT_EW = 4;  // error width

parameter MAC_DW = 32, // Mac interface, Data output Width
          MAC_EW = 4,
          MAC_BW = 2;  // Mac interface, Number Byte Valid Width
// memory
parameter RAM_TX_DW = MAC_DW + MAC_BW + 5, // ram trasmitted data width
          RAM_TX_AW = 5,  // ram trasmitted address width
          RAM_TX_LW = 32; // ram received length

parameter RAM_LB_AW = 4,
          RAM_LB_LW = 16,
          RAM_LB_DW = 10;

////////////////////////////////////////////////////////////////////////////////
// input declarations
input                  txrst_;
input                  rxrst_;
input                  marst_;
//
input                  txclk;  // Input Clock Transmit 2.5/25/125 Mhz
input                  rxclk;  // Input Clock Receive  2.5/25/125 Mhz
input                  maclk;  // Input Clock Systemk 77.76 Mhz
//----------- PHYS Interface---------
// Tx
// transmitted at high level of txclk
output [DAT_DW-1:0]    txhdt;
output                 txhen;
output                 txher;
//
// transmitted at low level of txclk
output [DAT_DW-1:0]    txldt;
output                 txlen;
output                 txler;
// Rx
// sampled at posedge of rxclk
input  [DAT_DW-1:0]    rxhdt;
input                  rxhdv; 
input                  rxher;
//sampled at negedge of rxclk
input  [DAT_DW-1:0]    rxldt;
input                  rxldv; 
input                  rxler;
//----------- MAC Interface----------
// from mac
input  [MAC_DW-1:0]    ma_idat;  
input  [MAC_BW-1:0]    ma_inob; // 00 : 1 byte valid
                                // 01 : 2 byte valid
                                // 10 : 3 byte valid
                                // 11 : 4 byte valid
input                  ma_isop;
input                  ma_ieop;
input                  ma_ival;
input [DAT_EW-2:0]     ma_ierr; // ma_ierr [2] Force FCS ERROR
                                // ma_ierr [1] INSERT TXER to PHYs
                                // ma_ierr [0] 1: Transparent (no insert FCS, PAD)
                                //             0: Normal (Insert FCS, PAD)

output                 ma_oreq; // Request data to Buffer
// to mac
output [MAC_DW-1:0]    ma_odat;
output [MAC_BW-1:0]    ma_onob; // 00 : 1 byte valid
                                // 01 : 2 byte valid
                                // 10 : 3 byte valid
                                // 11 : 4 byte valid
output                 ma_oval;
output                 ma_osop;
output                 ma_oeop;
output [MAC_EW-1:0]    ma_oerr; // ma_oerr [0] Check FCS ERROR
                                // ma_oerr [1] Check PREAMBLE ERROR
                                // ma_oerr [2] Receive RXER from PHYs
                                // ma_oerr [3] Check Inter Packet GAP ERROR
     // To select clock
output [1:0]           oselclk; // 00: txclk = phy_txclk input (only  mode MII) or refclk125
                                // 01: txclk = pin input clk 2.5
                                // 10: txclk = pll output clk 125 Mhz
                                // 11: txclk = pll output clk 25 Mhz
//----------- Pause Interface-------
// From Rx BUFFER
input                  pause_en; // 1'b0 -> 1'b1: GEN Pause Frame ON; 
                                 // 1'b1 -> 1'b0: GEN Pause Frame OFF

// From Rx Pause Frame Terminate
input                  pau_iquavld; // Receive a pause frame valid
input [15:0]           pau_iquadat; // Receive value quanta in pause frame
      
//----------- Sticky bit -------
// tx
output                 txrderr;
output                 txwrerr;
output                 txwrfull;
output                 txsoperr;
output                 txpagewrerr;

// rx
output                 rxrderr;

//
output                 lbi_fifowrerr;
output                 lbi_fiforderr;
output                 lbo_fifowrerr;
output                 lbo_fiforderr;
// cpu read
output [1:0]           stamodspd;
output [1:0]           staselclk;
output [7:0]           stacapdat;
// rx
//----------- Configuration Interface-
input                  up_txen;
input                  up_rxen;
  

input [15:0]           iquanta;
input [15:0]           oquanta;
input [47:0]           isouradd;
//
input [7:0]            up_datstt;
input                  up_act;
input                  up_pos;
input                  up_fcsins;
input                  up_forcetxer;
input                  up_lbin;
input                  up_lbout;
input                  up_gmii;
input [3:0]            up_mprm_rx;
input [3:0]            up_mprm_tx;
input [4:0]            up_igap;
input [3:0]            up_igap_rx;
input [1:0]            up_mspd;
input                  up_autorst;
input [5:0]            up_wnum;
input [3:0]            up_txthsh;
input [3:0]            up_lbinffnum;
input                  up_lbinfffsh;


input [3:0]            up_lboutffnum;
input                  up_lboutfffsh;

input                  up_spdautodis;
input                  up_spdstable;

input                  up_txconvflush;

input                  up_paudis;
input                  up_paddis;
//--------- Memory Interface-------
// Tx fifo used convert
output [RAM_TX_DW-1:0] txwdat;
output [RAM_TX_AW-1:0] txwadd;
output                 txwena;

output [RAM_TX_AW-1:0] txradd;
output                 txrena;
input  [RAM_TX_DW-1:0] txrdat;

// LB
output [RAM_LB_DW-1:0] lbi_wdat;
output [RAM_LB_AW-1:0] lbi_wadd;
output                 lbi_wena;

output [RAM_LB_AW-1:0] lbi_radd;
output                 lbi_rena;
input  [RAM_LB_DW-1:0] lbi_rdat;


output [RAM_LB_DW-1:0] lbo_wdat;
output [RAM_LB_AW-1:0] lbo_wadd;
output                 lbo_wena;

output [RAM_LB_AW-1:0] lbo_radd;
output                 lbo_rena;
input  [RAM_LB_DW-1:0] lbo_rdat;
////////////////////////////////////////////////////////////////////////////////
// signal declarations
//---------------------------------------------
// phys interface
//---------------------------------------------
wire [DAT_DW-1:0]      txdat;
wire                   txen;
wire                   txer;

wire [DAT_DW-1:0]      txhdat;
wire                   txhctl;
wire                   txherr;
wire [DAT_DW-1:0]      txldat;
wire                   txlctl;
wire                   txlerr;

wire [DAT_DW-1:0]      rxhdat;
wire                   rxhctl;
wire                   rxherr;
wire [DAT_DW-1:0]      rxldat;
wire                   rxlctl;
wire                   rxlerr;
/*
//---------------------------------------------
// Memory
//---------------------------------------------
// tx
wire [RAM_TX_DW-1:0]   txwdat;
wire [RAM_TX_AW-1:0]   txwadd;
wire                   txwena;

wire [RAM_TX_DW-1:0]   txrdat;
wire [RAM_TX_AW-1:0]   txradd;
wire                   txrena;
 */

//---------------------------------------------
// Process
//---------------------------------------------
// tx framing
wire  [DAT_DW-1:0]     tx_idat;
wire [MAC_EW-2:0]      tx_ierr;
wire                   tx_ieop;
wire                   tx_oreq;
wire                   tx_inew;
// rx framing
wire  [DAT_DW-1:0]     rx_odat;
wire                   rx_oval;
wire                   rx_osop;
wire                   rx_oeop;
wire  [DAT_EW-1:0]     rx_oerr;
wire                   rx_oistt;

// pause frame
wire                   pa_oval;
wire                   pa_ien;
wire                   pa_off;
wire                   pa_idi;
// loopback in
wire [DAT_DW-1:0]      rodat;
wire                   rodv;
wire                   roer;
wire                   roval;
//
wire [DAT_DW-1:0]      ridat;
wire                   ridv;
wire                   rier;
wire                   rival;
// loopback out
wire [DAT_DW-1:0]      todat;
wire                   toen;
wire                   toer;
wire                   toval;
// 
wire [DAT_DW-1:0]      tidat;
wire                   tien;
wire                   tier;
wire                   tival;
// sticky bit
wire                   txtimeout;
wire                   txrderr;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//---------------------------------------------
//  FPGA macro DDIO interface
//---------------------------------------------
ipsmacge_ifddioin  #(10) iifddioin
    (
     .rxrst_ (rxrst_),
     .rxclk  (rxclk),
     .idat_h ({rxher,  rxhdv,  rxhdt}),
     .idat_l ({rxler,  rxldv,  rxldt}),
     .odat_h ({rxherr, rxhctl, rxhdat}), 
     .odat_l ({rxlerr, rxlctl, rxldat})
     );
ipsmacge_ifddioout  #(10) iifddioout
    (
     .txrst_ (txrst_),
     .txclk  (txclk),
     .idat_h ({txherr, txhctl, txhdat}), 
     .idat_l ({txlerr, txlctl, txldat}),
     .odat_h ({txher , txhen , txhdt}),
     .odat_l ({txler , txlen , txldt})
     );
//---------------------------------------------
//  Interface
//---------------------------------------------
wire [1:0]             omodspd;

ipsmacge_txintf   itxintf   
    (
     .txrst_   (txrst_),
     .txclk    (txclk),
     // ddio out interface
     .txhdat   (txhdat),
     .txhctl   (txhctl),
     .txherr   (txherr),
     .txldat   (txldat),
     .txlctl   (txlctl),
     .txlerr   (txlerr),
     // loopback interface
     .igdat    (todat),
     .igval    (toval),
     .igen     (toen),
     .iger     (toer),
     // cpu interface
     .up_act   (up_act),
     .up_gmii  (up_gmii),
     .up_spd   (omodspd)
     );

ipsmacge_rxintf   irxintf
    (
     .rxrst_    (rxrst_),
     .rxclk     (rxclk),
     // ddio in interface
     .rxhdat    (rxhdat),
     .rxhctl    (rxhctl),
     .rxherr    (rxherr),
     .rxldat    (rxldat),
     .rxlctl    (rxlctl),
     .rxlerr    (rxlerr),
     // loopback interface
     .ogval     (rival),
     .ogdat     (ridat),
     .ogdv      (ridv),
     .oger      (rier),
     // cpu interface
     .up_pos    (up_pos),
     .up_act    (up_act),
     .up_gmii   (up_gmii),
     .up_mspd   (omodspd)
     );
//---------------------------------------------
//  Loopback
//---------------------------------------------
ipsmacge_loopback iloopback
    (
     .txclk  (txclk),
     .rxclk  (rxclk),
     .txrst_ (txrst_),
     .rxrst_ (rxrst_),
     // from phys
     .rx_idat (ridat),
     .rx_idv  (ridv),
     .rx_ier  (rier),
     .rx_ival (rival),
     // to rxframing
     .rx_odat (rodat),
     .rx_odv  (rodv),
     .rx_oer  (roer),
     .rx_oval (roval),
     // to phys
     .tx_idat (tidat),
     .tx_ien  (tien),
     .tx_ier  (tier),
     .tx_ival (tival), 
     // to phys
     .tx_odat (todat),
     .tx_oen  (toen),
     .tx_oer  (toer),
     .tx_oval (toval),
     // stiky
     .lbi_fifowrerr (lbi_fifowrerr),
     .lbi_fiforderr (lbi_fiforderr),
     
     .lbo_fifowrerr (lbo_fifowrerr),
     .lbo_fiforderr (lbo_fiforderr),
     //
     .uplbin        (up_lbin),
     .uplbinffnum   (up_lbinffnum),
     .uplbinfffsh   (up_lbinfffsh),
     .uplbout       (up_lbout),
     .uplboutffnum  (up_lboutffnum),
     .uplboutfffsh  (up_lboutfffsh),
     // memory
     .lbi_wdat (lbi_wdat),
     .lbi_wena (lbi_wena),
     .lbi_wadd (lbi_wadd),
     
     .lbi_rdat (lbi_rdat),
     .lbi_rena (lbi_rena),
     .lbi_radd (lbi_radd),
     
     .lbo_wdat (lbo_wdat),
     .lbo_wena (lbo_wena),
     .lbo_wadd (lbo_wadd),
     
     .lbo_rdat (lbo_rdat),
     .lbo_rena (lbo_rena),
     .lbo_radd (lbo_radd)
     );
//---------------------------------------------
//  Receiver
//---------------------------------------------
ipsmacge_rxframing irxframing
    (
     .rst_   (rxrst_),
     .rxclk  (rxclk),
     // input from Phys
     .igdat  (rodat),   // 8 bit
     .igdv   (rodv),  // also is rx_ctl
     .iger   (roer),
     .igval  (roval),
     // ouput to rxfifoconv2clk
     .odat   (rx_odat), 
     .osop   (rx_osop),  
     .oeop   (rx_oeop),  
     .oval   (rx_oval),  
     .oerr   (rx_oerr),
     // ouput to monstatus
     .oistt  (rx_oistt),
     // cpu interface
     .up_rxen (up_rxen),
     .up_act  (up_act),
     .up_thipg (up_igap_rx),
     .up_rxnumprm (up_mprm_rx)
     );

ipsmacge_rxconv2clk #(DAT_DW) irxconv2clk
    (
     .rxclk   (rxclk),
     .rxrst_  (rxrst_),
     // rxframing
     .rx_idat (rx_odat), 
     .rx_isop (rx_osop),  
     .rx_ieop (rx_oeop),  
     .rx_ivld (rx_oval),  
     .rx_ierr (rx_oerr),
     // mac interface
     .maclk   (maclk),
     .marst_  (marst_),
     .ma_odat (ma_odat),
     .ma_onob (ma_onob),
     .ma_ovld (ma_oval),
     .ma_osop (ma_osop),
     .ma_oeop (ma_oeop),
     .ma_oerr (ma_oerr),
     // configuration
     .rxrderr (rxrderr),
     .upact   (up_act)
     ); 
//---------------------------------------------
//  Transmitter
//---------------------------------------------
wire                   tx_opaudis;

wire                   ostable;
wire                   ma_ipauvld;
wire [15:0]            ma_ipauqua;

ipsmacge_txframing    itxframing
    (
     .txrst_    (txrst_),
     .txclk     (txclk),
     // from speed cotrol
     .spdstable (ostable),
     // to Phys
     .ogdat     (tidat),
     .ogen      (tien), 
     .oger      (tier),
     .ogval     (tival),
     // input from txconv2clk (Mac Process)
     .ma_idat   (tx_idat), 
     .ma_ieop   (tx_ieop),  
     .ma_ierr   (tx_ierr),
     
     .ma_oreq   (tx_oreq),
     .ma_inew   (tx_inew),
     .ma_paudis (tx_opaudis),
     //
     .oquanta   (oquanta),
     .isouradd  (isouradd),
     // input from pause frame gen
     .pa_ien    (pa_ien),
     .pa_idi    (pa_idi),
     .pa_oval   (pa_oval),
     .pa_off    (pa_off),
     // cpu interface
     .up_txen   (up_txen),
     .up_datstt (up_datstt),
     .up_act    (up_act),
     .up_fcsins (up_fcsins),
     .up_paddis (up_paddis),
     .up_paudis (up_paudis),
     .up_forcetxer (up_forcetxer),
     .up_mspd   (omodspd),
     .up_mprm   (up_mprm_tx),
     .thsh_igap (up_igap)
     );

ipsmacge_mapause ilatquata
    (
     .marst_        (marst_),
     .maclk         (maclk),
     // Pau Terminate
     .ma_ipauvld    (pau_iquavld),
     .ma_ipauqua    (pau_iquadat),

     .opauqua       (ma_ipauqua),
     .opauvld       (ma_ipauvld),

     .pwnum         (up_wnum)
     );

ipsmacge_pause  ipause  
    (
     .txrst_        (txrst_),
     .txclk         (txclk),
     // Pau Terminate
     .ma_ipauvld    (ma_ipauvld),
     .ma_ipauqua    (ma_ipauqua),
     // Pau Gen 
     .pau_ival      (pa_oval),
     
     .pau_oen       (pa_ien),
     .pau_off       (pa_off),
     .pau_trandis   (pa_idi),
     // control
     .pause_en      (pause_en),
     .iquanta       (iquanta),
     .upact         (up_act),
     .uppaudis      (up_paudis)
     );

ipsmacge_txconv2clk   itxconv2clk
    (
     .txrst_   (txrst_),
     .txclk    (txclk),
     .marst_   (marst_),
     .maclk    (maclk),
     // txframing
     .tx_ireq  (tx_oreq),
     .tx_odat  (tx_idat),
     .tx_oeop  (tx_ieop),
     .tx_oerr  (tx_ierr),
     .tx_onew  (tx_inew),
     // mac interface
     .ma_idat  (ma_idat),
     .ma_inob  (ma_inob),
     .ma_ierr  (ma_ierr),
     .ma_isop  (ma_isop),
     .ma_ieop  (ma_ieop),
     .ma_ivld  (ma_ival),
     .ma_oreq  (ma_oreq),
     // memory
     .ram_wadd (txwadd),
     .ram_wdat (txwdat),
     .ram_wena (txwena),
     
     .ram_radd (txradd),
     .ram_rdat (txrdat),
     .ram_rena (txrena),
     // sticky bit
     .rderr    (txrderr),
     .wrerr    (txwrerr),
     .wrfull   (txwrfull),
     .soperr   (txsoperr),
     .pagewrerr(txpagewrerr),
     // fifoconvert
     .uptxen   (up_txen),
     .upact    (up_act),
     .uptxthsh (up_txthsh),
     .upautorst(up_autorst),
     .upflush  (up_txconvflush)
     );
//---------------------------------------------
//  Mon status interface
//---------------------------------------------
ipsmacge_speedctrl ispeedctrl
    (
     // from rxframing
     .rxrst_    (rxrst_),
     .rxclk     (rxclk),
     .iifovld   (rx_oistt),
     .iifodat   (rx_odat),
     // from & to select clock
     .txclk     (txclk),
     .txrst_    (txrst_),
     .oselclk   (oselclk),
     // to txframing
     .ostable   (ostable),
     .omodspd   (omodspd),
     // cpu read
     .stacapdat (stacapdat),
     .stamodspd (stamodspd),
     .staselclk (staselclk),
     // cpu config
     .pautodis  (up_spdautodis),
     .pmodspd   (up_mspd),
     .pstable   (up_spdstable),
     .pmodgmii  (up_gmii)
     );


//==============================================================
//==============================================================
// FOR DEBUG
// TX GAP
`ifdef DTU_RTL_IPSMACGE
wire [1:0]  gaperr;
wire [15:0] gapcnt;

wire [18*2-1:0]    pktidcnt;
wire [14*2-1:0]    pktlencnt;


integer     logfile;

`ifdef DTU_RTL_IPSMACGE_SHOW

initial
    begin
    logfile = $fopen("DTU_RTL_IPSMACGE.log");
    end
`endif
// TX GAP
`ifdef DTU_RTL_IPSMACGE_TXSHOW
ipsmacge_cntgap #(12,8,"TXGE") tx_cntgap
    (
     .clk  (txclk),
     .rst_ (txrst_),
     .file (logfile),
     .ival (tival),
     .ien  (tien),
     .ilag (1'b1),
     .ocnt (gapcnt [7:0]),
     .opktlen (pktlencnt [1*14-1:0*14]),
     .opktid  (pktidcnt  [1*18-1:0*18]),
     .oerr (gaperr [0])
     );
`endif
// RX GAP

`ifdef DTU_RTL_IPSMACGE_RXSHOW
ipsmacge_cntgap #(12,8,"RXGE") rx_cntgap
    (
     .clk   (rxclk),
     .rst_  (rxrst_),
     .file  (logfile),
     .ival  (roval),
     .ien   (rodv),
     .ilag  (1'b0),
     .ocnt  (gapcnt [15:8]),
     .opktlen (pktlencnt [2*14-1:1*14]),
     .opktid  (pktidcnt  [2*18-1:1*18]),
     .oerr  (gaperr [1])
     );

`endif

`endif
endmodule
