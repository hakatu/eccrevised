////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
// Filename     : ipsmacge_rxframing.v
// Description  : -> interface with 1 port triple speech 10/100/1000 Mps
//              : -> from phys to mac interface                                 
//
// Author       : nduytuqn@yahoo.com
// Created On   : Mon May 24 16:51:49 2008
// History      :(Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
module ipsmacge_rxframing
    (
     rst_,
     rxclk,
     // input from Phys
     igval,
     igdat, // 8 bit
     igdv,  // also is rx_ctl
     iger,
     // ouput to rxfifoconv2clk
     odat, 
     osop,  
     oeop,  
     oval,  
     oerr,
     // ouput to monstatus
     oistt,
     // cpu interface
     up_rxen,
     up_act,
     up_thipg,
     up_rxnumprm   // num byte preamble (4'h0->1 byte, 4'hF->16bytes)
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8, // Width output data
          DAT_EW = 4;

parameter PRM_CW = 5; // width counter preamble bytes
// internal
parameter DAT_PRM = 8'h55,
          DAT_SFD = 8'hD5;

parameter STT_DW = 2;
parameter STT_IDLE = 2'b00,
          STT_IPRM = 2'b01,
          STT_IPAY = 2'b10;

parameter FCS32_VAL = 32'hc704dd7b;

parameter MRESERVE = 2'b11, // reserve
          M1000    = 2'b10, // speed 1000 Mbps, clk 125Mhz
          M100     = 2'b01, // speed 100 Mbps, clk 25Mhz, 
          M10      = 2'b00; // speed 10 Mbps, clk 2.5Mhz

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
// Help
// {mgmii,mspd}
// {1,00} -> MII   speed 10   Mbps, clk 2.5Mhz
// {1,01} -> MII   speed 100  Mbps, clk 25Mhz
// {1,1x} -> GMII  speed 1000 Mbps, clk 125Mhz
// {0,00} -> RGMII speed 10   Mbps, clk 2.5Mhz
// {0,01} -> RGMII speed 100  Mbps, clk 25Mhz
// {0,1x} -> RGMII speed 1000 Mbps, clk 125Mhz
////////////////////////////////////////////////////////////////////////////////
// input declarations
input               rst_;
input               rxclk;

// input from physical chip
input  [DAT_DW-1:0] igdat;
input               igdv;
input               iger;
input               igval;
// ouput to rxfifoconv2clk
output [DAT_DW-1:0] odat;
output              osop;
output              oeop;
output [DAT_EW-1:0] oerr;
output              oval;
// ouput to mon interframe status
output              oistt;
// cpu interface
input               up_rxen;
input               up_act;
input [3:0]         up_thipg;
input [3:0]         up_rxnumprm;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
// process
wire [31:0]          crc_dat;
reg  [31:0]          fcs_dat;
reg [PRM_CW-1:0]     prmc; // preamble bytes counter
// rxdv, gen process
wire                 rxdv;
wire                 rxer;
wire [DAT_DW-1:0]    edat;
wire [DAT_DW-1:0]    edat1;
reg [STT_DW-1:0]     statem;

wire                 eval;
wire                 esof;
wire                 esop;
wire                 eeof;
wire                 esfd;
wire                 esfd1;
wire                 dval;
wire                 pval;
wire                 gval;
//
wire                 sfde;
wire                 prme;
wire [DAT_EW-1:0]    eerr;
wire                 fcs_err;
reg                  rcv_err;
reg                  prm_err;
reg                  ipacketok;
// output
wire [DAT_DW-1:0]    odat;
wire                 oval;
wire                 osop;
wire                 oeop;
wire                 oistt;
wire [DAT_EW-1:0]    oerr;
reg                  gap_err;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//---------------------------------------------
//  rx rx_dv process, gen eeof, esof, eval
//---------------------------------------------
assign             edat = up_rxen ? igdat : 8'h00;
assign             rxdv = up_rxen ? igdv  : 1'b0;
assign             rxer = up_rxen ? iger  : 1'b0;
assign             eval = igval;

fflopxe #(DAT_DW*1) ff1erxdat  (rxclk, rst_, eval, edat, edat1);
fflopxe #(1*1)      ff1sfd1    (rxclk, rst_, eval, esfd, esfd1);

// state machine
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)                  statem <= STT_IDLE;
    else if (eval)
        begin
        case (statem)
            STT_IDLE:   statem <= rxdv  ? STT_IPRM : STT_IDLE;
            STT_IPRM:   statem <= ~rxdv ? STT_IDLE :
                                  esfd  ? STT_IPAY : STT_IPRM;
            STT_IPAY:   statem <= ~rxdv ? STT_IDLE : STT_IPAY;
            default:            statem <= STT_IDLE;
        endcase
        end
    else                        statem <= statem;
    end

