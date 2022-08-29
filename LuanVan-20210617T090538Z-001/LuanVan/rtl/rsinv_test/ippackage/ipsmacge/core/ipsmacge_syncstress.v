////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_syncstress.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Thu Jul 03 14:00:24 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_syncstress
    (
     rst_,
     iclk,
     idat,
     odat
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter NUM_DW  = 2;

////////////////////////////////////////////////////////////////////////////////
// input declarations
input     rst_;
input     iclk;
input     idat;
output    odat;

////////////////////////////////////////////////////////////////////////////////
// signal declarations0
reg [NUM_DW-1:0] cnt_nstress;
reg              edat;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

always @(posedge iclk or negedge rst_)
    begin
    if (!rst_)              cnt_nstress <= {NUM_DW{1'b0}};
    else if (idat)          cnt_nstress <= {NUM_DW{1'b0}} + 1'b1;
    else if (|cnt_nstress)  cnt_nstress <= cnt_nstress + 1'b1;
    end

always @(posedge iclk or negedge rst_)
    begin
    if (!rst_)              edat <= 1'b0;
    else if (idat)          edat <= 1'b1;
    else if (|cnt_nstress)  edat <= 1'b1;
    else                    edat <= 1'b0;
    end
assign odat = edat;

endmodule
