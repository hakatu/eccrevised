////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : test.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Wed May 08 15:31:59 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module test
    (
     clk,
     k,
     t,
     kt
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input clk;
input [255:0] k;
input [7:0]   t;
output        kt;
////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg           kt;

always@(posedge clk)
    begin
    kt <= k[t];
    end

endmodule 
