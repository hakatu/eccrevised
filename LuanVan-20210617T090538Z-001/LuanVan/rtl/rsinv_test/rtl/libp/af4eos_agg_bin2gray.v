////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4eos_agg_bin2gray.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Wed Apr 06 13:56:04 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4eos_agg_bin2gray
    (
     b,
     g
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   WIDTH = 4;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [WIDTH-1:0]   b;
output [WIDTH-1:0]  g;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [WIDTH-1:0]    b;
wire [WIDTH-1:0]    g;
/*
 Copy the most significant bit. 
    For each smaller i
    G[i] = B[i+1] ^ B[i]
 */
assign              g[WIDTH-1]  = b[WIDTH-1];
assign              g[WIDTH-2:0]= b[WIDTH-1:1] ^ b[WIDTH-2:0];

endmodule 
