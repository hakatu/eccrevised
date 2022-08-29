////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : 66vedic.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Tue Nov 06 17:03:57 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module i66vedic
    (
     a,
     b,
     rslt //result
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 6;
parameter RSWID = 12;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] a;
input [WIDTH-1:0] b;

output [RSWID-1:0] rslt;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDTH-1:0]   w33rslt1;

i33mult i33mult1i
    (
     .a(a[2:0]), //3 bit in
     .b(b[2:0]),
     .prd(w33rslt1) //product
     );

wire [WIDTH-1:0]   w33rslt2;

i33mult i33mult2i
    (
     .a(a[2:0]), //3 bit in
     .b(b[5:3]),
     .prd(w33rslt2) //product
     );

wire [WIDTH-1:0]   w33rslt3;

i33mult i33mult3i
    (
     .a(a[5:3]), //3 bit in
     .b(b[2:0]),
     .prd(w33rslt3) //product
     );

wire [WIDTH-1:0]   w33rslt4;

i33mult i33mult4i
    (
     .a(a[5:3]), //3 bit in
     .b(b[5:3]),
     .prd(w33rslt4) //product
     );

wire [WIDTH-1:0]   cla1rslt;
wire               cla1carry;

cla #(6) i66cla1i
    (
     .a(w33rslt2),
     .b(w33rslt3),
     .sum(cla1rslt),
     .c(cla1carry)
     );

wire [WIDTH-1:0]   cla2rslt;
wire               cla2carry;

cla #(6) i66cla2i
    (
     .a({3'b000,w33rslt1[5:3]}),
     .b(cla1rslt),
     .sum(cla2rslt),
     .c(cla2carry)
     );

wire [WIDTH-1:0]   cla3rslt;
wire               cla3carry;
wire               cla3cin;

assign             cla3cin = cla2carry | cla1carry;

cla #(6) i66cla3i
    (
     .a(w33rslt4),
     .b({2'b00,cla3cin,cla2rslt[5:3]}),
     .sum(cla3rslt),
     .c(cla3carry)
     );

assign             rslt = {cla3rslt,cla2rslt[2:0],w33rslt1[2:0]};

endmodule 
