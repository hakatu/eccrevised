////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4_ipoh_vote4.v
// Description  : .
//
// Author       : lvquoc@HW-LVQUOC
// Created On   : Fri Aug 20 10:24:32 2004
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4_ipoh_vote4
    (
     req,
     prior,
     win,
     winval
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   [3:0]   req;    // requests arbitration
input   [1:0]   prior;  // priority base
output  [1:0]   win;    // request winner
output          winval; // winner valid

////////////////////////////////////////////////////////////////////////////////
// Output declarations
reg     [1:0]   win;
wire            winval;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
assign          winval = |req[3:0];

always @ (req[3:0] or prior[1:0])
    begin
    casex ({req[3:0],prior[1:0]})
        {4'bxxx1,2'h0}: win = 2'h0;
        {4'bxx10,2'h0}: win = 2'h1;
        {4'bx100,2'h0}: win = 2'h2;
        {4'b1000,2'h0}: win = 2'h3;

        {4'b0001,2'h1}: win = 2'h0;
        {4'bxx1x,2'h1}: win = 2'h1;
        {4'bx10x,2'h1}: win = 2'h2;
        {4'b100x,2'h1}: win = 2'h3;

        {4'b00x1,2'h2}: win = 2'h0;
        {4'b0010,2'h2}: win = 2'h1;
        {4'bx1xx,2'h2}: win = 2'h2;
        {4'b10xx,2'h2}: win = 2'h3;
        
        {4'b0xx1,2'h3}: win = 2'h0;
        {4'b0x10,2'h3}: win = 2'h1;
        {4'b0100,2'h3}: win = 2'h2;
        {4'b1xxx,2'h3}: win = 2'h3;

        {4'b0000,2'hx}: win = 2'h0;
    endcase
    end
endmodule 
