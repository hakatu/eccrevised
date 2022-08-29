////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array112x.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Apr 14 11:04:54 2004
// History (Date, Changed By)
//  Mon Jul 27 14:40:33 2009, ndtu@HW-NDTU
//      add parameter MAXDEPTH for better resource usage
//  Fri Aug 23 09:21:00 2013, tund@HW-NDTU
//      add parameter MEM_RESET to off clear MEMORY
//
////////////////////////////////////////////////////////////////////////////////

module array112x
    (
     rst_,
     wclk,
     wa,
     we,
     di,
     rclk,
     ra,
     do
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ADDRBIT = 5;
parameter DEPTH = 32;
parameter WIDTH = 32;
parameter TYPE = "AUTO";     //"M512" , "M4K", "M-RAM", "AUTO"
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;     // @+clk
input               we;     // @+clk
input [WIDTH-1:0]   di;     // @+clk
input               rclk;
input [ADDRBIT-1:0] ra;     // @+clk
output [WIDTH-1:0]  do;     // @+clk

reg [ADDRBIT-1:0]   iwa;    // @+clk
reg                 iwe;    // @+clk
reg [WIDTH-1:0]     idi;    // @+clk
reg [ADDRBIT-1:0]   ira;    // @+clk

wire [WIDTH-1:0]    ido;
wire [WIDTH-1:0]    do;     // @+clk

//delaying write command one clock cycle
//write port
always @ (posedge wclk or negedge rst_)
    if (~rst_)
        begin
        iwa <= {ADDRBIT{1'b0}};
        iwe <= 1'b0;
        idi <= {WIDTH{1'b0}};
        end
    else
        begin
        iwa <= wa;
        iwe <= we;
        idi <= di;
        end

//delaying read command one clock cycle
//read port
always @ (posedge rclk or negedge rst_)
    if (~rst_)
        ira <= {ADDRBIT{1'b0}};
    else
        ira <= ra;

//wiring ram data out directly to data out bus
assign do   = ido;

//read write port ram, dual clock instantiation
array111x #(ADDRBIT,DEPTH,WIDTH) array (rst_,wclk,iwa,iwe,idi,rclk,ira,ido);

endmodule
