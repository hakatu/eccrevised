////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : mem2rwpx.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Feb 16 17:58:35 2005
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module mem2rwpx
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

reg [ADDRBIT_A-1:0]   ia0;
reg                   iwe0;
reg [WIDTH_A-1:0]     idi0;

wire [WIDTH_A-1:0]    ido0;
reg [WIDTH_A-1:0]     do0;

reg [ADDRBIT_B-1:0]   ia1;
reg                   iwe1;
reg [WIDTH_B-1:0]     idi1;
wire [WIDTH_B-1:0]    ido1;
reg [WIDTH_B-1:0]     do1;


//wrapping logics
//write port
always @ (posedge clk0 or negedge rst_)
    if (~rst_)
        begin
        ia0  <= {ADDRBIT_A{1'b0}};
        iwe0 <= 1'b0;
        idi0 <= {WIDTH_A{1'b0}};
        end
    else
        begin
        ia0 <= a0;
        iwe0 <= we0;
        idi0 <= di0;
        end

always @ (posedge clk1 or negedge rst_)
    if (~rst_)
        begin
        ia1  <= {ADDRBIT_B{1'b0}};
        iwe1 <= 1'b0;
        idi1 <= {WIDTH_B{1'b0}};
        end
    else
        begin
        ia1 <= a1;
        iwe1 <= we1;
        idi1 <= di1;
        end

//read port
always @ (posedge clk0 or negedge rst_)
    if (~rst_)
        do0      <= {WIDTH_A{1'b0}};
    else
        do0      <= ido0;

always @ (posedge clk1 or negedge rst_)
    if (~rst_)
        do1      <= {WIDTH_B{1'b0}};
    else
        do1      <= ido1;

//read write port ram, dual clock instantiation
ram2rwx #(ADDRBIT_A,DEPTH_A,WIDTH_A,ADDRBIT_B,DEPTH_B,WIDTH_B,TYPE) ram 
    (
     .clk0(clk0),
     .clk1(clk1),
     .a0(ia0),
     .we0(iwe0),
     .di0(idi0),
     .do0(ido0),
     .a1(ia1),
     .we1(iwe1),
     .di1(idi1),
     .do1(ido1)
     );


endmodule
