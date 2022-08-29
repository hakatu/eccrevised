////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array2rwp2x.v
// Description  : .this array is used for true dual port RAM with data pipeline
//                  out
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Thu Mar 24 10:06:02 2005
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module array2rwp2x
    (rst_,
     
     clk0,
     a0,
     we0,
     di0,
     do0,
     
     clk1,
     a1,
     we1,
     di1,
     do1);


parameter ADDRBIT_A = 6;
parameter DEPTH_A = 48;
parameter WIDTH_A = 80;

parameter ADDRBIT_B = 6;
parameter DEPTH_B = 48;
parameter WIDTH_B = 80;

parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

input                   rst_;
input                   clk0, clk1;
input [ADDRBIT_A-1:0]   a0;
input                   we0;
input [WIDTH_A-1:0]     di0;
output [WIDTH_A-1:0]    do0;

input [ADDRBIT_B-1:0]   a1;
input                   we1;
input [WIDTH_B-1:0]     di1;
output [WIDTH_B-1:0]    do1;

wire [WIDTH_A-1:0]    ido0;
reg [WIDTH_A-1:0]     do0;

wire [WIDTH_B-1:0]    ido1;
reg [WIDTH_B-1:0]     do1;


//wrapping logics

//read port
always @ (posedge clk0 or negedge rst_)
    if (~rst_)
        do0      <= {WIDTH_A{1'b0}};
    else
        do0      <= ido0;

always @ (posedge clk0 or negedge rst_)
    if (~rst_)
        do1      <= {WIDTH_B{1'b0}};
    else
        do1      <= ido1;

//read write port ram, dual clock instantiation
ram2rwx #(ADDRBIT_A,DEPTH_A,WIDTH_A,ADDRBIT_B,DEPTH_B,WIDTH_B,TYPE) ram 
    (
     .clk0(clk0),
     .clk1(clk1),
     .a0(a0),
     .we0(we0),
     .di0(di0),
     .do0(ido0),
     .a1(a1),
     .we1(we1),
     .di1(di1),
     .do1(ido1)
     );


endmodule
