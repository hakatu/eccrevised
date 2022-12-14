////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ffxkclk.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Tue Dec 15 08:15:08 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ffxkclk
    (
     clk,
     rst,
     idat,
     odat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           K = 3;    //delay 3 clock cycle

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;
input               idat;
output              odat;
  
////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                odat;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
(* keep = "true" *) reg [K-1:0]         shift_dat = {K{1'b0}};
wire [K:0]          shift_in;
assign              shift_in = {shift_dat,idat};

always @ (posedge clk)
    begin
    shift_dat <= shift_in[K-1:0];
    end
assign odat = shift_dat[K-1];

endmodule 
