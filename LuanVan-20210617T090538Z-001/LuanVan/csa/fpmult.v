////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : fpmult.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Thu Nov 08 14:12:21 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module fpmult
    (
     a,
     b,
     rslt
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 32;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] a;
input [WIDTH-1:0] b;

output [WIDTH-1:0] rslt;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [31:0] calrslt;

assign             calrslt[31] = a[31] ^ b[31];

wire [7:0]         exprslt;
wire [7:0]         biasd; //bias for exp

expcal expcali(a[30:23],b[30:23],biasd,exprslt);

assign             calrslt[30:23] = exprslt;

wire [22:0]        mtsrs; //matisa result //normalized
wire [47:0]        vedicrs; // vedic result

i2424vedic i24vedici({1'b1,a[22:0]},{1'b1,b[22:0]},vedicrs);
normalize23 normi(vedicrs,mtsrs,biasd);

assign             calrslt[22:0] = mtsrs;

wire               zrdet; //for zero detection

assign             zrdet = !(|a) | !(|b);

assign             rslt = zrdet ? 32'b0 : calrslt;

endmodule 
