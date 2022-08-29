module ippcrc_crc12_96b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [95:0]   di;

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

assign          co[11]=dx[11]^dx[10]^dx[9]^dx[4]^dx[3]^
                di[14]^di[15]^di[20]^di[21]^di[24]^di[26]^di[27]^di[30]^di[32]^di[33]^di[35]^di[36]^di[37]^di[38]^di[42]^di[44]^di[45]^di[46]^di[47]^di[48]^di[49]^di[52]^di[61]^di[62]^di[63]^di[66]^di[67]^di[70]^di[71]^di[72]^di[73]^di[74]^di[79]^di[80]^di[81]^di[82]^di[83]^di[84]^di[85]^di[88]^di[89]^di[90]^di[91]^di[92]^di[93]^di[94]^di[95];

assign          co[10]=dx[11]^dx[8]^dx[4]^dx[2]^
                di[14]^di[16]^di[20]^di[22]^di[24]^di[25]^di[26]^di[28]^di[30]^di[31]^di[32]^di[34]^di[35]^di[39]^di[42]^di[43]^di[44]^di[50]^di[52]^di[53]^di[61]^di[64]^di[66]^di[68]^di[70]^di[75]^di[79]^di[86]^di[88];

assign          co[9]=dx[10]^dx[7]^dx[3]^dx[1]^
                di[15]^di[17]^di[21]^di[23]^di[25]^di[26]^di[27]^di[29]^di[31]^di[32]^di[33]^di[35]^di[36]^di[40]^di[43]^di[44]^di[45]^di[51]^di[53]^di[54]^di[62]^di[65]^di[67]^di[69]^di[71]^di[76]^di[80]^di[87]^di[89];

assign          co[8]=dx[9]^dx[6]^dx[2]^dx[0]^
                di[16]^di[18]^di[22]^di[24]^di[26]^di[27]^di[28]^di[30]^di[32]^di[33]^di[34]^di[36]^di[37]^di[41]^di[44]^di[45]^di[46]^di[52]^di[54]^di[55]^di[63]^di[66]^di[68]^di[70]^di[72]^di[77]^di[81]^di[88]^di[90];

assign          co[7]=dx[8]^dx[5]^dx[1]^
                di[12]^di[17]^di[19]^di[23]^di[25]^di[27]^di[28]^di[29]^di[31]^di[33]^di[34]^di[35]^di[37]^di[38]^di[42]^di[45]^di[46]^di[47]^di[53]^di[55]^di[56]^di[64]^di[67]^di[69]^di[71]^di[73]^di[78]^di[82]^di[89]^di[91];

assign          co[6]=dx[11]^dx[7]^dx[4]^dx[0]^
                di[13]^di[18]^di[20]^di[24]^di[26]^di[28]^di[29]^di[30]^di[32]^di[34]^di[35]^di[36]^di[38]^di[39]^di[43]^di[46]^di[47]^di[48]^di[54]^di[56]^di[57]^di[65]^di[68]^di[70]^di[72]^di[74]^di[79]^di[83]^di[90]^di[92];

assign          co[5]=dx[10]^dx[6]^dx[3]^
                di[12]^di[14]^di[19]^di[21]^di[25]^di[27]^di[29]^di[30]^di[31]^di[33]^di[35]^di[36]^di[37]^di[39]^di[40]^di[44]^di[47]^di[48]^di[49]^di[55]^di[57]^di[58]^di[66]^di[69]^di[71]^di[73]^di[75]^di[80]^di[84]^di[91]^di[93];

assign          co[4]=dx[11]^dx[9]^dx[5]^dx[2]^
                di[13]^di[15]^di[20]^di[22]^di[26]^di[28]^di[30]^di[31]^di[32]^di[34]^di[36]^di[37]^di[38]^di[40]^di[41]^di[45]^di[48]^di[49]^di[50]^di[56]^di[58]^di[59]^di[67]^di[70]^di[72]^di[74]^di[76]^di[81]^di[85]^di[92]^di[94];

assign          co[3]=dx[10]^dx[8]^dx[4]^dx[1]^
                di[14]^di[16]^di[21]^di[23]^di[27]^di[29]^di[31]^di[32]^di[33]^di[35]^di[37]^di[38]^di[39]^di[41]^di[42]^di[46]^di[49]^di[50]^di[51]^di[57]^di[59]^di[60]^di[68]^di[71]^di[73]^di[75]^di[77]^di[82]^di[86]^di[93]^di[95];

assign          co[2]=dx[10]^dx[7]^dx[4]^dx[0]^
                di[14]^di[17]^di[20]^di[21]^di[22]^di[26]^di[27]^di[28]^di[34]^di[35]^di[37]^di[39]^di[40]^di[43]^di[44]^di[45]^di[46]^di[48]^di[49]^di[50]^di[51]^di[58]^di[60]^di[62]^di[63]^di[66]^di[67]^di[69]^di[70]^di[71]^di[73]^di[76]^di[78]^di[79]^di[80]^di[81]^di[82]^di[84]^di[85]^di[87]^di[88]^di[89]^di[90]^di[91]^di[92]^di[93]^di[95];

assign          co[1]=dx[10]^dx[6]^dx[4]^
                di[12]^di[14]^di[18]^di[20]^di[22]^di[23]^di[24]^di[26]^di[28]^di[29]^di[30]^di[32]^di[33]^di[37]^di[40]^di[41]^di[42]^di[48]^di[50]^di[51]^di[59]^di[62]^di[64]^di[66]^di[68]^di[73]^di[77]^di[84]^di[86]^di[95];

assign          co[0]=dx[11]^dx[10]^dx[5]^dx[4]^
                di[13]^di[14]^di[19]^di[20]^di[23]^di[25]^di[26]^di[29]^di[31]^di[32]^di[34]^di[35]^di[36]^di[37]^di[41]^di[43]^di[44]^di[45]^di[46]^di[47]^di[48]^di[51]^di[60]^di[61]^di[62]^di[65]^di[66]^di[69]^di[70]^di[71]^di[72]^di[73]^di[78]^di[79]^di[80]^di[81]^di[82]^di[83]^di[84]^di[87]^di[88]^di[89]^di[90]^di[91]^di[92]^di[93]^di[94]^di[95];


endmodule
