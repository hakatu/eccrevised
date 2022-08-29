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

module rdygen
    (
     rst,
     clk,
     pce_,
     scanmode,
     rdyin,
     rdyout
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input   rst;
input   clk;
input   pce_;
input   scanmode;
input   rdyin;
output  rdyout;

// removed this equation due to erroring under scan synthesis
//wire cerst_ = ~((pce_ | ~rst_) & (!scanmode)); // in case chip enable is short

//wire cerst_ = scanmode ? rst_ :
//                         (~(pce_ | ~rst_)); // in case chip enable is short

wire        cerst;
assign      cerst = rst | pce_;

/* -----\/----- EXCLUDED -----\/-----
atmux1 scmux
    (
     .a(rst_),
     .b(~(pce_ | ~rst_)),
     .sela(scanmode),
     .o(cerst_)
     );
 -----/\----- EXCLUDED -----/\----- */

//wire cerst_ = ~((pce_ & (!scanmode)) | ~rst_); // in case chip enable is short

reg     rdystatic;
//always @(posedge clk or negedge cerst_)
always @(posedge clk or posedge cerst)
    if (cerst)    rdystatic <= 1'b0;
    else
        begin
//        if(rdyin)   rdystatic <= 1'b1;
        if(rdyin)   rdystatic <= rdyin;
        else        rdystatic <= rdystatic;
        end

assign rdyout   = rdystatic;

endmodule