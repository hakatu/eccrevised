//////////////////////////////////////////////////////////////////////

module OPAD (PAD, EN, I);
parameter WIDE = 1;

output [WIDE-1:0] PAD;
input [WIDE-1:0]  I;
input             EN;

wire [WIDE-1:0] PAD = EN ? I : {WIDE{1'bZ}}; 
endmodule