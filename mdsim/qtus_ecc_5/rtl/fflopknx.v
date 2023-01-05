////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : fflopknx.v
// Description  : .
//
// Author       : tund@HW-NDTU
// Created On   : Tue Aug 04 14:16:01 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module fflopknx
    (
     clk,
     rst,
     idat,
     odat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           W_B = 10;    //data width bit
parameter           K_V = 1;    //k delay value
parameter           A_R = 1;    //all register must be reset
localparam          D_V = K_V <= 1 ? 2 : K_V;
localparam          O_V = K_V <= 1 ? 1 : K_V - 1;
localparam          D_B = (D_V)*W_B;
localparam          S_B = D_B-W_B;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk;
input               rst;
input [W_B-1:0]     idat;
output [W_B-1:0]    odat;
  
////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [W_B-1:0]      odat;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [W_B-1:0]       d_reg /* synthesis preserve */;
reg [S_B-1:0]       s_reg = {S_B{1'b0}} /* synthesis preserve */;

generate
    if (K_V == 0)
        begin: pp_s0
        always @(*) d_reg = idat;
end
    else
        begin: pp_s1
        always @(posedge clk) d_reg <= idat;
end
endgenerate

// capture registers
wire [D_B-1:0]      s_pre;
assign              s_pre = {s_reg[S_B-1:0],d_reg};
assign              odat  =  s_reg[O_V*W_B-1:(O_V-1)*W_B];

generate
    if (K_V <= 1)
        begin: off_s
        always @(*) s_reg = s_pre[S_B-1:0];
end
    else if (A_R == 0)
        begin: on_ns
        always @(posedge clk) s_reg <= s_pre[S_B-1:0];
end
    else
        begin
        always @(posedge clk) s_reg <= s_pre[S_B-1:0];
end
endgenerate


endmodule 
