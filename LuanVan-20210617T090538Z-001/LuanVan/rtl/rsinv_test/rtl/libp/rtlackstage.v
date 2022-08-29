////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlackstage.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Thu Jul 13 09:42:21 2017
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlackstage
    (clk,
     rst,
     
     req,
     reqinf,
     ack,

     oreq,
     oreqinf,
     iack
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   INF = 32;
parameter   FANOUT = 100;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               req;
input [INF-1:0]     reqinf;
output              ack;

output              oreq;
output [INF-1:0]    oreqinf;
input               iack;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg                 oreq = 1'b0;
always @ (posedge clk)
    begin
    if (rst)    oreq <= 1'b0;
    else        oreq <= !iack & (oreq | req);
    end
//(* max_fanout = FANOUT *) wire ack;
wire ack;
assign              ack = !oreq & req;
fflopxe #(INF) latreqinf (clk,rst,ack,reqinf,oreqinf);

endmodule 
