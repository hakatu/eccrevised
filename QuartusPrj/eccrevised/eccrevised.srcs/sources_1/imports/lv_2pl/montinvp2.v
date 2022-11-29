////////////////////////////////////////////////////////////////////////////////
//
// Ho Chi Minh City University of Technology
//
// Filename     : montinvp2.v
// Description  : .
//
// Author       : Vuong Dinh Hung
// Created On   : Wed Mar 06 13:46:50 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module montinvp2
    (
     clk,
     rst,
     ainv,
     mod,
     exp,
     en,
     inv,
     vld
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 256;
parameter CWID  = 10;
parameter INIT  = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input     clk;
input     rst;
input [WIDTH-1:0] ainv; // r
input [WIDTH-1:0] mod;  // p 
input [CWID-1:0]  exp;  // k
input             en;

output [WIDTH-1:0] inv;
output             vld; // set until next calculation

////////////////////////////////////////////////////////////////////////////////
// Output declarations

//reg [WIDTH-1:0]    inv;
reg                vld;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [CWID-1:0]     cnt;
reg [WIDTH-1:0]    r;
reg [WIDTH-1:0]    p;

wire [WIDTH-1:0]   pr;
wire               carry;

/*
cla #(WIDTH) icla
    (
     .a(p),
     .b(r),
     .sum(pr),
     .c(carry)
     );
 */

aladder iadd(
    .cin(1'b0),
    .clock(clk),
    .dataa(p),
    .datab(r),
    .cout(carry),
    .result(pr)
             );


reg                stop;
reg [1:0]          flag;
wire [1:0]         flag_inc;
assign             flag_inc = flag + 2'b01;

wire               rsflag = (flag == 2'b10);


always @(posedge clk)
    begin
    if (rst)        flag <= 2'b0;
    else if (en)    flag <= 2'b00;
    else if (rsflag) flag <= 2'b00;
    else            flag <= flag_inc;
    end

always @(posedge clk)
    begin
    if (rst)
        begin
        cnt <= INIT;
        r   <= INIT;
        p   <= INIT;
        vld <= INIT;
        stop    <= 1'b1;
        end
    else if (en)
        begin
        cnt <= exp - WIDTH;
        r   <= ainv;
        p   <= mod;
        vld <= INIT;
        stop    <= INIT;
        end
    else if ((cnt > 0) && rsflag)
        begin
        cnt <= cnt - 1;
        stop    <= INIT;
        if (r[0])   // r is odd
            begin
            r   <= {carry, pr[WIDTH-1:1]};  // (p+r)/2
            end
        else
            begin
            r   <= {1'b0, r[WIDTH-1:1]};
            end
        end
    else if ((!stop) && rsflag) 
        begin
        vld     <= 1'b1;
        stop    <= 1'b1;
        end
    else
        begin
        vld <= INIT;
        end
    end

assign inv = r;

endmodule 
