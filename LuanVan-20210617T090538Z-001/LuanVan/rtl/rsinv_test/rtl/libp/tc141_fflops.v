////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : tc141_fflops.v
// Description  : fflop is used to synchronize
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Wed Nov 12 08:56:33 2014
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module tc141_fflops
    (
     clk    ,
     rst_   ,//unused
     din    ,
     dout   
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           DAT = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk ;
input               rst_;
input [DAT-1:0]     din ;
output [DAT-1:0]    dout;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
(* ASYNC_REG = "TRUE" *)reg [DAT-1:0]       din_p1 = {DAT{1'b0}};
(* ASYNC_REG = "TRUE" *)reg [DAT-1:0]       din_p2 = {DAT{1'b0}};
wire [DAT-1:0]      dout;
assign              dout = din_p2;

always @(posedge clk)
    begin
    din_p1 <= din ;
    din_p2 <= din_p1;
    end

endmodule 
