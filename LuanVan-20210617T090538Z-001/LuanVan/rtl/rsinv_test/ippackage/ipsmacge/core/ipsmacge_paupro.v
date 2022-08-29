////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_paupro.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Wed Jan 14 14:23:21 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_paupro
    (
     txrst_,
     txclk,
     ipauen,
     ipaudi,
     
     possfd,
     //
     opauen,
     opaudi,
     //
     ppaudis
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// port declarations
input       txrst_;
input       txclk;

input       ipauen;
input       ipaudi;

input       possfd;

output      opauen;
output      opaudi;

input       ppaudis;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// Pause Gen
reg         opauen;
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        opauen <= 1'b0;
    else if (ppaudis)   opauen <= 1'b0;
    else
        begin
        case ({ipauen, possfd})
            2'b10:      opauen <= 1'b1;
            2'b11:      opauen <= 1'b1;
            2'b01:      opauen <= 1'b0;
            default:    opauen <= opauen;
        endcase
        end
    end

// Pause Dis
reg         opaudi; 
always @(posedge txclk or negedge txrst_) 
    begin
    if (!txrst_)        opaudi <= 1'b0;
    else if (ppaudis)   opaudi <= 1'b0;
    else                opaudi <= ipaudi;
    end

endmodule 
