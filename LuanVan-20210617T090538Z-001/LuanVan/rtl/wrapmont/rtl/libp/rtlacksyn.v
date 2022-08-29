////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlacksyn.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Mon Jun 23 14:01:22 2014
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlacksyn
    (clk,
     rst,
     eupack,
     eupdo,
     uprdy,
     updo
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   WID = 32;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

input               clk,
                    rst;
input               eupack;
input [WID-1:0]     eupdo;
output              uprdy;
output [WID-1:0]    updo;

wire [3:0]           upack_shift;   
fflopx #(4) iupack_shift (clk,rst,{upack_shift[2:0],eupack},upack_shift[3:0]);

wire                 uprdy0; 
assign               uprdy0 = (upack_shift[3:2] == 2'b01);

fflopx #(1) iuprdy (clk,rst,uprdy0,uprdy);

wire [WID-1:0] eupdo1;
fflopx #(WID) ppeupdo (clk,rst,eupdo,eupdo1);
fflopx #(WID) ppeupdo1 (clk,rst,eupdo1,updo);

endmodule 
