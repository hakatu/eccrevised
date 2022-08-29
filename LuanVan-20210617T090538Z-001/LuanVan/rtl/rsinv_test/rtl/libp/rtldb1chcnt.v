////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtldb1chcnt.v
// Description  : .
//
// Author       : tund@HW-NDTU
// Created On   : Tue Nov 16 20:06:27 2010
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtldb1chcnt
    (
     clk,
     rst,
     
     vld,
     num,
     upen_ro,
     upen_r2c,
     uprs,
     uprdy,
     updo,
     out
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WIDTH = 32;
parameter           NUM = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk;
input               rst;

input               vld;
input [NUM-1:0]     num;
input               upen_ro;
input               upen_r2c;
input               uprs;
output              uprdy;
output [WIDTH-1:0]  updo;
output [WIDTH-1:0]  out;

////////////////////////////////////////////////////////////////////////////////
// Output declarations


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg [WIDTH-1:0]     cnt;
tri0 [NUM-1:0]      num;
wire [NUM:0]        numadd = {NUM{vld}}&num + vld;
always @ (posedge clk or posedge rst)
    begin
    if (rst)  cnt <= {WIDTH{1'b0}};
    else if (upen_r2c && uprs)    cnt <= numadd;
    else    cnt <= &cnt ? cnt : numadd + cnt;
    end

wire            uprdy;
assign          uprdy = (upen_r2c || upen_ro) && uprs;

wire [WIDTH-1:0] updo;
assign           updo = (upen_r2c | upen_ro) ? cnt : {WIDTH{1'b0}};

wire [WIDTH-1:0] out  = cnt;

endmodule 
