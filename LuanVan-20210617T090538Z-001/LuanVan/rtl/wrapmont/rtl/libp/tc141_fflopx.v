//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : tc141_fflopx.v
// Description     : variable size flip flop
//
// Author          : hw-bhtcuong
// Created On      : Tue Jul 29 18:00:29 2003
// History (Date, Changed By)
//
//////////////////////////////////////////////////////////////////////////////////

module tc141_fflopx
    (
     clk,
     rst_,
     idat,
     odat
     );

parameter WIDTH = 8;
parameter RESET_VALUE = {WIDTH{1'b0}};
parameter RESET_ENB   = 0;

input   clk, rst_;

input  [WIDTH-1:0] idat;

output [WIDTH-1:0] odat;
//reg    [WIDTH-1:0] odat = RESET_VALUE;

generate
if(RESET_ENB==1)
    begin : enb_rst
    (* keep = "true" *)reg    [WIDTH-1:0] iodat = RESET_VALUE;
    assign             odat = iodat;
    
    always @ (posedge clk or posedge rst_)
        begin
        if(rst_)iodat <= RESET_VALUE;
        else    iodat <= idat;
        end
    end
else
    begin : dis_rst
    (* keep = "true" *)reg    [WIDTH-1:0] iodat = RESET_VALUE;
    assign             odat = iodat;
    
    always @ (posedge clk)
        begin
        iodat <= idat;
        end
    end
endgenerate

endmodule
