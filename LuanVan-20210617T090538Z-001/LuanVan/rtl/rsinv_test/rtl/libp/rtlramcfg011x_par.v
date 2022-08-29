////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlramarb113xe.v
// Description  : This is macro ramcpu interface
//   + read done after 1 clocks.
//   + None-conflict for having write process during read process
//   + Anti-conflict for Read/Write same address (write enable, not read, do = pdi)
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Sat Mar 27 10:23:48 2004
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlramcfg011x_par
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
     ostkparerr
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter ADDRBIT  = 5;
parameter WIDTH    = 32;
parameter DEPTH    = {1'b1,{ADDRBIT{1'b0}}};
parameter TYPE     = "AUTO";

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

////////////////////////////////////////////////////////////////////////////////
wire                    memwe;
wire                    memre;
wire [ADDRBIT-1:0]      memwa;
wire [WIDTH:0]          memwrd;
wire [ADDRBIT-1:0]      memra;
wire [WIDTH:0]          memrdd;

////////////////////////////////////////////////////////////////////////////////
//
wire    engrd;
assign  engrd = eng_re & active;

reg     uprd_lat;
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

reg                 samestage1;
always @ (posedge clk)
    if (rst)
        begin
        samestage1 <= 1'b0;
        end
    else
        begin
        samestage1 <= memramre & wrconflict;
        end

wire [WIDTH-1:0]    eng_rdd;
assign              eng_rdd     = samestage1 ? updi : memrdd[WIDTH-1:0];

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
wire [WIDTH-1:0]    eng_rdd1;
fflopx #(WIDTH)     eng_rddp1 (clk,rst,eng_rdd,eng_rdd1);
wire                uprdy;
wire [WIDTH-1:0]    updo;
assign              uprdy = upaccess_ok2;
assign              updo  = upen ? eng_rdd1 : {WIDTH{1'b0}};

//----------------------------------------------------
// Check parity
wire                memre1,memre2;
fflopx #(1) imemre1 (clk,rst,memre,memre1);
fflopx #(1) imemre2 (clk,rst,memre1,memre2);

wire                samestage2;
fflopx #(1) isamestage2 (clk,rst,samestage1,samestage2);

wire                par_rdd1;
fflopx #(1) ipar_rdd1 (clk,rst,memrdd[WIDTH],par_rdd1);

wire                parerr;
assign              parerr = (!icfgparerrdis) & memre2 & (!samestage2) & (^{par_rdd1,eng_rdd1});
fflopx #(1) ppparerr (clk,rst,parerr,ostkparerr);

////////////////////////////////////////////////////////////////////////////////
iarray111x #(ADDRBIT, DEPTH, WIDTH+1, TYPE)   membuf
    (
     .wrst  (rst),
     .wclk  (clk),
     .wa    (memwa), 
     .we    (memwe),
     .di    (memwrd),

     .rrst  (rst),
     .rclk  (clk),
     .ra    (memra),
     .re    (memre),
     .do    (memrdd),

     .test  (1'b0),
     .mask  (1'b0)
     );

endmodule 
