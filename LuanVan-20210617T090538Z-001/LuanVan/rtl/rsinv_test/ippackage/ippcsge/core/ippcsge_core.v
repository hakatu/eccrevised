////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ippcsge_core.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Mon Aug 17 14:13:32 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

//`define RTL_OFF_PCSRX_ELASTIC_FIFO

module ippcsge_core
    (
     // TBI to GMII (PHY to MAC)
     rxclk,
     rxrst_,
     
     tbi_rxdat,

     gmii_rxdat,
     gmii_rxdv,
     gmii_rxer,
     // GMII to TBI (MAC to PHY)
     txclk,
     txrst_,

     gmii_txdat,
     gmii_txen,
     gmii_txer,

     tbi_txdat,
     
     // Link status
     linkdown,
     
     // CPU
     sysclk,
     sysrst_,
     upact,     
     upen,
     uprs,      //+sysclk
     upws,      //+sysclk
     upa,
     updi,
     updo,      //+sysclk
     uprdy      //+sysclk
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Port declarations

     // TBI to GMII (PHY to MAC)
input           rxclk;
input           rxrst_;

input [9:0]     tbi_rxdat;

output [7:0]    gmii_rxdat;
output          gmii_rxdv;
output          gmii_rxer;
     // GMII to TBI (MAC to PHY)
input           txclk;
input           txrst_;

input [7:0]     gmii_txdat;
input           gmii_txen;
input           gmii_txer;

output [9:0]    tbi_txdat;

     // Link status
output          linkdown;
         
     // CPU
input           sysclk;
input           sysrst_;

input           upact;
input           upen;
input           uprs;
input           upws;
input [5:0]     upa;
input [15:0]    updi;
output [15:0]   updo;
output          uprdy;
////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation


// TX PCS
wire                sytx_upen;
wire   [15:0]       sytx_updo;
wire                sytx_uprdy;


wire                tx_upen;
wire   [15:0]       tx_updo;
wire                tx_uprdy;

// Sticky elastic fifo
wire                sk_upen;
wire   [15:0]       sk_updo;
wire                sk_uprdy;

// config elastic fifo
wire                el_upen;
wire   [15:0]       el_updo;
wire                el_uprdy;

// RX PCS
wire                syrx_upen;
wire   [15:0]       syrx_updo;
wire                syrx_uprdy;

assign  sytx_updo   = (tx_updo  |
                       sk_updo  |
                       el_updo  );

wire    sytx_uprdy0;
fflopx #(2) iffsytxuprdy (sysclk, sysrst_, {sytx_upen & (uprs | upws), sytx_uprdy0}, {sytx_uprdy0, sytx_uprdy});
                          
assign updo [15:0]  = sytx_updo  | syrx_updo;
assign uprdy        = sytx_uprdy | syrx_uprdy;

assign sytx_upen    = upen & (upa [5:4]  == 2'b11);  // 0x30 - 0x3F
assign syrx_upen    = upen & (~sytx_upen );          // 0x00 - 0x2F

assign tx_upen      = sytx_upen & (upa [5:0] == 6'h3F);
assign sk_upen      = sytx_upen & (upa [5:0] == 6'h3E);
assign el_upen      = sytx_upen & (upa [5:0] == 6'h3D);


// Elastic fifo
wire                elff_wrerr;
wire                elff_rderr;
wire                elff_flush;
wire [3:0]          elff_thsh;


pconfigx #(5, {1'b0, 4'd5}) elasticfifo_control 
    (
     .clk           (sysclk),
     .rst_          (sysrst_),
     .upen          (el_upen),
     .upws          (upws),
     .updi          (updi[4:0]),
     .out           ({elff_flush, elff_thsh}),
     .updo          (el_updo[4:0])
     );

assign              el_updo [15:5] = 11'b0;

stickyx #(2) elasticfifo_stky
    (
     .clk       (sysclk),
     .rst_      (sysrst_),
     .upactive  (upact),
     .alarm     ({elff_rderr, elff_wrerr}),
     .upen      (sk_upen),
     .upws      (upws),
     .updi      (updi[1:0]),
     .updo      (sk_updo [1:0]),
     .lalarm    ()
     );

assign              sk_updo [15:2] = 14'b0;

//==============================
wire                rx_upen;
wire                rx_uprs;
wire                rx_upws;
wire [5:0]          rx_upa;
wire   [15:0]       rx_updi;
wire   [15:0]       rx_updo;
wire                rx_uprdy;


ippcsge_cpuadap #(6, 16) icpuadap
    (
     // System clock > 62.6 Mhz, < 125 Mhz
     .syclk     (sysclk),
     .syrst_    (sysrst_),
     .syupen    (syrx_upen),
     .syupa     (upa),
     .syuprs    (uprs),
     .syupws    (upws),
     .syupdi    (updi),
     .syupdo    (syrx_updo),
     .syuprdy   (syrx_uprdy),

     // RXCLK clock 125 Mhz
     .rxclk     (rxclk),
     .rxrst_    (rxrst_),
     .rxupen    (rx_upen),
     .rxupa     (rx_upa),
     .rxuprs    (rx_uprs),
     .rxupws    (rx_upws),
     .rxupdi    (rx_updi),
     .rxupdo    (rx_updo),
     .rxuprdy   (rx_uprdy)
     );

//==============================
wire                receiving;  // to pcs_tx
wire   [15:0]       tx_cfdata;  // to pcs_tx
wire   [1:0]        xmit;       // to pcs_tx

wire [7:0]          gmii_redat;
wire                gmii_redv;
wire                gmii_reer;

ippcsge_pcs_rx   ipcs_rx
    (
     .rxclk     (rxclk),
     .rst_      (rxrst_),

     .rxdi      (tbi_rxdat),
     .rxdo      (gmii_redat),
     .rxdvl     (gmii_redv),
     .rxerr     (gmii_reer),

     // to pcs_tx
     .receiving (receiving),
     .tx_cfdata (tx_cfdata),
     .xmit      (xmit),

     // Link status
     .linkdown  (linkdown),

     // CPU
     .pact      (upact),
     .pen       (rx_upen),
     .prs       (rx_uprs),
     .pws       (rx_upws),
     .pa        (rx_upa [5:0]),
     .pdi       (rx_updi [15:0]),
     .pdo       (rx_updo [15:0]),
     .prdy      (rx_uprdy)
     );


`ifndef RTL_OFF_PCSRX_ELASTIC_FIFO

ippcsge_elasticfifo #(9,4,16) ielasticfifo
    (
     // input
     .inclk         (rxclk),
     .inrst_        (rxrst_),
     
     .indata        ({gmii_reer, gmii_redat}),
     .invld         (gmii_redv),

     // output
     .outclk        (txclk),
     .outrst_       (txrst_),
     
     .outdata       ({gmii_rxer, gmii_rxdat}),
     .outvld        (gmii_rxdv),
     
     // SKTY
     .wrerr         (elff_wrerr),
     .rderr         (elff_rderr),
     // Config
     .upact         (upact),
     .upflush       (elff_flush),
     .upthsh        (elff_thsh)
     );

`else
assign              {gmii_rxer, gmii_rxdat, gmii_rxdv} = {gmii_reer, gmii_redat, gmii_redv};

`endif

//============================
ippcsge_pcs_tx   ipcs_tx
    (
     .sclk125   (txclk),
     .rst_      (txrst_),

     .txen      (gmii_txen),
     .txerr     (gmii_txer),

     // from pcs_rx
     .receiving (receiving),
     .xmit      (xmit),
     .tx_cfdata (tx_cfdata),

     .col       (),
     .crs       (),
     .txdi      (gmii_txdat),
     .txdo      (tbi_txdat),

     // CPU
     .sysclk    (sysclk),
     .sysrst_   (sysrst_),
     .pact      (upact),
     .pen       (tx_upen),
     .pws       (upws),
     .prs       (uprs),
     .pdi       (updi [15:0]),
     .pdo       (tx_updo [15:0]),
     .prdy      (tx_uprdy)
     );

endmodule 

//=======================================================
//=======================================================

module ippcsge_cpuadap
    (
     // System clock > 62.6 Mhz, < 125 Mhz
     syclk,
     syrst_,
     syupen,
     syupa,
     syuprs,
     syupws,
     syupdi,
     syupdo,
     syuprdy,

     // RXCLK clock 125 Mhz
     rxclk,
     rxrst_,
     rxupen,
     rxupa,
     rxuprs,
     rxupws,
     rxupdi,
     rxupdo,
     rxuprdy
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           CPUA = 6;
parameter           CPUD = 16;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

     // System clock > 62.6 Mhz, < 125 Mhz
input               syclk;
input               syrst_;
input               syupen;
input [CPUA-1:0]    syupa;
input               syuprs;
input               syupws;
input [CPUD-1:0]    syupdi;
output [CPUD-1:0]   syupdo;
output              syuprdy;

     // RXCLK clock 125 Mhz
input               rxclk;
input               rxrst_;
output              rxupen;
output [CPUA-1:0]   rxupa;
output              rxuprs;
output              rxupws;
output [CPUD-1:0]   rxupdi;
input [CPUD-1:0]    rxupdo;
input               rxuprdy;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

assign      rxupdi  = syupdi;
assign      rxupen  = syupen;
assign      rxupa   = syupa;

// UPRS
wire [2:0]  uprssamp;
fflopx #(3) iflrxuprs (rxclk, rxrst_, {uprssamp [1:0], syuprs}, {uprssamp [2:0]});
assign      rxuprs = (~uprssamp [2]) & uprssamp [1];

// UPWS
wire [2:0]  upwssamp;
fflopx #(3) iflrxupws (rxclk, rxrst_, {upwssamp [1:0], syupws}, {upwssamp [2:0]});
assign      rxupws = (~upwssamp [2]) & upwssamp [1];

// UPRDY
wire        rxuprdy_stress;
wire        rxuprdy1;

fflopx #(2) iflrxuprdy (rxclk, rxrst_, {(rxuprdy | rxuprdy1), rxuprdy}, {rxuprdy_stress, rxuprdy1});

wire [2:0]  uprdysamp;
fflopx #(3) iflpruprdy (syclk, syrst_, {uprdysamp [1:0], rxuprdy_stress}, {uprdysamp [2:0]});

wire        preuprdy;
assign      preuprdy = (~uprdysamp [2]) & uprdysamp [1];

fflopx #(1) iflsuprdy (syclk, syrst_, preuprdy, syuprdy);

// UPDO
wire [CPUD-1:0] rxupdo_l;
fflopxe #(CPUD) iflrxupdo (rxclk, rxrst_, rxuprdy, rxupdo, rxupdo_l);

assign          syupdo = syupen ? rxupdo_l : {CPUD{1'b0}};


endmodule 
//================================================================
//================================================================
////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ippcsge_elasticfifo.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Mon Jun 08 16:01:27 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
module ippcsge_elasticfifo
    (
     // input
     inclk,
     inrst_,
     
     indata,
     invld,

     // output
     outclk,
     outrst_,
     
     outdata,
     outvld,

     // Memory IF
     /*
     ram_wdat,
     ram_wena,
     ram_wadd,
     
     ram_rdat,
     ram_rena,
     ram_radd,
      */

     // SKTY
     wrerr,
     rderr,
     // Config
     upact,
     upflush,
     upthsh
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATD = 9;
parameter RAMA = 4,
          RAML = 16,
          RAMD = DATD+1;
////////////////////////////////////////////////////////////////////////////////
// Port declarations

     // input
input               inclk;
input               inrst_;


input [DATD-1:0]    indata;
input               invld;


     // output
input               outclk;
input               outrst_;

output [DATD-1:0]   outdata;
output              outvld;

     // Memory IF
/*
output [RAMD-1:0]   ram_wdat;
output              ram_wena;
output [RAMA-1:0]   ram_wadd;

input [RAMD-1:0]    ram_rdat;
output              ram_rena;
output [RAMA-1:0]   ram_radd;
 */
     
     // Stky
output              wrerr;
output              rderr;

     // Config
input               upact;
input               upflush;
input [RAMA-1:0]    upthsh;

////////////////////////////////////////////////////////////////////////////////
// Signal declarations0


//======================
// global
wire [RAMA:0]       wrpnt_gray;
wire [RAMA:0]       rdpnt_gray;


wire   [RAMD-1:0]   ram_wdat;
wire                ram_wena;
wire   [RAMA-1:0]   ram_wadd;

wire  [RAMD-1:0]    ram_rdat;
wire                ram_rena;
wire   [RAMA-1:0]   ram_radd;


iarray111x #(RAMA, RAML, RAMD) iram
    (  
     .test  (1'b0),
     .mask  (1'b0),
     .wrst_ (inrst_),
     .wclk  (inclk),
     .wa    (ram_wadd),
     .we    (ram_wena),
     .di    (ram_wdat),
     .rclk  (outclk),
     .rrst_ (outrst_),
     .re    (ram_rena),
     .ra    (ram_radd),
     .do    (ram_rdat)
     );

//======================
// Domain inclk
wire                fifowr;
wire                fifofull;
wire [RAMA:0]       wrfifolen;


convclk_grayffwr #(RAMA) igrayffwr
    (
     .wrclk         (inclk),
     .wrrst_        (inrst_),

     .fifowr        (fifowr),
     .fifoflush     (upflush),
     .fifofull      (fifofull),
     .half_full     (),
     .wrfifolen     (wrfifolen),
     .wrpnt_gray    (wrpnt_gray),     //use to synchronize @ rdclk
     
     .write         (ram_wena),
     .wraddr        (ram_wadd),

     // Read pointer @ rdclk
     .rdpnt_gray    (rdpnt_gray)
     );

wire                invld1;

fflopx #(1) ffinvld1 (inclk, inrst_, invld, invld1);

assign              fifowr = (invld | invld1) & upact;

assign              ram_wdat = {invld, indata};

// =====================
// Domain outclk
wire                fiford;
wire                fifonemp;
wire [RAMA:0]       rdfifolen;

convclk_grayffrd #(RAMA) igrayffrd
    (
     .rdclk         (outclk),
     .rdrst_        (outrst_),

     .fiford        (fiford),
     .fifoflush     (upflush),
     .fifonemp      (fifonemp),
     .rdfifolen     (rdfifolen),
     .rdpnt_gray    (rdpnt_gray),     //use to synchronize @ wrclk
     
     .rdaddr        (ram_radd),
     .read          (ram_rena),

     // Write pointer @ wrclk
     .wrpnt_gray    (wrpnt_gray)
     );


wire                statenew;
assign              statenew = (rdfifolen >= {1'b0, upthsh});


reg                 staterd;
wire                endrd;

always @(posedge outclk or negedge outrst_)
    begin
    if (~outrst_)       staterd <= 1'b0;
    else if (~upact)    staterd <= 1'b0;
    else if (upflush)   staterd <= 1'b0;
    else if (endrd)     staterd <= 1'b0;
    else if (statenew)  staterd <= 1'b1;
    end

wire                fifonemp1;

fflopx #(1) fffifonemp (outclk, outrst_, fifonemp, fifonemp1);

assign fiford = (((~staterd) & statenew)    |
                 ((staterd) & (~endrd))     ) & (fifonemp1 & fifonemp);


wire                ram_rena1;

fflopx #(1) fframrena (outclk, outrst_, ram_rena, ram_rena1);

assign              endrd = ram_rena1 & (~ram_rdat [RAMD-1]);

reg [DATD-1:0]      outdata;
reg                 outvld;

always @(posedge outclk or negedge outrst_)
    begin
    if (~outrst_)
        begin
        outdata     <= {DATD{1'b0}};
        outvld      <= 1'b0;
        end
    else if (~upact | upflush)
        begin
        outdata     <= {DATD{1'b0}};
        outvld      <= 1'b0;
        end
    else if (ram_rena1)
        begin
        outdata     <= ram_rdat [DATD-1:0];
        outvld      <= ram_rdat [RAMD-1];
        end
    else
        begin
        outdata     <= {DATD{1'b0}};
        outvld      <= 1'b0;
        end
    end


// Sticky
wire        werr;
wire        rerr;
assign      werr = fifowr & fifofull;
assign      rerr = staterd & (~fifonemp1);

wire        werr1;
wire        rerr1;

fflopx #(2) ffrderr (outclk, outrst_, {rerr,  (rerr1 | rerr)},
                     {rerr1, rderr});
                     
fflopx #(2) ffwrerr (inclk, inrst_, {werr,  (werr1 | werr)},
                     {werr1, wrerr});



endmodule
