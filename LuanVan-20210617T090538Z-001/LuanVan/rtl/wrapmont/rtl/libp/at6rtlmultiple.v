////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtlmultiple.v
// Description  : .
//
// Author       : tdhcuong@HW-TDHCUONG
// Created On   : Tue Jul 11 15:18:17 2006
// History (Date, Changed By)
//  + Mon Sep 28 13:21:39 2009 Update by ndthanh@HW-NDTHANH for AT6868
////////////////////////////////////////////////////////////////////////////////

module at6rtlmultiple
    (
     clk,
     rst,

     vali,
     a,
     b,

     valo,
     c
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter BITA = 32;
parameter BITB = 16;
parameter BITC = BITA + BITB;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               clk;
input               rst;

input               vali;
input [BITA-1:0]    a;
input [BITB-1:0]    b;

output              valo;
output [BITC-1:0]   c;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [BITC-1:0] ashift;
reg [BITB-1:0] bshift;
reg [BITB:0]   position;
reg [BITC-1:0] c;

always @(posedge clk)
    begin
    if(rst)
        begin
        ashift <= {BITC{1'b0}};
        bshift <= {BITB{1'b0}};
        position <= {(BITB+1){1'b0}};
        c <= {BITC{1'b0}};
        end
    else if(vali)
        begin
        ashift <= {{BITB{1'b0}},a};
        bshift <= b;
        position <= {{BITB{1'b0}},1'b1};
        c <= {BITC{1'b0}};
        end
    else //if(!position[BITB])
        begin
        ashift <= {ashift[BITC-2:0],1'b0};
        bshift <= {1'b0,bshift[BITB-1:1]};
        position <= {position[BITB-1:0],1'b0};
        if(bshift[0]) c <= c + ashift;
        end
    end

wire        valo;
assign      valo = position[BITB];

endmodule 
