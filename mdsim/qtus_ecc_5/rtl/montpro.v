module montpro(
	x, y,
	clk, reset, start,
	z,
	done1
    );

parameter k = 256;


input [k-1:0] x;
input [k-1:0] y;
input clk, reset, start;
output [k-1:0] z;
output done1;

assign z = y[0]? x : 0;

fflopx #(k) ifflopx (clk,reset,start,done1);

endmodule