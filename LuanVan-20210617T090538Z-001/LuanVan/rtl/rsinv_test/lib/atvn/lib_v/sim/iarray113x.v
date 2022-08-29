//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : imemrwpx.v
// Description     : a library of Wrapped read-write-port ram with dual clocks
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 16:02:55 2002 
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//      Wed Sep 07 15:31:33 2005, ddduc
//          modified from ramrwpx
//          added control signal: re, test, mask, rst_ per clk 
//  Mon Jul 27 14:41:51 2009, ndtu@HW-NDTU
//      add parameter MAXDEPTH for better resource usage 
//
//////////////////////////////////////////////////////////////////////////////////

module iarray113x
    (
     wrst_,
     wclk,
     wa,
     we,
     di,

     rrst_,
     rclk,
     ra,
     re,
     do,
     
     test,
     mask
     );

parameter ADDRBIT = 9;
parameter DEPTH   = 512;
parameter WIDTH   = 32;
parameter TYPE = "AUTO";        //This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";

input               wrst_;
input               wclk;
input [ADDRBIT-1:0] wa;     // @+wclk
input               we;     // @+wclk
input [WIDTH-1:0]   di;     // @+wclk

input               rrst_;
input               rclk;
input [ADDRBIT-1:0] ra;     // @+rclk
input               re;
output [WIDTH-1:0]  do;     // @+rclk

input               test;
input               mask;

reg [ADDRBIT-1:0]   iwa = {ADDRBIT{1'b0}};    // @+wclk
reg                 iwe;    // @+wclk
reg [WIDTH-1:0]     idi = {WIDTH{1'b0}};    // @+wclk

reg [ADDRBIT-1:0]   ira = {ADDRBIT{1'b0}};    // @+wclk
reg [WIDTH-1:0]     do = {WIDTH{1'b0}};     // @+rdclk
wire [WIDTH-1:0]    ido;

reg [ADDRBIT-1:0]   cnt = {ADDRBIT{1'b0}};

//wrapping logics
//write port
generate
if (MEM_RESET == "ON")
    begin: on_reset
always @ (posedge wclk)
    if (~wrst_)
        begin
        cnt <= cnt + 1'b1;      
        iwa <= cnt;
        iwe <= 1'b1;
        idi <= {WIDTH{1'b0}};
        end
    else
        begin
        cnt <= {ADDRBIT{1'b0}};
        iwa <= wa;
        iwe <= we;
        idi <= di;
        end
    end
else
    begin: off_reset
always @ (posedge wclk)
    if (~wrst_) iwe <= 1'b0;
    else        iwe <= we;

always @ (posedge wclk)
        begin
        iwa <= wa;
        idi <= di;
        end
    end
endgenerate

//read port
always @ (posedge rclk)     
    begin
    ira <= ra;
    do <= ido;
    end

// Memory instant
`ifdef  RTL_SIMULATION
reg                 ire = {1{1'b0}};
always @ (posedge rclk)  ire <= re;    
iramrwpx #(ADDRBIT,DEPTH,WIDTH) ram (wclk,iwa,iwe,idi,rclk,ira,ire,ido,test,mask);
`else
altsyncram111x #(ADDRBIT,DEPTH,WIDTH,TYPE, MAXDEPTH) ram
    (
    .data(idi),
    .wren(iwe),
    .wraddress(iwa),
    .rdaddress(ira),
    .wrclock(wclk),
    .rdclock(rclk),
    .q(ido));
`endif

endmodule
