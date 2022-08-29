////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : prbs15gen1bit.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Wed Apr 27 13:03:28 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module prbsrand
    (clk,
     rst,
     prbs
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WID   = 64;
parameter           HI    = 15;
parameter           LO    = 14;
////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;
output [WID-1:0]    prbs;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg [WID-1:0]       prbs;
always @ (posedge clk)
    begin
    if (rst)        prbs <= {WID{1'b1}};
    else            prbs <= {prbs[WID-2:0],(prbs[HI-1] ^ prbs[LO-1])};
    end

endmodule 
