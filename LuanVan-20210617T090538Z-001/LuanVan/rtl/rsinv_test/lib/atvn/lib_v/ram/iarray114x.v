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

(* keep_hierarchy = "yes" *) module iarray114x
    (
     wrst,
     wclk,
     wa,
     we,
     di,

     rrst,
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
parameter NUMCLK = 1;// 1 is one clock domain, 2 is two clock domain

input               wrst;
input               wclk;
input [ADDRBIT-1:0] wa;     // @+wclk
input               we;     // @+wclk
input [WIDTH-1:0]   di;     // @+wclk

input               rrst;
input               rclk;
input [ADDRBIT-1:0] ra;     // @+rclk
input               re;
output [WIDTH-1:0]  do;     // @+rclk

input               test;
input               mask;

reg [ADDRBIT-1:0]   iwa = {ADDRBIT{1'b0}};    // @+wclk
reg                 iwe = 1'b0;    // @+wclk
reg [WIDTH-1:0]     idi = {WIDTH{1'b0}};    // @+wclk

reg [ADDRBIT-1:0]   ira = {ADDRBIT{1'b0}};    // @+wclk

reg [ADDRBIT-1:0]   cnt = {ADDRBIT{1'b0}};

//wrapping logics
//write port
generate
if (MEM_RESET == "ON")
    begin: on_reset
    (* KEEP = "true" *) reg array_reset_ccxxx = 1'b0;
    
always @ (posedge wclk)
    begin
    if (wrst)   array_reset_ccxxx <= 1'b1;
    else        array_reset_ccxxx <= 1'b0;
    end

always @ (posedge wclk)
    if (array_reset_ccxxx)
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
        begin
        iwe <= we;
        iwa <= wa;
        idi <= di;
        end
    end
endgenerate

//read port
always @ (posedge rclk) ira <= ra;

// Memory instant
wire [WIDTH-1:0]    ido3;
reg [WIDTH-1:0]     do = {WIDTH{1'b0}};     // @+rdclk
always @ (posedge rclk)  do <= ido3;

`ifdef  RTL_SIMULATION
reg [ADDRBIT-1:0]   iwa2 = {ADDRBIT{1'b0}};    // @+wclk
reg                 iwe2 = 1'b0;    // @+wclk
reg [WIDTH-1:0]     idi2 = {WIDTH{1'b0}};    // @+wclk
always @ (posedge wclk)
        begin
        iwe2 <= iwe;
        iwa2 <= iwa;
        idi2 <= idi;
        end

reg [ADDRBIT-1:0]   ira2 = {ADDRBIT{1'b0}};    // @+wclk
always @ (posedge rclk) ira2 <= ira;

reg                 ire = {1{1'b0}};
reg                 ire2 = {1{1'b0}};
always @ (posedge rclk)  {ire,ire2} <= {re,ire};

iramrwpx #(ADDRBIT,DEPTH,WIDTH) ram (wclk,iwa2,iwe2,idi2,rclk,ira2,ire2,ido3,test,mask);

`else
alsyncram112x #(ADDRBIT,DEPTH,WIDTH,TYPE, MAXDEPTH, NUMCLK) ram
    (
    .data(idi),
    .wren(iwe),
    .wraddress(iwa),
    .rdaddress(ira),
    .wrclock(wclk),
    .rdclock(rclk),
    .q(ido3));
`endif

endmodule
