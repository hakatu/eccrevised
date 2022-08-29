////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : expcal.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Thu Nov 08 13:37:15 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module expcal
    (
     expa, //exponent a
     expb, //exponent b
     bias,
     expr //exponent result
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 8;
//parameter BIAS = 8'b0111_1111; //127

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] expa;
input [WIDTH-1:0] expb;

input [WIDTH-1:0] bias;

output [WIDTH-1:0] expr;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDTH-1:0]   ubrslt;//unbiased result
wire               ubcarry;

cla #(8) cla1i(expa,expb,ubrslt,ubcarry);

wire [WIDTH:0]   brslt; //biased result
wire               bcarry;

full_sub #(9) fsubi({ubcarry,ubrslt},{1'b0,bias},brslt,bcarry);

assign             expr = brslt[7:0];

endmodule 
