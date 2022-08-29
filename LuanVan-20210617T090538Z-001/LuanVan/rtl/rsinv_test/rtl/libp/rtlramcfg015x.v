////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlramcfg113x.v
// Description  : This is macro ramcpu interface
//   + read done after 3 clocks.
//   + None-conflict for having write process during read process
//   + Anti-conflict for Read/Write same address (write enable, not read, do = pdi)
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Sat Mar 27 10:23:48 2004
// History (Date, Changed By)
//   + add output pipeline (ie. connectwith iarray113x.v, Tue Mar 17 09:52:33 2009
//
////////////////////////////////////////////////////////////////////////////////

module rtlramcfg015x
    (

     clk,
     rst,

      // Engine Read/write interface
     eng_re,
     eng_ra,
     eng_rdd,
     
     // CPU interface
     upen,     
     upa,
     upws,
     uprs,
     updi,
     updo,
     uprdy,
     active,

     icfgparforceerr,   
     icfgparerrdis,     
     ostkparerr,        
     
     // RAM or Register File Interface
     memwe,
     memre,
     memwa,
     memwrd,
     memra,
     memrdd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter ADDRBIT  = 5;
parameter WIDTH    = 32;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input                   clk;
input                   rst;

input                   eng_re;
input  [ADDRBIT-1:0]    eng_ra;
output [WIDTH-1:0]      eng_rdd;

input                   upen,
                        upws,
                        uprs,
                        active;
input  [ADDRBIT-1:0]    upa;
input  [WIDTH-1:0]      updi;
output [WIDTH-1:0]      updo;
output                  uprdy;

input                   icfgparforceerr;// force oparerr, static config, from pconfigpx
input                   icfgparerrdis; // disable oparerr, static config, from pconfigpx
output                  ostkparerr;       // should connect to stickyx to report

`ifdef RTL_RAMCFG_PARITY
output                  memwe;
output                  memre;
output [ADDRBIT-1:0]    memwa;
output [WIDTH:0]        memwrd;
output [ADDRBIT-1:0]    memra;
input  [WIDTH:0]        memrdd;
`else
output                  memwe;
output                  memre;
output [ADDRBIT-1:0]    memwa;
output [WIDTH-1:0]      memwrd;
output [ADDRBIT-1:0]    memra;
input  [WIDTH-1:0]      memrdd;
`endif

////////////////////////////////////////////////////////////////////////////////
//
wire    engrd;
assign  engrd = eng_re & active;

reg     uprd_lat = {1{1'b0}};
wire    upwr,upwr1,uprd;
wire    upwr_ok, uprd_ok;

assign  upwr = upws & upen;
assign  uprd = uprs & upen;

//assign  upwr_ok = upwr;
fflopx #(1) iupwr1 (clk,rst,upwr,upwr1);
fflopx #(1) iupwr_ok (clk,rst,upwr1,upwr_ok);

assign  uprd_ok = uprd_lat & ((!engrd)|(eng_ra == upa));

always @ (posedge clk)
    begin
    if(rst)
        begin
        uprd_lat <= 1'b0;
        end
    else if(!upen)
        begin
        uprd_lat <= 1'b0;
        end
    else
        begin
        if(uprd_ok)   uprd_lat <= 1'b0; 
        else if(uprd) uprd_lat <= 1'b1;
        end
    end

// Memory write process
wire                memramwe;
wire [ADDRBIT-1:0]  memramwa;
assign              memramwe  = upwr_ok;
assign              memramwa  = upa;

`ifdef RTL_RAMCFG_PARITY
wire [WIDTH:0]      memramwrd;
wire                updi_par,updi_parforce;
fflopx #(1) iupdi_par (clk,rst,(^updi[WIDTH-1:0]),updi_par);
fflopx #(1) iupdi_parforce (clk,rst,(updi_par^icfgparforceerr),updi_parforce);
assign              memramwrd = {updi_parforce,updi[WIDTH-1:0]};
`else
wire [WIDTH-1:0]    memramwrd;
assign              memramwrd = updi;

`endif

// Memory read process
wire                memramre;
wire [ADDRBIT-1:0]  memramra;

wire                wrconflict;
assign              wrconflict  = memramwe & (memramwa == memramra);

reg                 samestage5 = {1{1'b0}};
reg                 samestage4 = {1{1'b0}};
reg                 samestage3 = {1{1'b0}};
reg                 samestage2 = {1{1'b0}};
reg                 samestage1 = {1{1'b0}};
always @ (posedge clk)
    if (rst)
        begin
        samestage1 <= 1'b0;
        samestage2 <= 1'b0;
        samestage3 <= 1'b0;
        samestage4 <= 1'b0;
        samestage5 <= 1'b0;
        end
    else
        begin
        samestage1 <= memramre & wrconflict;
        samestage2 <= samestage1;
        samestage3 <= samestage2;
        samestage4 <= samestage3;
        samestage5 <= samestage4;
        end

wire [WIDTH-1:0]    eng_rdd;
assign              eng_rdd     = samestage5 ? updi : memrdd[WIDTH-1:0];

//--------------------------------------
//assign              memramre = engrd|uprd_ok;
assign              memramre = engrd|uprd_lat;
assign              memramra = engrd ? eng_ra : upa;

assign              memwe   = memramwe;
assign              memre   = memramre & (~wrconflict);
assign              memwa   = memramwa;
assign              memwrd  = memramwrd;
assign              memra   = memramra;

//----------------------------------------------------
wire                upaccess_ok;
assign              upaccess_ok = uprd_ok | upwr_ok;
wire                upaccess_ok1;
fflopx #(1)         upaccess_ok1pl (clk,rst,upaccess_ok,upaccess_ok1);
wire                upaccess_ok2;
fflopx #(1)         upaccess_ok2pl (clk,rst,upaccess_ok1,upaccess_ok2);
wire                upaccess_ok3;
fflopx #(1)         upaccess_ok3pl (clk,rst,upaccess_ok2,upaccess_ok3);
wire                upaccess_ok4;
fflopx #(1)         upaccess_ok4pl (clk,rst,upaccess_ok3,upaccess_ok4);
wire                upaccess_ok5;
fflopx #(1)         upaccess_ok5pl (clk,rst,upaccess_ok4,upaccess_ok5);
wire                upaccess_ok6;
fflopx #(1)         upaccess_ok6pl (clk,rst,upaccess_ok5,upaccess_ok6);
wire [WIDTH-1:0]    eng_rdd1;
fflopx #(WIDTH)     eng_rddp1 (clk,rst,eng_rdd,eng_rdd1);
wire                uprdy;
wire [WIDTH-1:0]    updo;
assign              uprdy = upaccess_ok6;
assign              updo  = upen ? eng_rdd1 : {WIDTH{1'b0}};

//----------------------------------------------------
// Check parity
`ifdef RTL_RAMCFG_PARITY
wire                memre1,memre2,memre3,memre4,memre5,memre6;
fflopx #(1) imemre1 (clk,rst,memre,memre1);
fflopx #(1) imemre2 (clk,rst,memre1,memre2);
fflopx #(1) imemre3 (clk,rst,memre2,memre3);
fflopx #(1) imemre4 (clk,rst,memre3,memre4);
fflopx #(1) imemre5 (clk,rst,memre4,memre5);
fflopx #(1) imemre6 (clk,rst,memre5,memre6);

wire                samestage6;
fflopx #(1) isamestage4 (clk,rst,samestage5,samestage6);
wire                par_rdd1;
fflopx #(1) ipar_rdd1 (clk,rst,memrdd[WIDTH],par_rdd1);


wire                parerr;
assign              parerr = (!icfgparerrdis) & memre6 & (!samestage6) & (^{par_rdd1,eng_rdd1});
fflopx #(1) ppparerr (clk,rst,parerr,ostkparerr);

`endif
endmodule 
