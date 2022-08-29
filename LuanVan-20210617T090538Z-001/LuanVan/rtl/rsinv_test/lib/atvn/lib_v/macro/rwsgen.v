////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rwsgen.v
// Description  : read/write strobe generator
//
// Author       : ddduc@HW-DDDUC
// Created On   : Wed Feb 18 10:51:31 2004
// History (Date, Changed By)
// Thu Aug 20 11:12:11 2015 cuongnv@HW-NVCUONG change rst_ to rst
////////////////////////////////////////////////////////////////////////////////

module rwsgen
    (
     clk,
     rst,
     pce_,
     prnw,
     pws,
     prs,
     scanmode
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input   clk,
        rst,
        pce_,
        prnw;
input   scanmode;
output  pws,
        prs;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// removed this equation due to erroring under scan synthesis
//wire cerst_ = ~((pce_ | ~rst_) & (!scanmode)); // in case chip enable is short

//wire cerst_ = scanmode ? rst_ :
//                         (~(pce_ | ~rst_)); // in case chip enable is short

wire    cerst;
assign  cerst = rst | pce_;

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

reg [7:0]   rin;
always @(posedge clk or posedge cerst)
    begin
    if(cerst) rin <= {8{1'b1}};
    // removed this equation due to erroring under scan synthesis
    //    else rin <= {rin[1:0],1'b1};
    //else rin <= {rin[6:0],(~pce_)};
    else rin <= {rin[6:0],pce_};
    end

//wire    pul = ~rin[7] & rin[6];
reg pul = 1'b0;
always @(posedge clk)
    begin
    //if(!rst_) pul <= 1'b0;
    pul <= (rin[7:4] == 4'b1100);
    end

reg [1:0] rprnw = 2'd0;
always @(posedge clk)
    begin
    //if(!rst_) rprnw <= 2'b0;
    rprnw <= {rprnw[0],prnw};
    end

reg     pws = 1'b0;
reg     prs = 1'b0;
always @(posedge clk)
    begin
//    if(!rst_)
//        begin
//        pws <= 1'b0;
//        prs <= 1'b0;
//        end
//    else 
//        begin
        pws <= ~rprnw[1] & pul;
        prs <= rprnw[1] & pul;
//        end
    end

endmodule 


