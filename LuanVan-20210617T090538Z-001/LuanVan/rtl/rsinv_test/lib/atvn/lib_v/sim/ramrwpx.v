//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : ramrwpx.v
// Description     : a library of read write port RAM model with dual clocks
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 16:38:23 2002
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////// 

module ramrwpx (wclk,wa,we,di,rclk,ra,do);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE  = "AUTO";
parameter MAXDEPTH = 0;

input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
output [WIDTH-1:0]  do;

reg [WIDTH-1:0] ram [DEPTH-1:0];
reg [WIDTH-1:0] do;

integer i;
initial begin for(i=0;i<DEPTH;i=i+1) ram[i] = {WIDTH{1'b0}}; end

always @ (posedge wclk)
    begin
    if (we) ram[wa] <= di;
    end

always @ (posedge rclk)
    do  <= ram[ra];

endmodule

