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
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
//////////////////////////////////////////////////////////////////////////////////

module imemrwpx
    (
     wrst_,
     wrclk,
     wa,
     we,
     di,

     rrst_,
     rdclk,
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

input               wrst_;
input               wrclk;
input [ADDRBIT-1:0] wa;     // @+wrclk
input               we;     // @+wrclk
input [WIDTH-1:0]   di;     // @+wrclk

input               rrst_;
input               rdclk;
input [ADDRBIT-1:0] ra;     // @+rdclk
input               re;
output [WIDTH-1:0]  do;     // @+rdclk

input               test;
input               mask;

reg [ADDRBIT-1:0]   iwa;    // @+wrclk
reg                 iwe;    // @+wrclk
reg [WIDTH-1:0]     idi;    // @+wrclk
reg [ADDRBIT-1:0]   ira;    // @+wrclk

wire [WIDTH-1:0]    ido;
reg                 ire;
reg [WIDTH-1:0]     do;     // @+rdclk

//wrapping logics
//write port
always @ (posedge wrclk or negedge wrst_)
    if (~wrst_)
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

//read port
always @ (posedge rdclk or negedge rrst_)
    if (~rrst_)
        begin
        ira <= {ADDRBIT{1'b0}};
        ire <= 1'b0;
        end
    else
        begin
        ira <= ra;
        ire <= re;
        end

always @ (posedge rdclk or negedge rrst_)
    if (~rrst_)
        do      <= {WIDTH{1'b0}};
    else
        do      <= ido;

//read write port ram, dual clock instantiation
iramrwpx #(ADDRBIT,DEPTH,WIDTH) ram (wrclk,iwa,iwe,idi,rdclk,ira,ire,ido,test,mask);

endmodule
