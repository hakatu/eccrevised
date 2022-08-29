////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ve_pcs_rx.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Mon May 19 11:44:08 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_pcs_rx
    (
     rxclk,
     rst_,

     rxdi,
     rxdo,
     rxdvl,
     rxerr,

     // to pcs_tx
     receiving,
     tx_cfdata,
     xmit,

     // Link status
     linkdown,
     
     // CPU
     pact,
     pen,
     prs,
     pws,
     pa,
     pdi,
     pdo,
     prdy
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               rxclk;
input               rst_;

input [9:0]         rxdi;       // from line
output [7:0]        rxdo;       
output              rxdvl;      
output              rxerr;     

output              receiving;  // to pcs_tx
output [15:0]       tx_cfdata;  // to pcs_tx
output [1:0]        xmit;       // to pcs_tx

     // Link status
output              linkdown;
         
input               pact;
input               pen;
input               prs;
input               pws;
input [5:0]         pa;
input [15:0]        pdi;
output [15:0]       pdo;
output              prdy;


////////////////////////////////////////////////////////////////////////////////
// Output declarations

wire   [7:0]        rxdo;       
wire                rxdvl;      
wire                rxerr;      

wire                receiving;  // to pcs_tx
wire   [15:0]       tx_cfdata;  // to pcs_tx
wire   [1:0]        xmit;       // to pcs_tx

wire                prdy;
wire [15:0]         pdo;


////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [1:0]          rudi;
wire [15:0]         rx_cfdata;

wire                sync;       // to CPU
wire [3:0]          an_state;   // to CPU
wire                an_complete;// to CPU
wire                code_err;   // to CPU
wire                disp_err;   // to CPU
wire [3:0]          sync_state; // to CPU
wire                comdet;     // to CPU
wire                baok;       // to CPU
wire                comma;      // to CPU
wire [4:0]          rx_state;   // to CPU
wire                k;          // to CPU
wire                data_ind;   // to CPU

wire [15:0]         pdo_autoneg;
wire                pen_autoneg;
wire                prdy_autoneg;

ippcsge_autoneg             autoneg_inst
    (
     .clk           (rxclk),
     .clk19m        (rxclk),
     
     .rst_          (rst_),
     .sync          (sync),
     .rudi          (rudi),      //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
     .rx_cfdata     (rx_cfdata),
     .tx_cfdata     (tx_cfdata),
     .xmit          (xmit),
     .an_state      (an_state),
     .an_complete   (an_complete),

     .upa           (pa[4:0]),
     .upen          (pen_autoneg),
     .upactive      (pact),
     .uprs          (prs),
     .upws          (pws),
     .updi          (pdi),
     .updo          (pdo_autoneg),
     .uprdy         (prdy_autoneg)
     );

wire                rx_even;
wire [8:0]          sync_do;
ippcsge_sync        sync_inst
    (
     .clk           (rxclk),
     
     .rst_          (rst_),
     .di            (rxdi),
     .sync          (sync),
     //.mr_loopback(mr_lb),
     .rx_eveno      (rx_even),
     .code_err      (code_err),
     .disp_err      (disp_err),
     .do            (sync_do),
     .sync_state    (sync_state),
     .comdet        (comdet),
     .baok          (baok),
     .comma         (comma),

     .pact          (pact), //D.Tu Sat May 23 11:37:35 2009
     .tbio          (),
     .algo          ()      
     );


ippcsge_pcsrx               pcsrx_inst
    (
     .clk           (rxclk),
     .rst_          (rst_),

     //Carrier sense signals
     //.carr_det(),
     .receiving     (receiving),
     
     //configuration signals
     .rudi          (rudi),  //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
     .xmit          (xmit),
     .cfdata        (rx_cfdata),

     //syn block signals
     .rx_even       (rx_even),
     .sync          (sync),
     .code_err      (code_err),
     .di            (sync_do),

     //GMII signals
     .rxdv          (rxdvl),
     .rxer          (rxerr),
     .do            (rxdo),
     .rx_state      (rx_state),
     .k             (k),
     .data_ind      (data_ind) 
     );



// corepi
wire                pen_err;
wire [15:0]         pdo_err;

wire                nsync;
assign              nsync = !sync;

stickyx #(4)  sticky_err
    (
     .clk           (rxclk),
     .rst_          (rst_),
     .upactive      (pact),
     .alarm         ({rxerr & rxdvl,code_err,disp_err,nsync}),
     .upen          (pen_err),
     .upws          (pws),
     .updi          (pdi[3:0]),
     .updo          (pdo_err[3:0]),
     .lalarm        ()
     );

wire                pen_comma;
wire [15:0]         pdo_comma;


stickyx #(3)  sticky_comma
    (
     .clk           (rxclk),
     .rst_          (rst_),
     .upactive      (pact),
     .alarm         ({baok,comma,comdet}),
     .upen          (pen_comma),
     .upws          (pws),
     .updi          (pdi[2:0]),
     .updo          (pdo_comma[2:0]),
     .lalarm        ()
     );

wire                pen_kdata;
wire [15:0]         pdo_kdata;

stickyx #(2)  sticky_kdata
    (
     .clk           (rxclk),
     .rst_          (rst_),
     .upactive      (pact),
     .alarm         ({k,data_ind}),
     .upen          (pen_kdata),
     .upws          (pws),
     .updi          (pdi[1:0]),
     .updo          (pdo_kdata[1:0]),
     .lalarm        ()
     );

wire                pen_ancmp;
wire [15:0]         pdo_ancmp;

stickyx #(1)  sticky_ancmp
    (
     .clk      (rxclk),
     .rst_     (rst_),
     .upactive (pact),
     .alarm    (an_complete),
     .upen     (pen_ancmp),
     .upws     (pws),
     .updi     (pdi[0]),
     .updo     (pdo_ancmp[0]),
     .lalarm   ()
     );


assign              pdo_err[15:4]   =  12'b0;
assign              pdo_comma[15:3] =  13'b0;
assign              pdo_kdata[15:2] =  14'b0;
assign              pdo_ancmp[15:1] =  15'h0;

// status
reg [3:0]           pcs_an;
wire                pen_anstate;

reg [3:0]           pcs_sync;
wire                pen_sync;

reg [4:0]           pcs_rx;
wire                pen_rx;

wire                pen_rx_stk;
wire [15:0]         pdo_rx_stk;



always @(posedge rxclk or negedge rst_)
    if(!rst_)   
        begin
        pcs_an   <= 4'b0;
        pcs_sync <= 4'b0;
        pcs_rx   <= 5'b0;       
        end
    else
        if(pact)
            begin
            pcs_an   <= an_state;
            pcs_sync <= sync_state;
            pcs_rx   <= rx_state;       
            end
        else
            begin
            pcs_an   <= pen_anstate & pws? pdi[3:0]: pcs_an;
            pcs_sync <= pen_sync & pws? pdi[3:0]   : pcs_sync;
            pcs_rx   <= pen_rx& pws ? pdi[4:0]     : pcs_rx;       
            end

wire [15:0]         pdo_anstate;

wire [15:0]         pdo_sync;
wire [15:0]         pdo_rx;

assign              pdo_anstate = pen_anstate ? {12'h0,pcs_an}   : 16'b0;
assign              pdo_sync  = pen_sync ? {12'h0,pcs_sync} : 16'b0;
assign              pdo_rx    = pen_rx   ? {11'h0,pcs_rx}   : 16'h0;

wire                prdy_wrrd;
fflopx #(1)         pp_prdy_wrrd(rxclk,rst_,(pws|prs),prdy_wrrd);

// pdo
assign              pdo  = pdo_autoneg  | pdo_err | pdo_comma| pdo_kdata| pdo_ancmp| pdo_anstate|
                           pdo_sync     | pdo_rx  | pdo_rx_stk;

assign              prdy = prdy_autoneg | ((pen_anstate | pen_sync| pen_rx|pen_err|pen_comma| pen_kdata| pen_ancmp | pen_rx_stk) & prdy_wrrd);


// address decoder
assign              pen_autoneg = pen & (pa[5]   == 1'b0);
assign              pen_err     = pen & (pa[5:0] == 6'h20);
assign              pen_comma   = pen & (pa[5:0] == 6'h21);
assign              pen_kdata   = pen & (pa[5:0] == 6'h22);
assign              pen_ancmp   = pen & (pa[5:0] == 6'h23);
assign              pen_anstate = pen & (pa[5:0] == 6'h24);
assign              pen_sync    = pen & (pa[5:0] == 6'h25);
assign              pen_rx      = pen & (pa[5:0] == 6'h26);
assign              pen_rx_stk  = pen & (pa[5:0] == 6'h27);


// D.Tu Edit

// AutoNeg State
parameter       AN_ENABLE       = 4'd0;
parameter       AN_RESTART      = 4'd1;
parameter       AN_DIS_LINK_OK  = 4'd2;
parameter       ABILITY_DET     = 4'd3;
parameter       ACK_DET         = 4'd4;
parameter       NEXT_PAGE_WAIT  = 4'd5;
parameter       COMPLETE_ACK    = 4'd6;
parameter       IDLE_DET        = 4'd7;
parameter       LINK_OK         = 4'd8;

// SYNC State
parameter   LOSYNC      = 4'd0;
parameter   COM_DET1    = 4'd1;
parameter   ACQ_SYNC1   = 4'd2;
parameter   COM_DET2    = 4'd3;
parameter   ACQ_SYNC2   = 4'd4;
parameter   COM_DET3    = 4'd5;
parameter   SYNC_ACQ1   = 4'd6;
parameter   SYNC_ACQ2   = 4'd7;
parameter   SYNC_ACQ3   = 4'd8;
parameter   SYNC_ACQ4   = 4'd9;
parameter   SYNC_ACQ2A  = 4'd10;
parameter   SYNC_ACQ3A  = 4'd11;
parameter   SYNC_ACQ4A  = 4'd12;


// RX State
parameter       LINK_FAILED         = 5'd0;
parameter       WAIT_FOR_K          = 5'd1;
parameter       RX_K                = 5'd2;
parameter       RX_CB               = 5'd3;
parameter       RX_CC               = 5'd4;
parameter       RX_CD               = 5'd5;
parameter       IDL_D               = 5'd6;
parameter       CARRIER_DET         = 5'd7;
parameter       FALSE_CARR          = 5'd8;
parameter       RX_INVALID          = 5'd9;
parameter       START_OF_PACKET     = 5'd10;
parameter       RECEIVE             = 5'd11;
parameter       EARLY_END           = 5'd12;
parameter       TRI_RRI             = 5'd13;
parameter       TRR_EXTEND          = 5'd14;
parameter       RX_DATA_ERR         = 5'd15;
parameter       RX_DATA             = 5'd16;
parameter       EARLY_END_EXT       = 5'd17;
parameter       EPD2_CHECK_END      = 5'd18;
parameter       EXTEND_ERR          = 5'd19;
parameter       PACKET_BURST_RRS    = 5'd20;

// rx sticky
stickyx #(16)  sticky_rx_state
    (
     .clk      (rxclk),
     .rst_     (rst_),
     .upactive (pact),
     .alarm    ({12'b0,
                 rx_state == RX_DATA_ERR,
                 rx_state == TRR_EXTEND,
                 rx_state == EARLY_END, 
                 rx_state == FALSE_CARR
                 }),
     .upen     (pen_rx_stk),
     .upws     (pws),
     .updi     (pdi[15:0]),
     .updo     (pdo_rx_stk[15:0]),
     .lalarm   ()
     );


     // Link status

parameter       XMIT_IDL = 2'd0;
parameter       XMIT_CFG = 2'd1;
parameter       XMIT_DAT = 2'd2;

parameter       RUDI_INVLD  = 2'b11;
parameter       RUDI_I      = 2'b10;
parameter       RUDI_C      = 2'b01;

reg             linkdown;
wire            rudi_fail = (rudi == RUDI_INVLD);


always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)  linkdown <= 1'b0;
    else
        begin
        case (xmit)
            XMIT_DAT: linkdown <= nsync || rudi_fail;
            default:  linkdown <= linkdown;
        endcase
        end
    end


endmodule 
