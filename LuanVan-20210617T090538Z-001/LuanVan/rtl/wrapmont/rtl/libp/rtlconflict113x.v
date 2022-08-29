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

module rtlconflict113x
    (
     clk,
     rst,

      // Engine Read/write interface
     eng_re,
     eng_ra,
     eng_rdd3,
     eng_wrd4,

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
output [WIDTH-1:0]      eng_rdd3;
input  [WIDTH-1:0]      eng_wrd4;

output                  memwe;
output                  memre;
output [ADDRBIT-1:0]    memwa;
output [WIDTH-1:0]      memwrd;
output [ADDRBIT-1:0]    memra;
input  [WIDTH-1:0]      memrdd;

////////////////////////////////////////////////////////////////////////////////
// Memory write process

wire                memramre = eng_re;
wire [ADDRBIT-1:0]  memramra = eng_ra;

wire                memramre1;
wire [ADDRBIT-1:0]  memramra1;
fflopx #(ADDRBIT+1) memrapl1 (clk,rst,{memramre,memramra},{memramre1,memramra1});

wire                memramre2;
wire [ADDRBIT-1:0]  memramra2;
fflopx #(ADDRBIT+1) memrapl2 (clk,rst,{memramre1,memramra1},{memramre2,memramra2});

wire                memramre3;
wire [ADDRBIT-1:0]  memramra3;
fflopx #(ADDRBIT+1) memrapl3 (clk,rst,{memramre2,memramra2},{memramre3,memramra3});

wire                memramre4;
wire [ADDRBIT-1:0]  memramra4;
fflopx #(ADDRBIT+1) memrapl4 (clk,rst,{memramre3,memramra3},{memramre4,memramra4});

wire                memramwe = memramre4;
wire [ADDRBIT-1:0]  memramwa = memramra4;
wire [WIDTH-1:0]    memramwrd = eng_wrd4;

// Anti conflict
wire                wrconflict;
assign              wrconflict  = memramwe & (memramwa == memramra);

wire                wrconflict1;
assign              wrconflict1 = memramwe & (memramra1 == memramwa);

wire                wrconflict2;
assign              wrconflict2 = memramwe  & (memramra2 == memramwa);

reg                 samestage4 = {1{1'b0}},samestage4_n = {1{1'b0}};
reg                 samestage3 = {1{1'b0}};
reg                 samestage2 = {1{1'b0}};
reg                 samestage1 = {1{1'b0}};
always @ (posedge clk)
    begin
    if (rst)
        begin
        samestage4_n <= 1'b0;
        samestage4 <= 1'b0;
        samestage3 <= 1'b0;
        samestage2 <= 1'b0;
        samestage1 <= 1'b0;
        end
    else
        begin
        samestage1 <= memramre & wrconflict;
        samestage2 <= wrconflict1 | samestage1;
        samestage3 <= wrconflict2 | samestage2;
        //samestage4 <= memramre4  & (memramra3 == memramra4);
        samestage4_n <= memramre2  & (memramra1 == memramra2);
        samestage4 <= samestage4_n;
        end
    end

reg [WIDTH-1:0]     memramwrd1 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd2 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd3 = {WIDTH{1'b0}};
always @ (posedge clk)
    begin
    memramwrd1 <= memramwrd;
    memramwrd2 <= wrconflict1 ? memramwrd : memramwrd1;
    memramwrd3 <= wrconflict2 ? memramwrd : memramwrd2;     
    end

wire [WIDTH-1:0]    eng_rdd3;
assign              eng_rdd3  = samestage4 ? memramwrd  :
                                samestage3 ? memramwrd3 : memrdd;

//--------------------------------------
assign              memwe   = memramwe;
assign              memre   = memramre & (~wrconflict);
assign              memwa   = memramwa;
assign              memwrd  = memramwrd;
assign              memra   = memramra;

endmodule 
