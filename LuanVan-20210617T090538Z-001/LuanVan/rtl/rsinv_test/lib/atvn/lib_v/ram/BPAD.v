module BPAD (PAD, EN, I, O);        // Fast bi-direct buffer only PAD.
parameter   WIDE    = 1;

input [WIDE-1:0]    I;
input               EN;
output [WIDE-1:0]   O;
inout [WIDE-1:0]    PAD;

reg [WIDE-1:0]      int;
wire [WIDE-1:0] PAD = EN ? I : {WIDE{1'bz}};
always @ (PAD)
    if (PAD === {WIDE{1'bz}})
        int <= {WIDE{1'bx}};
     else int <= PAD;

assign  O = int;
endmodule
