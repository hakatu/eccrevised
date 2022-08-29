////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ve_pcs_tx.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Mon May 19 11:43:53 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_pcs_tx
    (
     sclk125,
     rst_,

     txen,
     txerr,

     // from pcs_rx
     receiving,
     xmit,
     tx_cfdata,

     col,
     crs,
     txdi,
     txdo,

     // CPU
     sysclk,
     sysrst_,
     pact,
     pen,
     pws,
     prs,
     pdi,
     pdo,
     prdy
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               sclk125;
input               rst_;

input               txen;
input               txerr;

input               receiving;    // from rx
input [1:0]         xmit;         // from autoneg
input [15:0]        tx_cfdata;    // from rx

output              col;
output              crs;
input [7:0]         txdi;
output [9:0]        txdo;

input               sysclk;
input               sysrst_;

input               pact;
input               pen;
input               pws;
input               prs;
input [15:0]        pdi;
output [15:0]       pdo;
output              prdy;

            
////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                col;
wire [9:0]          txdo;
wire                crs;

wire [15:0]         pdo;
wire                prdy;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
// main_control
wire                pdo_mctl;
wire                fdisp;

pconfigx #(1) main_control 
    (
     .clk           (sysclk),
     .rst_          (sysrst_),
     .upen          (pen),
     .upws          (pws),
     .updi          (pdi[0]),
     .out           (fdisp),
     .updo          (pdo_mctl)
     );

// gen pdo and prdy
assign              pdo = pen? {15'h0,pdo_mctl}: 16'b0;
fflopx #(1)         pp_prdy(sysclk, sysrst_,(pws|prs)&pen,prdy);

wire                transmitting;
ippcsge_pcstx pcstx_inst
    (
     .clk           (sclk125),
     .rst_          (rst_),
     
     //disp test
     .fdisp         (fdisp),    // cpu cfg, in
     .disp          (1'b1),   
     
     //Carrier sense signals
     .receiving     (receiving),// from rx, in
     .transmitting  (transmitting),

     //Configuration signals
     .xmit          (xmit),
     .cfdata        (tx_cfdata),

     //GMII signal
     .txen          (txen),
     .txerr         (txerr),
     .col           (col),
     .di            (txdi),
     .do            (txdo)

     );

ippcsge_carr_sense carr_sense_inst
    (
     .clk           (sclk125),
     .rst_          (rst_),
     .rep_mode      (),
     .transmitting  (transmitting),//@sclk125
     .receiving     (receiving),   //@rxclk
     .crs           (crs)
     );

endmodule 