////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ecc_dec8.v
// Description  : Decode 8 bits data using Hamming SECDED code
//
// Author       : pmduc@HW-PMDUC
// Created On   : Mon Jun 05 15:00:15 2006
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ecc_dec8_sp
    (
     idat,
     odat,
     alarm,
     dis
     );
input   [11:0]   idat;
output [7:0]    odat;
output          alarm;
input           dis;
wire            p1,p2,p4,p8;
wire            d3,d5,d6,d7,d9,d10,d11,d12;
wire            c1,c2,c4,c8;

assign          p1 = idat[0];
assign          p2 = idat[1];
assign          p4 = idat[3];
assign          p8 = idat[7];

assign          d3 = idat[2];
assign          d5 = idat[4];
assign          d6 = idat[5];
assign          d7 = idat[6];
assign          d9 = idat[8];
assign          d10 = idat[9];
assign          d11 = idat[10];
assign          d12 = idat[11];

assign          c1 = d3 ^ d5 ^ d7 ^ d9 ^ d11;
assign          c2 = d3 ^ d6 ^ d7 ^ d10^ d11;
assign          c4 = d5 ^ d6 ^ d7 ^ d12;
assign          c8 = d9 ^ d10^ d11^ d12;

wire [3:0]      check;
assign          check = dis ? 4'b0 : ( {p8,p4,p2,p1} ^ {c8,c4,c2,c1});

wire            o3,o5,o6,o7,o9,o10,o11,o12;
assign          o3 = (check == 4'b0011) ? (!d3) : d3;
assign          o5 = (check == 4'b0101) ? (!d5) : d5;
assign          o6 = (check == 4'b0110) ? (!d6) : d6;
assign          o7 = (check == 4'b0111) ? (!d7) : d7;
assign          o9 = (check == 4'b1001) ? (!d9) : d9;
assign          o10= (check == 4'b1010) ? (!d10): d10;
assign          o11= (check == 4'b1011) ? (!d11): d11;
assign          o12= (check == 4'b1100) ? (!d12): d12;


assign          odat = {o12,o11,o10,o9,o7,o6,o5,o3};
wire            alarm;
assign          alarm = | check;

endmodule 
