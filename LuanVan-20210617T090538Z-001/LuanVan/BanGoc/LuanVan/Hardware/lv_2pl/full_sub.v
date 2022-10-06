////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : cla.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Tue Nov 06 16:45:08 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module full_sub
    (
     a,
     b,
     sub,
     c
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 6;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] a,b;

output [WIDTH-1:0] sub;
output       c;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDTH:0] w_c;
wire [WIDTH-1:0] w_g,w_p,w_s;

genvar i;

generate
for(i = 0; i<WIDTH; i = i+1)
    begin : FAgen
    full_adder fai
            (
             .a(a[i]),
             .b(~b[i]),
             .c_i(w_c[i]),
             .sum(w_s[i]),
             .c_o()
             );
    end
endgenerate

genvar j;
generate
    for (j=0;j<WIDTH;j=j+1)
        begin : clgen
        assign w_g[j] = a[j] & ~b[j];
        assign w_p[j] = a[j] | ~b[j];
        assign w_c[j+1] = w_g[j] | (w_p[j] & w_c[j]);
        end
endgenerate

assign         w_c[0] = 1'b1;

assign         sub = w_s;
assign         c = w_c[WIDTH];

endmodule 