assign         dval = (statem == STT_IPAY) & eval;                      // data is payload
assign         pval = (statem == STT_IPRM) & eval;                      // data is preambe
assign         gval = (statem == STT_IDLE) & eval;                      // data is ipg
// gen 
assign         esof = eval & (statem == STT_IDLE) & ( rxdv);
assign         eeof = eval & (statem == STT_IPAY) & (~rxdv) & ipacketok;
//assign         esfd = (up_mprm ? (pval & (prmc == 4'd7)) : (pval & (prmc == 4'd0))) & (~ipacketok);
assign         esfd = (pval & ((edat1 == DAT_SFD) | (prmc >= {1'b0, up_rxnumprm})));
assign         esop = esfd1 & eval;

assign         sfde = esfd & (edat1 != DAT_SFD);          // sfd error
assign         prme = ((!esfd & pval) & (edat1 != DAT_PRM)) | sfde; // preamble error
// used isolate error
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)      ipacketok <= 1'b0;
    else if (esfd)  ipacketok <= 1'b1;
    else if (eeof)  ipacketok <= 1'b0;
    else            ipacketok <= ipacketok;
    end
//---------------------------------------------
//  Process
//---------------------------------------------
// Preamble err
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)          prm_err <= 1'b0;
    else if (eeof)      prm_err <= 1'b0;
    else if (prme)      prm_err <= 1'b1;
    else                prm_err <= prm_err;
    end

// cnt_byte preamble
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)          prmc <= {PRM_CW{1'b0}};
    else if (~up_act)   prmc <= {PRM_CW{1'b0}};
    else if (eval)
        begin
        if (esof)       prmc <= {PRM_CW{1'b0}};
        else if (eeof)  prmc <= {PRM_CW{1'b0}} + 1'b1; 
        else            prmc <= &prmc ? {PRM_CW{1'b1}} : prmc + 1'b1;
        end
    end
//---------------------------------------------
//  FCS check
//---------------------------------------------
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)      fcs_dat <= {32{1'b1}};
    else if (esof)  fcs_dat <= {32{1'b1}}; // start of frame
    else if (esfd)  fcs_dat <= crc_dat;
    else if (eeof)  fcs_dat <= {32{1'b1}}; // start of frame
    else if (dval)  fcs_dat <= crc_dat;
    else            fcs_dat <= fcs_dat;
    end

assign fcs_err = (|(fcs_dat ^ FCS32_VAL)) & eeof;
// crc 32
ippcrc_crc32_8b icrc32_8b
    (
     .ci    (fcs_dat),
     .di    (edat),

     .co    (crc_dat)
     );

/*
ipsmacge_crc32_1oct #(8)crc32_1oct 
    (
     .din    (edat),
     .lsb    (1'b1),
     .crcin  (fcs_dat),
     .crcout (crc_dat)
     );
 */
//---------------------------------------------
//  received error
//---------------------------------------------
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)          rcv_err <= 1'b0;
    else if (~up_act)   rcv_err <= 1'b0;
    else if (esof)      rcv_err <= 1'b0;
    else if (dval)      rcv_err <= rxer     ? 1'b1 : 
                                   rcv_err  ? 1'b1 : 1'b0;
    end
//---------------------------------------------
//  Monitor ipg
//---------------------------------------------
always @(posedge rxclk or negedge rst_)
    begin
    if (!rst_)          gap_err <= 1'b0;
    else if (esof)      gap_err <= (~(prmc >= {1'b0, up_thipg}));
    end

//---------------------------------------------
//  Out put
//---------------------------------------------
assign             eerr = {gap_err, rcv_err, prm_err, fcs_err};
// status information
fflopx #(DAT_DW*1) ffodat  (rxclk, rst_, edat1, odat);
fflopx #(1)        ffosop  (rxclk, rst_, esop, osop);
fflopx #(1)        ffoeop  (rxclk, rst_, eeof, oeop);
fflopx #(1)        ffoval  (rxclk, rst_, dval, oval);
fflopx #(1)        ffistt  (rxclk, rst_, gval, oistt);
fflopx #(DAT_EW*1) ffoerr  (rxclk, rst_, eerr, oerr);

endmodule
