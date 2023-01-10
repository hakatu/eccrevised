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
parameter DELAY = 1;
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

//optmize timing register

wire [WID-1:0] arg,brg,mrg,rrg;
wire vldrg,startrg;

ffxkclkx #(DELAY,WID) iffxkclkx1 (clk,rst,a,arg);
ffxkclkx #(DELAY,WID) iffxkclkx2 (clk,rst,b,brg);
ffxkclkx #(DELAY,WID) iffxkclkx3 (clk,rst,m,mrg);
ffxkclkx #(DELAY,WID) iffxkclkx4 (clk,rst,rrg,r);
ffxkclkx #(DELAY,WID) iffxkclkx5 (clk,rst,start,startrg);
ffxkclkx #(DELAY,WID) iffxkclkx6 (clk,rst,vldrg,vld);

//controller FSM
reg              state;
reg [CNTWID-1:0] moncnt; //counter
reg              doneflag; //new flag fix done bug/fixing flag

wire             cntdone; //counter done flag
wire             isidle;//idle flag
wire             cntflg;//counter flag
wire             done;

assign           vldrg = doneflag;
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
            state <= startrg? RUNNING:IDLE;
            doneflag <= 1'b0;
            end
        else
            begin
            state <= cntdone? IDLE:RUNNING;
            doneflag <= cntdone? 1'b1 : 1'b0;
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
    else if(cntflg)
        begin
        moncnt <= moncnt + 1'b1;
        end
    else
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
     
     .a(arg),//full bit of factor a
     .b(brg),//full bit of factor b
     .m(mrg),//modulo
     
     //.shfta(), //shift reg ctrl a
     .ldnew(done),   //load reg a, reset r
     //.shftr(), //shift reg ctrl r
     
     .r(corers)//output
     );

//last substraction

wire [WID-1:0] lstrs; //last sub

assign         lstrs = (corers >= {1'b0,m})? (corers - {1'b0,m}) : corers; 

//output

assign         rrg = lstrs;

endmodule 
