////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtldbgsipo.v
// Description  : ..debug serial input paralell output used to reduce pin
//
// Author       : tund@HW-NDTU
// Created On   : Wed Mar 18 10:28:04 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtldbgsipo1
    (
     clk,
     rst,
     iena,
     idat,
     odat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ODAT_B = 10;
parameter IDAT_B = 1;
parameter OCNT_B = tflog2(ODAT_B);

function integer tflog2;
    input [31 : 0] value;
    integer        i;
    begin
        tflog2 = 0;
        for(i = 0;2 ** i < value;i = i + 1)
            begin
            tflog2 = i + 1;
            end
    end
endfunction

////////////////////////////////////////////////////////////////////////////////
// Port declarations


input     clk;
input     rst;
input [IDAT_B-1:0] idat;
input              iena;
output [ODAT_B-1:0] odat;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

wire [ODAT_B-1:0]   odat;
reg [ODAT_B-1:0]    edat;

fflopknx #(ODAT_B) xflodat (clk,rst,edat,odat);

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [IDAT_B-1:0]   idat_l;
wire [OCNT_B-1:0]   ocnt_l;
fflopknx #(IDAT_B) xflidat_l (clk,rst,idat,idat_l);
fflopknx #(OCNT_B) xflocnt_l (clk,rst,iena?1'b0:ocnt_l+1'b1,ocnt_l);

always @(posedge clk)
    if (!rst) edat <= {ODAT_B{1'b0}};
    else edat [ocnt_l] <= idat_l;

endmodule 
