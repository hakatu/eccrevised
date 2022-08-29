////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : 33mult.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Tue Nov 06 14:31:48 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module i33mult
    (
     a, //3 bit in
     b,
     prd //product
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [2:0] a;
input [2:0] b;

output [5:0] prd;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire         d0,d1,d2,d3,d4,d5,d6,d7,d8;

assign       d0 = a[0] & b[0];
assign       d1 = a[0] & b[1];
assign       d2 = a[1] & b[0];
assign       d3 = a[1] & b[1];
assign       d4 = a[2] & b[0];
assign       d5 = a[0] & b[2];
assign       d6 = a[1] & b[2];
assign       d7 = a[2] & b[1];
assign       d8 = a[2] & b[2];

wire         s1,c1;
half_adder ha1i(d1,d2,s1,c1);

wire         s2,c2;
full_adder fa1i(d3,d5,c1,s2,c2);

wire         s3,c3;
half_adder ha2i(s2,d4,s3,c3);

wire         s4,c4;
full_adder fa2i(d6,d7,c2,s4,c4);

wire         s5,c5;
half_adder ha3i(s4,c3,s5,c5);

wire         s6,r6;
full_adder fa3i(c4,d8,c5,s6,r6);

assign       prd = {r6,s6,s5,s3,s1,d0};

endmodule 
