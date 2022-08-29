module ippcrc_crc12_112b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [111:0]   di;

output [11:0]  co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [11:0]    co;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [11:0]     swdi;
assign          swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11]};

wire [11:0]     dx;
assign          dx   =  ci[11:0]^swdi[11:0];

assign          co[11]=dx[8]^dx[7]^dx[4]^dx[1]^dx[0]^
                di[16]^di[17]^di[18]^di[23]^di[24]^di[30]^di[31]^di[36]^di[37]^di[40]^di[42]^di[43]^di[46]^di[48]^di[49]^di[51]^di[52]^di[53]^di[54]^di[58]^di[60]^di[61]^di[62]^di[63]^di[64]^di[65]^di[68]^di[77]^di[78]^di[79]^di[82]^di[83]^di[86]^di[87]^di[88]^di[89]^di[90]^di[95]^di[96]^di[97]^di[98]^di[99]^di[100]^di[101]^di[104]^di[105]^di[106]^di[107]^di[108]^di[109]^di[110]^di[111];

assign          co[10]=dx[8]^dx[6]^dx[4]^dx[3]^dx[1]^
                di[12]^di[16]^di[19]^di[23]^di[25]^di[30]^di[32]^di[36]^di[38]^di[40]^di[41]^di[42]^di[44]^di[46]^di[47]^di[48]^di[50]^di[51]^di[55]^di[58]^di[59]^di[60]^di[66]^di[68]^di[69]^di[77]^di[80]^di[82]^di[84]^di[86]^di[91]^di[95]^di[102]^di[104];

assign          co[9]=dx[7]^dx[5]^dx[3]^dx[2]^dx[0]^
                di[13]^di[17]^di[20]^di[24]^di[26]^di[31]^di[33]^di[37]^di[39]^di[41]^di[42]^di[43]^di[45]^di[47]^di[48]^di[49]^di[51]^di[52]^di[56]^di[59]^di[60]^di[61]^di[67]^di[69]^di[70]^di[78]^di[81]^di[83]^di[85]^di[87]^di[92]^di[96]^di[103]^di[105];

assign          co[8]=dx[11]^dx[6]^dx[4]^dx[2]^dx[1]^
                di[12]^di[14]^di[18]^di[21]^di[25]^di[27]^di[32]^di[34]^di[38]^di[40]^di[42]^di[43]^di[44]^di[46]^di[48]^di[49]^di[50]^di[52]^di[53]^di[57]^di[60]^di[61]^di[62]^di[68]^di[70]^di[71]^di[79]^di[82]^di[84]^di[86]^di[88]^di[93]^di[97]^di[104]^di[106];

assign          co[7]=dx[11]^dx[10]^dx[5]^dx[3]^dx[1]^dx[0]^
                di[13]^di[15]^di[19]^di[22]^di[26]^di[28]^di[33]^di[35]^di[39]^di[41]^di[43]^di[44]^di[45]^di[47]^di[49]^di[50]^di[51]^di[53]^di[54]^di[58]^di[61]^di[62]^di[63]^di[69]^di[71]^di[72]^di[80]^di[83]^di[85]^di[87]^di[89]^di[94]^di[98]^di[105]^di[107];

assign          co[6]=dx[10]^dx[9]^dx[4]^dx[2]^dx[0]^
                di[12]^di[14]^di[16]^di[20]^di[23]^di[27]^di[29]^di[34]^di[36]^di[40]^di[42]^di[44]^di[45]^di[46]^di[48]^di[50]^di[51]^di[52]^di[54]^di[55]^di[59]^di[62]^di[63]^di[64]^di[70]^di[72]^di[73]^di[81]^di[84]^di[86]^di[88]^di[90]^di[95]^di[99]^di[106]^di[108];

assign          co[5]=dx[9]^dx[8]^dx[3]^dx[1]^
                di[12]^di[13]^di[15]^di[17]^di[21]^di[24]^di[28]^di[30]^di[35]^di[37]^di[41]^di[43]^di[45]^di[46]^di[47]^di[49]^di[51]^di[52]^di[53]^di[55]^di[56]^di[60]^di[63]^di[64]^di[65]^di[71]^di[73]^di[74]^di[82]^di[85]^di[87]^di[89]^di[91]^di[96]^di[100]^di[107]^di[109];

assign          co[4]=dx[8]^dx[7]^dx[2]^dx[0]^
                di[13]^di[14]^di[16]^di[18]^di[22]^di[25]^di[29]^di[31]^di[36]^di[38]^di[42]^di[44]^di[46]^di[47]^di[48]^di[50]^di[52]^di[53]^di[54]^di[56]^di[57]^di[61]^di[64]^di[65]^di[66]^di[72]^di[74]^di[75]^di[83]^di[86]^di[88]^di[90]^di[92]^di[97]^di[101]^di[108]^di[110];

assign          co[3]=dx[7]^dx[6]^dx[1]^
                di[12]^di[14]^di[15]^di[17]^di[19]^di[23]^di[26]^di[30]^di[32]^di[37]^di[39]^di[43]^di[45]^di[47]^di[48]^di[49]^di[51]^di[53]^di[54]^di[55]^di[57]^di[58]^di[62]^di[65]^di[66]^di[67]^di[73]^di[75]^di[76]^di[84]^di[87]^di[89]^di[91]^di[93]^di[98]^di[102]^di[109]^di[111];

assign          co[2]=dx[11]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[1]^
                di[13]^di[15]^di[17]^di[20]^di[23]^di[27]^di[30]^di[33]^di[36]^di[37]^di[38]^di[42]^di[43]^di[44]^di[50]^di[51]^di[53]^di[55]^di[56]^di[59]^di[60]^di[61]^di[62]^di[64]^di[65]^di[66]^di[67]^di[74]^di[76]^di[78]^di[79]^di[82]^di[83]^di[85]^di[86]^di[87]^di[89]^di[92]^di[94]^di[95]^di[96]^di[97]^di[98]^di[100]^di[101]^di[103]^di[104]^di[105]^di[106]^di[107]^di[108]^di[109]^di[111];

assign          co[1]=dx[10]^dx[8]^dx[6]^dx[5]^dx[3]^dx[1]^
                di[14]^di[17]^di[21]^di[23]^di[28]^di[30]^di[34]^di[36]^di[38]^di[39]^di[40]^di[42]^di[44]^di[45]^di[46]^di[48]^di[49]^di[53]^di[56]^di[57]^di[58]^di[64]^di[66]^di[67]^di[75]^di[78]^di[80]^di[82]^di[84]^di[89]^di[93]^di[100]^di[102]^di[111];

assign          co[0]=dx[9]^dx[8]^dx[5]^dx[2]^dx[1]^
                di[15]^di[16]^di[17]^di[22]^di[23]^di[29]^di[30]^di[35]^di[36]^di[39]^di[41]^di[42]^di[45]^di[47]^di[48]^di[50]^di[51]^di[52]^di[53]^di[57]^di[59]^di[60]^di[61]^di[62]^di[63]^di[64]^di[67]^di[76]^di[77]^di[78]^di[81]^di[82]^di[85]^di[86]^di[87]^di[88]^di[89]^di[94]^di[95]^di[96]^di[97]^di[98]^di[99]^di[100]^di[103]^di[104]^di[105]^di[106]^di[107]^di[108]^di[109]^di[110]^di[111];

endmodule