////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : 2424vedic.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Tue Nov 06 18:03:57 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module i2424vedic
    (
     a,
     b,
     rslt //result
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 24;
parameter RSWID = 48;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDTH-1:0] a;
input [WIDTH-1:0] b;

output [RSWID-1:0] rslt;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDTH-1:0]   w1212rslt1;

i1212vedic i1212vedic1i
    (
     .a(a[11:0]), //3 bit in
     .b(b[11:0]),
     .rslt(w1212rslt1) //product
     );

wire [WIDTH-1:0]   w1212rslt2;

i1212vedic i1212vedic2i
    (
     .a(a[11:0]), //3 bit in
     .b(b[23:12]),
     .rslt(w1212rslt2) //product
     );

wire [WIDTH-1:0]   w1212rslt3;

i1212vedic i1212vedic3i
    (
     .a(a[23:12]), //3 bit in
     .b(b[11:0]),
     .rslt(w1212rslt3) //product
     );

wire [WIDTH-1:0]   w1212rslt4;

i1212vedic i1212vedic4i
    (
     .a(a[23:12]), //3 bit in
     .b(b[23:12]),
     .rslt(w1212rslt4) //product
     );

wire [WIDTH-1:0]   cla1rslt;
wire               cla1carry;

cla #(24) i2424cla1i
    (
     .a(w1212rslt2),
     .b(w1212rslt3),
     .sum(cla1rslt),
     .c(cla1carry)
     );

wire [WIDTH-1:0]   cla2rslt;
wire               cla2carry;

cla #(24) i2424cla2i
    (
     .a({12'b0,w1212rslt1[23:12]}),
     .b(cla1rslt),
     .sum(cla2rslt),
     .c(cla2carry)
     );

wire [WIDTH-1:0]   cla3rslt;
wire               cla3carry;
wire               cla3cin;

assign             cla3cin = cla2carry | cla1carry;

cla #(24) i2424cla3i
    (
     .a(w1212rslt4),
     .b({11'b0,cla3cin,cla2rslt[23:12]}),
     .sum(cla3rslt),
     .c(cla3carry)
     );

assign             rslt = {cla3rslt,cla2rslt[11:0],w1212rslt1[11:0]};

endmodule 
