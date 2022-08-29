////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : 1212vedic.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Tue Nov 06 18:03:57 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module i1212vedic
    (
     a,
     b,
     rslt //result
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 12;
parameter RSWID = 24;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] a;
input [WIDTH-1:0] b;

output [RSWID-1:0] rslt;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDTH-1:0]   w66rslt1;

i66vedic i66vedic1i
    (
     .a(a[5:0]), //3 bit in
     .b(b[5:0]),
     .rslt(w66rslt1) //product
     );

wire [WIDTH-1:0]   w66rslt2;

i66vedic i66vedic2i
    (
     .a(a[5:0]), //3 bit in
     .b(b[11:6]),
     .rslt(w66rslt2) //product
     );

wire [WIDTH-1:0]   w66rslt3;

i66vedic i66vedic3i
    (
     .a(a[11:6]), //3 bit in
     .b(b[5:0]),
     .rslt(w66rslt3) //product
     );

wire [WIDTH-1:0]   w66rslt4;

i66vedic i66vedic4i
    (
     .a(a[11:6]), //3 bit in
     .b(b[11:6]),
     .rslt(w66rslt4) //product
     );

wire [WIDTH-1:0]   cla1rslt;
wire               cla1carry;

cla #(12) i1212cla1i
    (
     .a(w66rslt2),
     .b(w66rslt3),
     .sum(cla1rslt),
     .c(cla1carry)
     );

wire [WIDTH-1:0]   cla2rslt;
wire               cla2carry;

cla #(12) i1212cla2i
    (
     .a({6'b0,w66rslt1[11:6]}),
     .b(cla1rslt),
     .sum(cla2rslt),
     .c(cla2carry)
     );

wire [WIDTH-1:0]   cla3rslt;
wire               cla3carry;
wire               cla3cin;

assign             cla3cin = cla2carry | cla1carry;

cla #(12) i1212cla3i
    (
     .a(w66rslt4),
     .b({5'b0,cla3cin,cla2rslt[11:6]}),
     .sum(cla3rslt),
     .c(cla3carry)
     );

assign             rslt = {cla3rslt,cla2rslt[5:0],w66rslt1[5:0]};

endmodule 
