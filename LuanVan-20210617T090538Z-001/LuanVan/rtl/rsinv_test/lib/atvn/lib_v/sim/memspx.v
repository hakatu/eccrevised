//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : memspx.v
// Description     : a library of Wrapped single-port ram
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 16:02:55 2002
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////// 

module memspx
    (
     clk,
     rst_,
     a,
     we,
     di,
     do
     );

parameter ADDRBIT = 11;
parameter DEPTH = 1536;
parameter WIDTH = 32;
parameter TYPE = "AUTO";		//This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;

input               clk;
input               rst_;
input [ADDRBIT-1:0] a;
input               we;
input [WIDTH-1:0]   di;
output [WIDTH-1:0]  do;

reg [ADDRBIT-1:0]   ia;
reg                 iwe;
reg [WIDTH-1:0]     idi;
wire [WIDTH-1:0]    ido;
reg [WIDTH-1:0]     do;

//wrapping logics
//input
always @ (posedge clk or negedge rst_)
    if (~rst_)
        begin
        ia  <= {ADDRBIT{1'b0}};
        iwe <= 1'b0;
        idi <= {WIDTH{1'b0}};
        end
    else
        begin
        ia  <= a;
        iwe <= we;
        idi <= di;
        end

//output
always @ (posedge clk or negedge rst_)
    if (~rst_)  do  <= {WIDTH{1'b0}};
    else        do  <= ido;

//single-port ram instantiation
ramspx #(ADDRBIT,DEPTH,WIDTH) ram (clk,ia,iwe,idi,ido);

endmodule
