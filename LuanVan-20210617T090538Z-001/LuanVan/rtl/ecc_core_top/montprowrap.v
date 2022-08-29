////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : montprowrap.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Thu Mar 07 13:39:47 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
module montprowrap
    (
     clk,
     rst,
     
     a,//input a
     b,//input b
     m,//input m
     r,//output result
     
     start, //enable
     vld
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
`ifdef TEST
parameter WID = 4;
parameter CNTWID = 2;
parameter ZERO = 4'b0;
parameter IDLE = 1'b0;
parameter RUNNING = 1'b1;
`else
parameter WID = 256;
parameter CNTWID = 8;
parameter ZERO = 256'b0;
parameter IDLE = 1'b0;
parameter RUNNING = 1'b1;
`endif
////////////////////////////////////////////////////////////////////////////////
// Port declarations

input     clk;
input     rst;

input [WID-1:0] a;
input [WID-1:0] b;
input [WID-1:0] m;

output [WID-1:0] r;

input            start;
output           vld;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire         shiften;

//pipeline input
wire [WID-1:0]   a1;
wire [WID-1:0]   b1;
wire [WID-1:0]   m1;
wire             start;

fflopx #(256) iff1(clk,rst,a,a1);
fflopx #(256) iff2(clk,rst,b,b1);
fflopx #(256) iff3(clk,rst,m,m1);
fflopx #(1) iff4(clk,rst,start,start1);
//controller FSM
reg              state;
reg [CNTWID-1:0] moncnt; //counter
reg              doneflag; //new flag fix done bug/fixing flag

wire             cntdone; //counter done flag
wire             isidle;//idle flag
wire             cntflg;//counter flag
wire             done;

assign           vld = doneflag;
assign           isidle = state == IDLE;
assign           done = isidle;//
assign           cntflg = !isidle;

//assign           cntdone = moncnt == -1'd1;
assign           cntdone = moncnt == -1'd1;

always@(posedge clk)
    begin
    if(rst)
        begin
        state <= IDLE;
        doneflag <= 1'b0;
        end
    else
        begin
        if(isidle)
            begin
            state <= start1? RUNNING:IDLE;
            doneflag <= 1'b0;
            end
        else
            begin
            state <= ~(cntdone & shiften);
            doneflag <= cntdone & shiften;
            end
        end
    end

//counter

always@(posedge clk)
    begin
    if(rst)
        begin
        moncnt <= ZERO;
        end
    else if(cntflg && shiften) 
        begin
        moncnt <= moncnt + 1'b1;
        end
    else if (done && shiften)
        begin
        moncnt <= 0;
        end
    end

//shift control
//every clock

//moncore
wire [WID:0] corers;//core result of r

montpro #(WID,ZERO) imontpro
    (
     .clk(clk),
     .rst(rst),
     
     .a(a1),//full bit of factor a
     .b(b1),//full bit of factor b
     .m(m1),//modulo
     
     //.shfta(), //shift reg ctrl a
     .ldnew(done),   //load reg a, reset r
     //.shftr(), //shift reg ctrl r
     
     .r(corers),//output
     .shiften(shiften)
     );

//last substraction

wire [WID-1:0] lstrs; //last sub

assign         lstrs = (corers >= {1'b0,m})? (corers - {1'b0,m}) : corers; 

//output

assign         r = lstrs;

endmodule 
