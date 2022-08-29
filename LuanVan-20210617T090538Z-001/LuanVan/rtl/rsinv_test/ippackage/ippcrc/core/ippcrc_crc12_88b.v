module ippcrc_crc12_88b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [87:0]   di;

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

assign          co[11]=dx[11]^dx[5]^dx[4]^
                di[12]^di[13]^di[16]^di[18]^di[19]^di[22]^di[24]^di[25]^di[27]^di[28]^di[29]^di[30]^di[34]^di[36]^di[37]^di[38]^di[39]^di[40]^di[41]^di[44]^di[53]^di[54]^di[55]^di[58]^di[59]^di[62]^di[63]^di[64]^di[65]^di[66]^di[71]^di[72]^di[73]^di[74]^di[75]^di[76]^di[77]^di[80]^di[81]^di[82]^di[83]^di[84]^di[85]^di[86]^di[87];

assign          co[10]=dx[10]^dx[5]^dx[3]^
                di[12]^di[14]^di[16]^di[17]^di[18]^di[20]^di[22]^di[23]^di[24]^di[26]^di[27]^di[31]^di[34]^di[35]^di[36]^di[42]^di[44]^di[45]^di[53]^di[56]^di[58]^di[60]^di[62]^di[67]^di[71]^di[78]^di[80];

assign          co[9]=dx[11]^dx[9]^dx[4]^dx[2]^
                di[13]^di[15]^di[17]^di[18]^di[19]^di[21]^di[23]^di[24]^di[25]^di[27]^di[28]^di[32]^di[35]^di[36]^di[37]^di[43]^di[45]^di[46]^di[54]^di[57]^di[59]^di[61]^di[63]^di[68]^di[72]^di[79]^di[81];

assign          co[8]=dx[10]^dx[8]^dx[3]^dx[1]^
                di[14]^di[16]^di[18]^di[19]^di[20]^di[22]^di[24]^di[25]^di[26]^di[28]^di[29]^di[33]^di[36]^di[37]^di[38]^di[44]^di[46]^di[47]^di[55]^di[58]^di[60]^di[62]^di[64]^di[69]^di[73]^di[80]^di[82];

assign          co[7]=dx[9]^dx[7]^dx[2]^dx[0]^
                di[15]^di[17]^di[19]^di[20]^di[21]^di[23]^di[25]^di[26]^di[27]^di[29]^di[30]^di[34]^di[37]^di[38]^di[39]^di[45]^di[47]^di[48]^di[56]^di[59]^di[61]^di[63]^di[65]^di[70]^di[74]^di[81]^di[83];

assign          co[6]=dx[8]^dx[6]^dx[1]^
                di[12]^di[16]^di[18]^di[20]^di[21]^di[22]^di[24]^di[26]^di[27]^di[28]^di[30]^di[31]^di[35]^di[38]^di[39]^di[40]^di[46]^di[48]^di[49]^di[57]^di[60]^di[62]^di[64]^di[66]^di[71]^di[75]^di[82]^di[84];

assign          co[5]=dx[11]^dx[7]^dx[5]^dx[0]^
                di[13]^di[17]^di[19]^di[21]^di[22]^di[23]^di[25]^di[27]^di[28]^di[29]^di[31]^di[32]^di[36]^di[39]^di[40]^di[41]^di[47]^di[49]^di[50]^di[58]^di[61]^di[63]^di[65]^di[67]^di[72]^di[76]^di[83]^di[85];

assign          co[4]=dx[10]^dx[6]^dx[4]^
                di[12]^di[14]^di[18]^di[20]^di[22]^di[23]^di[24]^di[26]^di[28]^di[29]^di[30]^di[32]^di[33]^di[37]^di[40]^di[41]^di[42]^di[48]^di[50]^di[51]^di[59]^di[62]^di[64]^di[66]^di[68]^di[73]^di[77]^di[84]^di[86];

assign          co[3]=dx[9]^dx[5]^dx[3]^
                di[13]^di[15]^di[19]^di[21]^di[23]^di[24]^di[25]^di[27]^di[29]^di[30]^di[31]^di[33]^di[34]^di[38]^di[41]^di[42]^di[43]^di[49]^di[51]^di[52]^di[60]^di[63]^di[65]^di[67]^di[69]^di[74]^di[78]^di[85]^di[87];

assign          co[2]=dx[8]^dx[5]^dx[2]^
                di[12]^di[13]^di[14]^di[18]^di[19]^di[20]^di[26]^di[27]^di[29]^di[31]^di[32]^di[35]^di[36]^di[37]^di[38]^di[40]^di[41]^di[42]^di[43]^di[50]^di[52]^di[54]^di[55]^di[58]^di[59]^di[61]^di[62]^di[63]^di[65]^di[68]^di[70]^di[71]^di[72]^di[73]^di[74]^di[76]^di[77]^di[79]^di[80]^di[81]^di[82]^di[83]^di[84]^di[85]^di[87];

assign          co[1]=dx[7]^dx[5]^dx[1]^
                di[12]^di[14]^di[15]^di[16]^di[18]^di[20]^di[21]^di[22]^di[24]^di[25]^di[29]^di[32]^di[33]^di[34]^di[40]^di[42]^di[43]^di[51]^di[54]^di[56]^di[58]^di[60]^di[65]^di[69]^di[76]^di[78]^di[87];

assign          co[0]=dx[6]^dx[5]^dx[0]^
                di[12]^di[15]^di[17]^di[18]^di[21]^di[23]^di[24]^di[26]^di[27]^di[28]^di[29]^di[33]^di[35]^di[36]^di[37]^di[38]^di[39]^di[40]^di[43]^di[52]^di[53]^di[54]^di[57]^di[58]^di[61]^di[62]^di[63]^di[64]^di[65]^di[70]^di[71]^di[72]^di[73]^di[74]^di[75]^di[76]^di[79]^di[80]^di[81]^di[82]^di[83]^di[84]^di[85]^di[86]^di[87];


endmodule
