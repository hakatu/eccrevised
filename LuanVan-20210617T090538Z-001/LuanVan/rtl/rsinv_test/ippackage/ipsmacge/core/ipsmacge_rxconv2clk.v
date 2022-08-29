////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_rxconv2clk.v (.control bus width interface, between mac_process)
// Description  : .mac_interface triple speed (10/100/1000Mbps) with GMII/RGMII
//
// Author       : ndtu@SVT-NDTU
// Created On   : Mon Jun 02 11:42:35 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_rxconv2clk
    (
     rxclk,
     rxrst_,
     // rxframing
     rx_idat, 
     rx_isop,  
     rx_ieop,  
     rx_ivld,  
     rx_ierr,
     // mac interface
     maclk,
     marst_,
     ma_odat,
     ma_onob,
     ma_ovld,
     ma_osop,
     ma_oeop,
     ma_oerr,
     //
     rxrderr,
     upact
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;
parameter DAT_EW = 4;

parameter MAC_DW = 32; // Mac interface, Data input Width, width of register shift
parameter MAC_BW = 2;  // Mac interface, Number Byte Valid Width
parameter MAC_EW = 4;  // width information status
// memory
parameter RAM_DW =  MAC_DW + MAC_EW + MAC_BW + 2; //mac_dat + mac_inf + mac_nob;
////////////////////////////////////////////////////////////////////////////////
// input declarations
input               rxrst_;
input               rxclk;
// framing
input  [DAT_DW-1:0] rx_idat;
input               rx_ivld;
input               rx_isop;
input               rx_ieop;
input  [DAT_EW-1:0] rx_ierr;
// Mac interface
input               maclk;
input               marst_;
output [MAC_DW-1:0] ma_odat; 
output [MAC_BW-1:0] ma_onob;
output              ma_ovld;
output              ma_osop;
output              ma_oeop;
output [MAC_EW-1:0] ma_oerr;
// cpu interface
output              rxrderr;
input               upact;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
// shift
wire [MAC_DW-1:0]   out_dat;
wire [MAC_BW-1:0]   out_nob;
wire                out_vld;
wire                out_sop;
wire                out_eop;
wire [MAC_EW-1:0]   out_err;
//
wire [RAM_DW-1:0]   rdat;
wire                rvld;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
////////////////////////////////////////////////////

///////////////////////////////////////////////////
// number byte valid in bus
// 00: 1 byte valid
// 01: 2 byte valid
// 10: 3 byte valid
// 11: 4 byte valid
//---------------------------------------------
// Domain Line clk (rxclk)
//---------------------------------------------

//---------------------------------------------
// rx shift data
ipsmacge_rxshift  #(DAT_DW,DAT_EW,MAC_DW,MAC_BW) irxshift
    (
     .rxclk   (rxclk),
     .rxrst_  (rxrst_),
     // rxframing
     .rx_idat (rx_idat), 
     .rx_isop (rx_isop),  
     .rx_ieop (rx_ieop),  
     .rx_ivld (rx_ivld & upact),  
     .rx_ierr (rx_ierr),
     // to fifo convert
     .out_dat (out_dat),
     .out_nob (out_nob),
     .out_vld (out_vld),
     .out_sop (out_sop),
     .out_eop (out_eop),
     .out_err (out_err)
     );

// convert
ipsmacge_rx2clk #(2,2,RAM_DW) irx2clk
    (
     .wrst_ (rxrst_),
     // write
     .wclk  (rxclk), // line clk 125/25/2.5
     .wvld  (out_vld & upact),
     .wdat  ({out_nob, out_err, out_eop, out_sop, out_dat}),
     // read
     .rrst_ (marst_),
     .rclk  (maclk), // sys clk 77
     .rdat  ({ma_onob, ma_oerr, ma_oeop, ma_osop, ma_odat}),
     .rvld  (ma_ovld),
     .rerr  (rxrderr)
     );

endmodule
