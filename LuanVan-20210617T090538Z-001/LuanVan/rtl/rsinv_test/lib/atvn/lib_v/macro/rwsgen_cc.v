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

module rwsgen_cc
    (
     clk,
     pce_,
     prnw,
     pws,
     prs,
     pcesyn_
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input   clk,
        pce_,
        prnw;
output  pws,
        prs,
        pcesyn_;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire    cerst;
assign  cerst = pce_;

reg [4:0]   rin = {5{1'b1}};
always @(posedge clk)
    begin
    if(cerst) rin <= {5{1'b1}};
    else rin <= {rin[3:0],pce_};
    end

reg pul = 1'b0;
always @(posedge clk)
    begin
    pul <= (rin[4:1] == 4'b1100);
    end

reg [1:0] rprnw = 2'd0;
always @(posedge clk)
    begin
    rprnw <= {rprnw[0],prnw};
    end

reg     pws = 1'b0;
reg     prs = 1'b0;
always @(posedge clk)
    begin
    pws <= ~rprnw[1] & pul;
    prs <= rprnw[1] & pul;
    end

assign  pcesyn_ = rin[1];
    
endmodule 


