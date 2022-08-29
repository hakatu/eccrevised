////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlbussel.v
// Description  : .
//
// Author       : thanhnd@HW-NDTHANH
// Created On   : Wed May 06 22:54:41 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlbussel (en, in, out);
parameter N = 6;
parameter O = 8;
parameter I = N*O;
input [N-1:0] en;
input [I-1:0] in;
output [O-1:0] out;
reg [O-1:0]    out;
integer        i,j;
always @(*)
    begin
    out = {O{1'b0}};
    for (i=0;i<N;i=i+1)
        begin
        if(en[i])
            begin
            for (j=0;j<O;j=j+1) out[j] = in[i*O+j];
            end
        end
    end
endmodule
