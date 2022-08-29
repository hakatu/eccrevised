////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlramsta113x.v
// Description  : This is macro ramcpu interface
//   + write done after 3 clock 
//   + read done after 3 clocks.
//   + Anti-conflict for having write process during read process
//   + Anti-conflict for Read/Write same address (write enable, not read, do = pdi)
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Sat Mar 27 10:23:48 2004
// History (Date, Changed By)
//   + add output pipeline (ie. connectwith iarray113x.v, Tue Mar 17 09:52:33 2009
//
////////////////////////////////////////////////////////////////////////////////

module rtlsta113x
    (

     clk,
     rst,

      // Engine Read/write interface
     eng_re,
     eng_ra,
     eng_rdd,
     eng_we,
     eng_wa,
     eng_wrd,

     
     
     // CPU interface
     upen,     
     upa,
     upws,
     uprs,
     updi,
     updo,
     uprdy,
     active,

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
input                   eng_we;
input  [ADDRBIT-1:0]    eng_wa;
input  [WIDTH-1:0]      eng_wrd;

input                   upen,
                        upws,
                        uprs,
                        active;
input  [ADDRBIT-1:0]    upa;
input  [WIDTH-1:0]      updi;
output [WIDTH-1:0]      updo;
output                  uprdy;

output                  memwe;
output                  memre;
output [ADDRBIT-1:0]    memwa;
output [WIDTH-1:0]      memwrd;
output [ADDRBIT-1:0]    memra;
input  [WIDTH-1:0]      memrdd;

////////////////////////////////////////////////////////////////////////////////
//
wire    engwr, engrd;
assign  engwr = eng_we & active;
assign  engrd = eng_re & active;

reg     upwr_lat = 1'b0,uprd_lat = 1'b0;
wire    upwr,uprd;
wire    upwr_ok, uprd_ok;

assign  upwr = upws & upen;
assign  uprd = uprs & upen;

//assign  upwr_ok = upwr_lat & ((!engwr)|(eng_wa == upa));
//assign  uprd_ok = uprd_lat & ((!engrd)|(eng_ra == upa));
assign  upwr_ok = upwr_lat & (!engwr);
assign  uprd_ok = uprd_lat & (!engrd);

always @ (posedge clk)
    begin
    if(rst)
        begin
        upwr_lat <= 1'b0;
        uprd_lat <= 1'b0;
        end
    else if(!upen)
        begin
        upwr_lat <= 1'b0;
        uprd_lat <= 1'b0;
        end
    else
        begin
        if(upwr_ok)   upwr_lat <= 1'b0; 
        else if(upwr) upwr_lat <= 1'b1;
        
        if(uprd_ok)   uprd_lat <= 1'b0; 
        else if(uprd) uprd_lat <= 1'b1;
        end
    end

// Memory write process
wire                memramwe;
wire [ADDRBIT-1:0]  memramwa;
wire [WIDTH-1:0]    memramwrd;
assign              memramwe  = engwr | upwr_ok;
assign              memramwa  = upwr_ok ? upa : eng_wa;
assign              memramwrd = upwr_ok ? updi : eng_wrd;

// Memory read process
wire                memramre;
wire [ADDRBIT-1:0]  memramra;

//-------------------------------------------------------
//wire [WIDTH-1:0]    memramwrd1;
//fflopx #(WIDTH)     memwepl1 (clk,rst,memramwrd,memramwrd1);
//wire [WIDTH-1:0]    memramwrd2;
//fflopx #(WIDTH)     memwepl2 (clk,rst,memramwrd1,memramwrd2);
//wire [WIDTH-1:0]    memramwrd3;
//fflopx #(WIDTH)     memwepl3 (clk,rst,memramwrd2,memramwrd3);

wire                memramwe1;
wire [ADDRBIT-1:0]  memramwa1;

fflopx #(ADDRBIT+1) memwapl1 (clk,rst,{memramwe,memramwa},
                                       {memramwe1,memramwa1});

wire                memramre1;
wire [ADDRBIT-1:0]  memramra1;

fflopx #(ADDRBIT+1) memrapl1 (clk,rst,{memramre,memramra},
                                       {memramre1,memramra1});

wire                memramre2;
wire [ADDRBIT-1:0]  memramra2;

fflopx #(ADDRBIT+1) memrapl2 (clk,rst,{memramre1,memramra1},
                                       {memramre2,memramra2});

wire                wrconflict;
assign              wrconflict  = memramwe & (memramwa == memramra);

wire                wrconflict1;
assign              wrconflict1 = (memramwe & (memramra1 == memramwa));

wire                wrconflict2;
assign              wrconflict2 = (memramwe  & (memramra2 == memramwa));

reg [WIDTH-1:0]     memramwrd1 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd2 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd3 = {WIDTH{1'b0}};
reg                 samestage3 = 1'b0;
reg                 samestage2 = 1'b0;
reg                 samestage1 = 1'b0;
always @ (posedge clk)
    if (rst)
        begin
        samestage3 <= 1'b0;
        samestage2 <= 1'b0;
        samestage1 <= 1'b0;
        memramwrd1 <= 1'b0;
        memramwrd2 <= 1'b0;
        memramwrd3 <= 1'b0;
        end
    else
        begin
        samestage1 <= memramre & wrconflict;
        memramwrd1 <= memramwrd;
        
        samestage2 <= wrconflict1 | samestage1;
        memramwrd2 <= wrconflict1 ? memramwrd : memramwrd1;
        
        samestage3 <= wrconflict2 | samestage2;
        memramwrd3 <= wrconflict2 ? memramwrd : memramwrd2;     
        end

wire [WIDTH-1:0]    eng_rdd;
assign              eng_rdd     = //samestage1 ? memramwrd1 :
                                  //samestage2 ? memramwrd2 :
                                  samestage3 ? memramwrd3 : memrdd;

//--------------------------------------
assign              memramre = engrd|uprd_ok;
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
wire [WIDTH-1:0]    eng_rdd1;
fflopx #(WIDTH)     eng_rddp1 (clk,rst,eng_rdd,eng_rdd1);
wire                uprdy;
wire [WIDTH-1:0]    updo;
assign              uprdy = upaccess_ok4;
assign              updo  = upen ? eng_rdd1 : {WIDTH{1'b0}};

endmodule 
