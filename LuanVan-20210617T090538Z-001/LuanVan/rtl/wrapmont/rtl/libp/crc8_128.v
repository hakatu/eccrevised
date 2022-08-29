  // polynomial: x^8 + 1 (not use x^8 + x^2 + x^1 + 1 due to timing for 20G MRO)
  // data width: 128
  // convention: the first serial bit is D[127]

module crc8_128
    (
     idat,
     icrc,
     ocrc
     );

input [127:0] idat;
input [7:0]   icrc;
output [7:0]  ocrc;

assign ocrc[0] = idat[120]^idat[112]^idat[104]^idat[96]^idat[88]^idat[80]^idat[72]^idat[64]^idat[56]^idat[48]^idat[40]^idat[32]^idat[24]^idat[16]^idat[8]^idat[0]^icrc[0];
assign ocrc[1] = idat[121]^idat[113]^idat[105]^idat[97]^idat[89]^idat[81]^idat[73]^idat[65]^idat[57]^idat[49]^idat[41]^idat[33]^idat[25]^idat[17]^idat[9]^idat[1]^icrc[1];
assign ocrc[2] = idat[122]^idat[114]^idat[106]^idat[98]^idat[90]^idat[82]^idat[74]^idat[66]^idat[58]^idat[50]^idat[42]^idat[34]^idat[26]^idat[18]^idat[10]^idat[2]^icrc[2];
assign ocrc[3] = idat[123]^idat[115]^idat[107]^idat[99]^idat[91]^idat[83]^idat[75]^idat[67]^idat[59]^idat[51]^idat[43]^idat[35]^idat[27]^idat[19]^idat[11]^idat[3]^icrc[3];
assign ocrc[4] = idat[124]^idat[116]^idat[108]^idat[100]^idat[92]^idat[84]^idat[76]^idat[68]^idat[60]^idat[52]^idat[44]^idat[36]^idat[28]^idat[20]^idat[12]^idat[4]^icrc[4];
assign ocrc[5] = idat[125]^idat[117]^idat[109]^idat[101]^idat[93]^idat[85]^idat[77]^idat[69]^idat[61]^idat[53]^idat[45]^idat[37]^idat[29]^idat[21]^idat[13]^idat[5]^icrc[5];
assign ocrc[6] = idat[126]^idat[118]^idat[110]^idat[102]^idat[94]^idat[86]^idat[78]^idat[70]^idat[62]^idat[54]^idat[46]^idat[38]^idat[30]^idat[22]^idat[14]^idat[6]^icrc[6];
assign ocrc[7] = idat[127]^idat[119]^idat[111]^idat[103]^idat[95]^idat[87]^idat[79]^idat[71]^idat[63]^idat[55]^idat[47]^idat[39]^idat[31]^idat[23]^idat[15]^idat[7]^icrc[7];

endmodule
