////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4_ipoh_vote8
// Description  : .
//
// Author       : lvquoc@HW-LVQUOC
// Created On   : Fri Aug 20 10:24:16 2004
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4_ipoh_vote8
    (
     req,
     prior,
     win,
     winval
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   [7:0]  req;    // requests arbitration
input   [2:0]   prior;  // priority base
output  [2:0]   win;    // request winner
output          winval; // winner valid

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire    [2:0]   win;
wire            winval;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire    [3:0]   win_stage0;
wire    [1:0]   win_stage_val0;

reg [1:0]       stage0;
reg             win_stage1;

af4_ipoh_vote4    vote40(.req(req[3:0]),.prior(prior[1:0]),.win(win_stage0[1:0]),.winval(win_stage_val0[0]));
af4_ipoh_vote4    vote41(.req(req[7:4]),.prior(prior[1:0]),.win(win_stage0[3:2]),.winval(win_stage_val0[1]));

assign          winval = |win_stage_val0;

always @ (win_stage_val0 or prior[2])
    begin
    casex ({win_stage_val0,prior[2]})
        {2'bx1,1'b0}: win_stage1 = 1'h0;
        {2'b10,1'b0}: win_stage1 = 1'h1;
        
        {2'b01,1'b1}: win_stage1 = 1'h0;
        {2'b1x,1'b1}: win_stage1 = 1'h1;
        
        {2'b00,1'bx}: win_stage1 = 1'h0;
    endcase
    end

always @ (win_stage0 or win_stage1)
    begin
    case (win_stage1)
        1'b0:   stage0[1:0] = win_stage0[1:0];
        1'b1:   stage0[1:0] = win_stage0[3:2];
        default:stage0[1:0] = win_stage0[1:0];
    endcase 
    end

assign          win = {win_stage1,stage0};

endmodule 

