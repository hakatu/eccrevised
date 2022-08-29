////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4eos_agg_gray2bin.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Wed Apr 06 13:55:38 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4eos_agg_gray2bin
    (
     g,
     b
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   WIDTH = 4;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [WIDTH-1:0]   g;
output [WIDTH-1:0]  b;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [WIDTH-1:0]    g;
wire [WIDTH-1:0]    b;
/*
 Convert Gray to Binary: 
    Copy the most significant bit. 
    For each smaller i
    B[i] = B[i+1] ^ G[i]
 */
assign              b[WIDTH-1]  = g[WIDTH-1];
assign              b[WIDTH-2:0]= b[WIDTH-1:1] ^ g[WIDTH-2:0];

endmodule 
