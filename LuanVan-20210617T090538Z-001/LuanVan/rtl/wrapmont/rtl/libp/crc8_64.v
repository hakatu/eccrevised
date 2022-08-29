//-----------------------------------------------------------------------------
// CRC module for data[63:0] ,   crc[7:0]=1+x^1+x^2+x^8;
//-----------------------------------------------------------------------------
module crc8_64
    (
     idat,
     icrc,
     ocrc
     );

input [63:0] idat;
input [7:0]  icrc;
output [7:0] ocrc;

assign ocrc[0] = (icrc[0]^icrc[4]^icrc[7]^idat[0]^idat[6]^idat[7]^idat[8]^idat[12]^idat[14]^idat[16]^idat[18]^idat[19]^idat[21]^idat[23]^idat[28]^idat[30]^
                  idat[31]^idat[34]^idat[35]^idat[39]^idat[40]^idat[43]^idat[45]^idat[48]^idat[49]^idat[50]^idat[52]^idat[53]^idat[54]^idat[56]^idat[60]^idat[63]);
assign ocrc[1] = (icrc[0]^icrc[1]^icrc[4]^icrc[5]^icrc[7]^idat[0]^idat[1]^idat[6]^idat[9]^idat[12]^idat[13]^idat[14]^idat[15]^idat[16]^idat[17]^idat[18]^idat[20]^idat[21]^idat[22]^idat[23]^
                  idat[24]^idat[28]^idat[29]^idat[30]^idat[32]^idat[34]^idat[36]^idat[39]^idat[41]^idat[43]^idat[44]^idat[45]^idat[46]^idat[48]^idat[51]^idat[52]^idat[55]^idat[56]^idat[57]^idat[60]^idat[61]^idat[63]);
assign ocrc[2] = (icrc[1]^icrc[2]^icrc[4]^icrc[5]^icrc[6]^icrc[7]^idat[0]^idat[1]^idat[2]^idat[6]^idat[8]^idat[10]^idat[12]^idat[13]^idat[15]^idat[17]^idat[22]^idat[24]^idat[25]^idat[28]^
                  idat[29]^idat[33]^idat[34]^idat[37]^idat[39]^idat[42]^idat[43]^idat[44]^idat[46]^idat[47]^idat[48]^idat[50]^idat[54]^idat[57]^idat[58]^idat[60]^idat[61]^idat[62]^idat[63]);
assign ocrc[3] = (icrc[2]^icrc[3]^icrc[5]^icrc[6]^icrc[7]^idat[1]^idat[2]^idat[3]^idat[7]^idat[9]^idat[11]^idat[13]^idat[14]^idat[16]^idat[18]^idat[23]^idat[25]^idat[26]^idat[29]^idat[30]^
                  idat[34]^idat[35]^idat[38]^idat[40]^idat[43]^idat[44]^idat[45]^idat[47]^idat[48]^idat[49]^idat[51]^idat[55]^idat[58]^idat[59]^idat[61]^idat[62]^idat[63]);
assign ocrc[4] = (icrc[0]^icrc[3]^icrc[4]^icrc[6]^icrc[7]^idat[2]^idat[3]^idat[4]^idat[8]^idat[10]^idat[12]^idat[14]^idat[15]^idat[17]^idat[19]^idat[24]^idat[26]^idat[27]^idat[30]^idat[31]^
                  idat[35]^idat[36]^idat[39]^idat[41]^idat[44]^idat[45]^idat[46]^idat[48]^idat[49]^idat[50]^idat[52]^idat[56]^idat[59]^idat[60]^idat[62]^idat[63]);
assign ocrc[5] = (icrc[1]^icrc[4]^icrc[5]^icrc[7]^idat[3]^idat[4]^idat[5]^idat[9]^idat[11]^idat[13]^idat[15]^idat[16]^idat[18]^idat[20]^idat[25]^idat[27]^idat[28]^idat[31]^idat[32]^idat[36]^
                  idat[37]^idat[40]^idat[42]^idat[45]^idat[46]^idat[47]^idat[49]^idat[50]^idat[51]^idat[53]^idat[57]^idat[60]^idat[61]^idat[63]);
assign ocrc[6] = (icrc[2]^icrc[5]^icrc[6]^idat[4]^idat[5]^idat[6]^idat[10]^idat[12]^idat[14]^idat[16]^idat[17]^idat[19]^idat[21]^idat[26]^idat[28]^idat[29]^idat[32]^idat[33]^idat[37]^idat[38]^
                  idat[41]^idat[43]^idat[46]^idat[47]^idat[48]^idat[50]^idat[51]^idat[52]^idat[54]^idat[58]^idat[61]^idat[62]);
assign ocrc[7] = (icrc[3]^icrc[6]^icrc[7]^idat[5]^idat[6]^idat[7]^idat[11]^idat[13]^idat[15]^idat[17]^idat[18]^idat[20]^idat[22]^idat[27]^idat[29]^idat[30]^idat[33]^idat[34]^idat[38]^idat[39]^
                  idat[42]^idat[44]^idat[47]^idat[48]^idat[49]^idat[51]^idat[52]^idat[53]^idat[55]^idat[59]^idat[62]^idat[63]);

endmodule