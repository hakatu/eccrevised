////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ecc_enc8.v
// Description  : Encode 8 bits data using Hamming SEC code
//
// Author       : pmduc@HW-PMDUC
// Created On   : Mon Jun 05 14:45:19 2006
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ecc_enc8
    (
     idat,
     odat    
     );
input   [7:0]   idat;
output  [11:0]   odat;
wire            p1,p2,p4,p8;
wire			d3,d5,d6,d7,d9,d10,d11,d12;
assign			{d12,d11,d10,d9,d7,d6,d5,d3} = idat;
assign          p1 = d3 ^ d5 ^ d7 ^ d9 ^ d11;
assign          p2 = d3 ^ d6 ^ d7 ^ d10^ d11;
assign          p4 = d5 ^ d6 ^ d7 ^ d12;
assign          p8 = d9 ^ d10^ d11^ d12;
assign          odat = {d12,d11,d10,d9,p8,d7,d6,d5,p4,d3,p2,p1};
endmodule 
