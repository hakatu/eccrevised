////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_ifddioout.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Thu Jan 15 10:54:05 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_ifddioout
    (
     txclk,
     txrst_,
     idat_h,
     idat_l,
     odat_h,
     odat_l
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DW = 4; // width data

////////////////////////////////////////////////////////////////////////////////
// input declarations
input             txrst_;
input             txclk;
// input from phys chip

input [DW-1: 0]   idat_h; // input data at posedge of clk
input [DW-1: 0]   idat_l; // input data at negedge of clk
// output data
output [DW-1: 0]  odat_h;   // output data
output [DW-1: 0]  odat_l;   // output data

////////////////////////////////////////////////////////////////////////////////
// signal declarations0
wire [DW-1:0]     odat_h;
wire [DW-1:0]     odat_l;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

fflopx #(DW) ffodath (txclk, txrst_, idat_h, odat_h);
fflopx #(DW) ffodatl (txclk, txrst_, idat_l, odat_l);

endmodule
