////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_mapause.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Wed Jan 14 14:58:25 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_mapause
    (
     marst_,
     maclk,
     // Pau Terminate
     ma_ipauvld,
     ma_ipauqua,

     opauqua,
     opauvld,

     pwnum
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// input declarations
input               marst_;
input               maclk;

input               ma_ipauvld;
input [15:0]        ma_ipauqua;

output [15:0]       opauqua;
output              opauvld;

input [5:0]         pwnum;

////////////////////////////////////////////////////////////////////////////////
// signal declarations0

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

fflopxe #(16) ffcappauqua (maclk, marst_, ma_ipauvld, ma_ipauqua, opauqua);

reg [5:0] cntpauvld;
wire      cntpauend;
assign    cntpauend = (cntpauvld >= pwnum);

always @(posedge maclk or negedge marst_)
    begin
    if (~marst_)            cntpauvld <= 6'b0;
    else if (ma_ipauvld)    cntpauvld <= 6'b1;
    else if (|cntpauvld)    cntpauvld <= cntpauend ? 6'b0 : cntpauvld + 1'b1;
    end

reg opauvld;

always @(posedge maclk or negedge marst_)
    begin
    if (!marst_)            opauvld <= 1'b0;
    else if (ma_ipauvld)     opauvld <= 1'b1;
    else                    opauvld <= (|cntpauvld) ? 1'b1 : 1'b0;
    end
              
endmodule
