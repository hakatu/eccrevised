////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtldumpdbdat.v
// Description  : .
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Sat Aug 29 09:53:13 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtldumpdbdat
    (
     clk,
     rst,

     dbenb,
     vld,
     dat,

     wrpage,
     
     upact,
     upen,
     upa,
     upws,
     uprs,
     updi,
     updo,
     uprdy
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           DBADD   = 11;
parameter           DBDAT   = 32;
parameter           DBLEN   = {1'b1,{DBADD{1'b0}}};

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               dbenb;
input               vld;
input [DBDAT-1:0]   dat;

output              wrpage;

input               upact;
input               upen;
input [DBADD-1:0]   upa;
input               upws;
input               uprs;
input [DBDAT-1:0]   updi;
output [DBDAT-1:0]  updo;
output              uprdy;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

////////////////////////////////////////////////////////////////////////////////
wire                dumpfull;
wire                dumpstr;
assign              dumpstr = dbenb;

reg                 dumpen;
always @ (posedge clk)// or negedge rst_)
    begin
    if(rst) dumpen <= 1'b0;
    else if(dumpstr) dumpen <= 1'b1;
    else if(dumpfull) dumpen <= 1'b0;
    end

////////////////////////////////////////////////////////////////////////////////
wire                rden;
wire [DBADD-1:0]    rdid;
assign              rden = 1'b0;
assign              rdid = {DBADD{1'b0}};
wire [DBDAT-1:0]    rddat;

wire                wren;
assign              wren = dumpen & vld;

reg [DBADD-1:0]     wrid;

always @ (posedge clk)// or negedge rst_)
    begin
    if(rst)           wrid <= {DBADD{1'b0}};
    else if(dumpfull)   wrid <= {DBADD{1'b0}};
    else if(wren)       wrid <= wrid + 1;
    end

assign  wrpage  = wrid[DBADD-1];

assign              dumpfull = wren & (wrid == {DBADD{1'b1}});

wire [DBDAT-1:0]    wrdat;
assign              wrdat = dat;

// DBADD-DBDAT-DBLEN-2clk

wire                dbdat_pen;
wire [DBDAT-1:0]    dbdat_pdo;
wire                dbdat_prdy;
wire                dbdat_we;
wire [DBADD-1:0]    dbdat_wa;
wire [DBDAT-1:0]    dbdat_di;
wire                dbdat_re;
wire [DBADD-1:0]    dbdat_ra;
wire [DBDAT-1:0]    dbdat_do;

rtlrambuf112x #(DBADD,DBDAT) dbdatarb
    (

     .clk       (clk),
     .rst       (rst),     

      // Engine Read/write interface
     .eng_re    (rden),         // Engine read 1, input
     .eng_ra    (rdid),         // Engine id read 1, input
     .eng_rdd   (rddat),        // Engine data read 1, input
     .eng_we    (wren),         // Engine write, input
     .eng_wa    (wrid),         // Engine id write, input
     .eng_wrd   (wrdat),        // Engine data write, input
     
     // CPU interface
     .upen      (dbdat_pen),       // CPU enable
     .upws      (upws),           // CPU write strobe
     .uprs      (uprs),           // CPU read Strobe      
     .upa       (upa[DBADD-1:0]),       // CPU Address
     .updi      (updi[DBDAT-1:0]), // CPU Data input
     .updo      (dbdat_pdo),       // CPU Data output
     .uprdy     (dbdat_prdy),      // CPU ready
     .active    (upact),
     
     // RAM or Register File Interface
     .memwe     (dbdat_we),        // write enable, output
     .memwa     (dbdat_wa),        // write address, output
     .memwrd    (dbdat_di),        // write data, output
     .memre     (dbdat_re),        // read enable 1, output
     .memra     (dbdat_ra),        // read address 1, output
     .memrdd    (dbdat_do)         // ram data out 1, input      
     );

iarray112x #(DBADD,DBLEN,DBDAT) dbdat          
    (
     .wrst          (rst),
     .wclk          (clk),
     .wa            (dbdat_wa),
     .we            (dbdat_we),
     .di            (dbdat_di),

     .rrst          (rst),
     .rclk          (clk),
     .ra            (dbdat_ra),
     .re            (dbdat_re),
     .do            (dbdat_do),

     .test          (1'b0),
     .mask          (1'b0)
     );

////////////////////////////////////////////////////////////////////////////////
assign              dbdat_pen = upen;

wire [DBDAT-1:0]    updo;
assign              updo =  dbdat_pdo;

wire                uprdy;
assign              uprdy = dbdat_prdy;

endmodule 
