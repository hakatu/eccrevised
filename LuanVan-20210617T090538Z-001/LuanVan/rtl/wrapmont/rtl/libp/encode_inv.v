////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : encode_inv.v
// Description  : Parameterized encoding from a bitmap into a number.
//
//                M.Tu has evaluated the encoder in Quartus. He found that it has
//                the better timing in Stratix II than the old one 
//                that we normally use (83Mhz vs 53Mhz for 256 -->8 encoding). 
//
// Author       : ctmtu@HW-CTMTU
// Created On   : Thu Oct 09 10:11:29 2008
// History (Date, Changed By)
// Sat Feb 07 09:37:24 2009 - Changed by ctmtu
//  - search LSB of bit 1
////////////////////////////////////////////////////////////////////////////////

module encode_inv
    (
     in,
     out,
     nonz
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       INW  = 256;
parameter       OUTW = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [INW-1:0]     in;
output [OUTW-1:0]   out;
output              nonz;

////////////////////////////////////////////////////////////////////////////////
// Output declarations


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire                nonz;
assign              nonz    = |in;

integer             i;
reg [OUTW-1:0]      out;
always @ (in)
    begin
    out = {OUTW{1'b0}};
    for (i=INW;i>0;i=i-1)
        begin
        if (in[i-1]) out = i[OUTW:0] - 1;
        end
    end

endmodule 
