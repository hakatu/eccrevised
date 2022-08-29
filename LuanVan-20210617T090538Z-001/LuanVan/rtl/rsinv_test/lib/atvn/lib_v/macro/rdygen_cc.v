////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rdygen.v
// Description  : Stretch cpu ready signals for cpu interface
//                
// Author       : ddduc@HW-DDDUC
// Created On   : Wed Feb 18 13:30:44 2004
// History (Date, Changed By)
// Thu Aug 20 10:58:38 2015, cuongnv@HW-NVCUONG, change rst_ to rst
////////////////////////////////////////////////////////////////////////////////

module rdygen_cc
    (
     clk,
     pce_,
     rdyin,
     rdyout_ccxxx
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input   clk;
input   pce_;
input   rdyin;
output  rdyout_ccxxx;

wire        cerst;
assign      cerst = pce_;

reg     rdyout_ccxxx = 1'b0 /* synthesis preserve */;   // set multicycle from this signal
always @ (posedge clk)
    begin
    if (cerst)    rdyout_ccxxx <= 1'b0;
    else
        case (rdyin)
            1'b1:       rdyout_ccxxx <= rdyin;
            default:    rdyout_ccxxx <= rdyout_ccxxx;
        endcase
    end

endmodule