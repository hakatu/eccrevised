////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : carr_sense.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Aug 18 16:32:28 2004
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_carr_sense
    (clk,//@txclk
     rst_,
     rep_mode,
     transmitting,
     receiving,
     crs
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   clk, rst_, rep_mode, transmitting, receiving;
output  crs;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter CARR_OFF = 1'b0;
parameter CARR_ON  = 1'b1;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg       carr_state;
wire      sreceiving;
fflopx #(1) plrx (clk,rst_, receiving, sreceiving);
 
always @ (carr_state or rep_mode or transmitting or sreceiving)
    begin
    case (carr_state)
        CARR_OFF:
            begin
            if ((~rep_mode & transmitting) | sreceiving) 
                carr_state = CARR_ON;
            else    carr_state = CARR_OFF;          
            end
        CARR_ON:
            begin
            if ((rep_mode | ~transmitting) & ~sreceiving)
                carr_state = CARR_OFF;
            else    carr_state = CARR_ON;
            end
        default: carr_state = CARR_OFF;     
    endcase
    end

reg crs;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)                          crs <= 1'b0;
    else if (carr_state == CARR_OFF)    crs <= 1'b0;
    else                                crs <= 1'b1;
    end

endmodule 
