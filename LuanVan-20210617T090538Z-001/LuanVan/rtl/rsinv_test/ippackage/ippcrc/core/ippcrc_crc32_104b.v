////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : crc32_104b.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Fri Aug 10 10:20:52 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcrc_crc32_104b
    (
     ci,
     di,

     co
     );
////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   [31:0]  ci;
input   [103:0]  di;

output [31:0]   co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [31:0]     co;
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [31:0] swdi;
assign      swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11],di[12],di[13],di[14],di[15],
                     di[16],di[17],di[18],di[19],di[20],di[21],di[22],di[23],di[24],di[25],di[26],di[27],di[28],di[29],di[30],di[31]};


wire [31:0] dx;
assign dx   =  ci[31:0]^swdi[31:0];

assign co[31]=dx[31]^dx[30]^dx[28]^dx[26]^dx[25]^dx[24]^dx[23]^dx[22]^dx[21]^dx[14]^dx[12]^dx[11]^dx[10]^dx[9]^dx[8]^dx[6]^dx[0]^
       di[32]^di[36]^di[37]^di[38]^di[39]^di[41]^di[43]^di[44]^di[46]^di[49]^di[50]^di[51]^di[54]^di[56]^di[57]^di[59]^di[60]^di[67]^
       di[70]^di[72]^di[73]^di[74]^di[75]^di[76]^di[78]^di[79]^di[80]^di[88]^di[92]^di[94]^di[95]^di[98];

assign co[30]=dx[30]^dx[29]^dx[27]^dx[25]^dx[24]^dx[23]^dx[22]^dx[21]^dx[20]^dx[13]^dx[11]^dx[10]^dx[9]^dx[8]^dx[7]^dx[5]^
       di[32]^di[33]^di[37]^di[38]^di[39]^di[40]^di[42]^di[44]^di[45]^di[47]^di[50]^di[51]^di[52]^di[55]^di[57]^di[58]^di[60]^di[61]^
       di[68]^di[71]^di[73]^di[74]^di[75]^di[76]^di[77]^di[79]^di[80]^di[81]^di[89]^di[93]^di[95]^di[96]^di[99];

assign co[29]=dx[31]^dx[29]^dx[28]^dx[26]^dx[24]^dx[23]^dx[22]^dx[21]^dx[20]^dx[19]^dx[12]^dx[10]^dx[9]^dx[8]^dx[7]^dx[6]^dx[4]^
       di[33]^di[34]^di[38]^di[39]^di[40]^di[41]^di[43]^di[45]^di[46]^di[48]^di[51]^di[52]^di[53]^di[56]^di[58]^di[59]^di[61]^di[62]^
       di[69]^di[72]^di[74]^di[75]^di[76]^di[77]^di[78]^di[80]^di[81]^di[82]^di[90]^di[94]^di[96]^di[97]^di[100];

assign co[28]=dx[30]^dx[28]^dx[27]^dx[25]^dx[23]^dx[22]^dx[21]^dx[20]^dx[19]^dx[18]^dx[11]^dx[9]^dx[8]^dx[7]^dx[6]^dx[5]^dx[3]^
       di[34]^di[35]^di[39]^di[40]^di[41]^di[42]^di[44]^di[46]^di[47]^di[49]^di[52]^di[53]^di[54]^di[57]^di[59]^di[60]^di[62]^di[63]^
       di[70]^di[73]^di[75]^di[76]^di[77]^di[78]^di[79]^di[81]^di[82]^di[83]^di[91]^di[95]^di[97]^di[98]^di[101];

assign co[27]=dx[29]^dx[27]^dx[26]^dx[24]^dx[22]^dx[21]^dx[20]^dx[19]^dx[18]^dx[17]^dx[10]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^
       di[35]^di[36]^di[40]^di[41]^di[42]^di[43]^di[45]^di[47]^di[48]^di[50]^di[53]^di[54]^di[55]^di[58]^di[60]^di[61]^di[63]^
       di[64]^di[71]^di[74]^di[76]^di[77]^di[78]^di[79]^di[80]^di[82]^di[83]^di[84]^di[92]^di[96]^di[98]^di[99]^di[102];

assign co[26]=dx[28]^dx[26]^dx[25]^dx[23]^dx[21]^dx[20]^dx[19]^dx[18]^dx[17]^dx[16]^dx[9]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[1]^
       di[36]^di[37]^di[41]^di[42]^di[43]^di[44]^di[46]^di[48]^di[49]^di[51]^di[54]^di[55]^di[56]^di[59]^di[61]^di[62]^
       di[64]^di[65]^di[72]^di[75]^di[77]^di[78]^di[79]^di[80]^di[81]^di[83]^di[84]^di[85]^di[93]^di[97]^di[99]^di[100]^di[103];

assign co[25]=dx[30]^dx[28]^dx[27]^dx[26]^dx[23]^dx[21]^dx[20]^dx[19]^dx[18]^dx[17]^dx[16]^
       dx[15]^dx[14]^dx[12]^dx[11]^dx[10]^dx[9]^dx[5]^dx[4]^dx[3]^dx[2]^
       di[32]^di[36]^di[39]^di[41]^di[42]^di[45]^di[46]^di[47]^di[51]^di[52]^di[54]^di[55]^di[59]^di[62]^di[63]^
       di[65]^di[66]^di[67]^di[70]^di[72]^di[74]^di[75]^di[81]^di[82]^di[84]^di[85]^di[86]^di[88]^di[92]^di[95]^di[100]^di[101];

assign co[24]=dx[31]^dx[29]^dx[27]^dx[26]^dx[25]^dx[22]^dx[20]^dx[19]^dx[18]^dx[17]^dx[16]^
       dx[15]^dx[14]^dx[13]^dx[11]^dx[10]^dx[9]^dx[8]^dx[4]^dx[3]^dx[2]^dx[1]^
       di[33]^di[37]^di[40]^di[42]^di[43]^di[46]^di[47]^di[48]^di[52]^di[53]^di[55]^di[56]^di[60]^di[63]^
       di[64]^di[66]^di[67]^di[68]^di[71]^di[73]^di[75]^di[76]^di[82]^di[83]^di[85]^di[86]^di[87]^di[89]^di[93]^di[96]^di[101]^di[102];

assign co[23]=dx[31]^dx[30]^dx[28]^dx[26]^dx[25]^dx[24]^dx[21]^dx[19]^dx[18]^dx[17]^dx[16]^
       dx[15]^dx[14]^dx[13]^dx[12]^dx[10]^dx[9]^dx[8]^dx[7]^dx[3]^dx[2]^dx[1]^dx[0]^
       di[34]^di[38]^di[41]^di[43]^di[44]^di[47]^di[48]^di[49]^di[53]^di[54]^di[56]^di[57]^di[61]^
       di[64]^di[65]^di[67]^di[68]^di[69]^di[72]^di[74]^di[76]^di[77]^di[83]^di[84]^di[86]^di[87]^di[88]^di[90]^di[94]^di[97]^di[102]^di[103];

assign co[22]=dx[29]^dx[28]^dx[27]^dx[26]^dx[22]^dx[21]^dx[20]^dx[18]^dx[17]^dx[16]^dx[15]^dx[13]^dx[10]^dx[7]^dx[2]^dx[1]^
       di[35]^di[36]^di[37]^di[38]^di[41]^di[42]^di[43]^di[45]^di[46]^di[48]^di[51]^di[55]^di[56]^di[58]^di[59]^di[60]^di[62]^
       di[65]^di[66]^di[67]^di[68]^di[69]^di[72]^di[74]^di[76]^di[77]^di[79]^di[80]^di[84]^di[85]^di[87]^di[89]^di[91]^di[92]^di[94]^di[103];

assign co[21]=dx[30]^dx[27]^dx[24]^dx[23]^dx[22]^dx[20]^dx[19]^dx[17]^dx[16]^dx[15]^dx[11]^dx[10]^dx[8]^dx[1]^
       di[32]^di[41]^di[42]^di[47]^di[50]^di[51]^di[52]^di[54]^di[61]^di[63]^
       di[66]^di[68]^di[69]^di[72]^di[74]^di[76]^di[77]^di[79]^di[81]^di[85]^di[86]^di[90]^di[93]^di[94]^di[98];

assign co[20]=dx[31]^dx[29]^dx[26]^dx[23]^dx[22]^dx[21]^dx[19]^dx[18]^dx[16]^dx[15]^dx[14]^dx[10]^dx[9]^dx[7]^dx[0]^
       di[33]^di[42]^di[43]^di[48]^di[51]^di[52]^di[53]^di[55]^di[62]^
       di[64]^di[67]^di[69]^di[70]^di[73]^di[75]^di[77]^di[78]^di[80]^di[82]^di[86]^di[87]^di[91]^di[94]^di[95]^di[99];

assign co[19]=dx[31]^dx[30]^dx[28]^dx[25]^dx[22]^dx[21]^dx[20]^dx[18]^dx[17]^dx[15]^dx[14]^dx[13]^dx[9]^dx[8]^dx[6]^
       di[32]^di[34]^di[43]^di[44]^di[49]^di[52]^di[53]^di[54]^di[56]^di[63]^
       di[65]^di[68]^di[70]^di[71]^di[74]^di[76]^di[78]^di[79]^di[81]^di[83]^di[87]^di[88]^di[92]^di[95]^di[96]^di[100];

assign co[18]=dx[30]^dx[29]^dx[27]^dx[24]^dx[21]^dx[20]^dx[19]^dx[17]^dx[16]^dx[14]^dx[13]^dx[12]^dx[8]^dx[7]^dx[5]^
       di[33]^di[35]^di[44]^di[45]^di[50]^di[53]^di[54]^di[55]^di[57]^
       di[64]^di[66]^di[69]^di[71]^di[72]^di[75]^di[77]^di[79]^di[80]^di[82]^di[84]^di[88]^di[89]^di[93]^di[96]^di[97]^di[101];

assign co[17]=dx[31]^dx[29]^dx[28]^dx[26]^dx[23]^dx[20]^dx[19]^dx[18]^dx[16]^dx[15]^dx[13]^dx[12]^dx[11]^dx[7]^dx[6]^dx[4]^
       di[34]^di[36]^di[45]^di[46]^di[51]^di[54]^di[55]^di[56]^di[58]^
       di[65]^di[67]^di[70]^di[72]^di[73]^di[76]^di[78]^di[80]^di[81]^di[83]^di[85]^di[89]^di[90]^di[94]^di[97]^di[98]^di[102];

assign co[16]=dx[31]^dx[30]^dx[28]^dx[27]^dx[25]^dx[22]^dx[19]^dx[18]^dx[17]^dx[15]^dx[14]^dx[12]^dx[11]^dx[10]^dx[6]^dx[5]^dx[3]^
       di[35]^di[37]^di[46]^di[47]^di[52]^di[55]^di[56]^di[57]^di[59]^
       di[66]^di[68]^di[71]^di[73]^di[74]^di[77]^di[79]^di[81]^di[82]^di[84]^di[86]^di[90]^di[91]^di[95]^di[98]^di[99]^di[103];

assign co[15]=dx[29]^dx[28]^dx[27]^dx[25]^dx[23]^dx[22]^dx[18]^dx[17]^dx[16]^dx[13]^dx[12]^dx[8]^dx[6]^dx[5]^dx[4]^dx[2]^dx[0]^
       di[32]^di[37]^di[39]^di[41]^di[43]^di[44]^di[46]^di[47]^di[48]^di[49]^di[50]^di[51]^di[53]^di[54]^di[58]^di[59]^
       di[69]^di[70]^di[73]^di[76]^di[79]^di[82]^di[83]^di[85]^di[87]^di[88]^di[91]^di[94]^di[95]^di[96]^di[98]^di[99]^di[100];

assign co[14]=dx[31]^dx[28]^dx[27]^dx[26]^dx[24]^dx[22]^dx[21]^dx[17]^dx[16]^dx[15]^dx[12]^dx[11]^dx[7]^dx[5]^dx[4]^dx[3]^dx[1]^
       di[32]^di[33]^di[38]^di[40]^di[42]^di[44]^di[45]^di[47]^di[48]^di[49]^di[50]^di[51]^di[52]^di[54]^di[55]^di[59]^di[60]^
       di[70]^di[71]^di[74]^di[77]^di[80]^di[83]^di[84]^di[86]^di[88]^di[89]^di[92]^di[95]^di[96]^di[97]^di[99]^di[100]^di[101];

assign co[13]=dx[31]^dx[30]^dx[27]^dx[26]^dx[25]^dx[23]^dx[21]^dx[20]^dx[16]^dx[15]^dx[14]^dx[11]^dx[10]^dx[6]^dx[4]^dx[3]^dx[2]^dx[0]^
       di[33]^di[34]^di[39]^di[41]^di[43]^di[45]^di[46]^di[48]^di[49]^di[50]^di[51]^di[52]^di[53]^di[55]^di[56]^di[60]^di[61]^
       di[71]^di[72]^di[75]^di[78]^di[81]^di[84]^di[85]^di[87]^di[89]^di[90]^di[93]^di[96]^di[97]^di[98]^di[100]^di[101]^di[102];

assign co[12]=dx[30]^dx[29]^dx[26]^dx[25]^dx[24]^dx[22]^dx[20]^dx[19]^dx[15]^dx[14]^dx[13]^dx[10]^dx[9]^dx[5]^dx[3]^dx[2]^dx[1]^
       di[32]^di[34]^di[35]^di[40]^di[42]^di[44]^di[46]^di[47]^di[49]^di[50]^di[51]^di[52]^di[53]^di[54]^di[56]^di[57]^di[61]^di[62]^
       di[72]^di[73]^di[76]^di[79]^di[82]^di[85]^di[86]^di[88]^di[90]^di[91]^di[94]^di[97]^di[98]^di[99]^di[101]^di[102]^di[103];

assign co[11]=dx[31]^dx[30]^dx[29]^dx[26]^dx[22]^dx[19]^dx[18]^dx[13]^dx[11]^dx[10]^dx[6]^dx[4]^dx[2]^dx[1]^
       di[32]^di[33]^di[35]^di[37]^di[38]^di[39]^di[44]^di[45]^di[46]^di[47]^di[48]^di[49]^di[52]^di[53]^di[55]^di[56]^di[58]^di[59]^di[60]^di[62]^di[63]^
       di[67]^di[70]^di[72]^di[75]^di[76]^di[77]^di[78]^di[79]^di[83]^di[86]^di[87]^di[88]^di[89]^di[91]^di[94]^di[99]^di[100]^di[102]^di[103];

assign co[10]=dx[29]^dx[26]^dx[24]^dx[23]^dx[22]^dx[18]^dx[17]^dx[14]^dx[11]^dx[8]^dx[6]^dx[5]^dx[3]^dx[1]^
       di[32]^di[33]^di[34]^di[37]^di[40]^di[41]^di[43]^di[44]^di[45]^di[47]^di[48]^di[51]^di[53]^di[61]^di[63]^
       di[64]^di[67]^di[68]^di[70]^di[71]^di[72]^di[74]^di[75]^di[77]^di[84]^di[87]^di[89]^di[90]^di[94]^di[98]^di[100]^di[101]^di[103];

assign co[9]=dx[30]^dx[26]^dx[24]^dx[17]^dx[16]^dx[14]^dx[13]^dx[12]^dx[11]^dx[9]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^
       di[32]^di[33]^di[34]^di[35]^di[36]^di[37]^di[39]^di[42]^di[43]^di[45]^di[48]^di[50]^di[51]^di[52]^di[56]^di[57]^di[59]^di[60]^di[62]^
       di[64]^di[65]^di[67]^di[68]^di[69]^di[70]^di[71]^di[74]^di[79]^di[80]^di[85]^di[90]^di[91]^di[92]^di[94]^di[98]^di[99]^di[101]^di[102];

assign co[8]=dx[31]^dx[29]^dx[25]^dx[23]^dx[16]^dx[15]^dx[13]^dx[12]^dx[11]^dx[10]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[1]^
       di[33]^di[34]^di[35]^di[36]^di[37]^di[38]^di[40]^di[43]^di[44]^di[46]^di[49]^di[51]^di[52]^di[53]^di[57]^di[58]^di[60]^di[61]^di[63]^
       di[65]^di[66]^di[68]^di[69]^di[70]^di[71]^di[72]^di[75]^di[80]^di[81]^di[86]^di[91]^di[92]^di[93]^di[95]^di[99]^di[100]^di[102]^di[103];

assign co[7]=dx[31]^dx[26]^dx[25]^dx[23]^dx[21]^dx[15]^dx[8]^dx[7]^dx[5]^dx[4]^dx[3]^dx[2]^
       di[32]^di[34]^di[35]^di[43]^di[45]^di[46]^di[47]^di[49]^di[51]^di[52]^di[53]^di[56]^di[57]^di[58]^di[60]^di[61]^di[62]^
       di[64]^di[66]^di[69]^di[71]^di[74]^di[75]^di[78]^di[79]^di[80]^di[81]^di[82]^di[87]^di[88]^di[93]^di[95]^di[96]^di[98]^di[100]^di[101]^di[103];

assign co[6]=dx[28]^dx[26]^dx[23]^dx[21]^dx[20]^dx[12]^dx[11]^dx[10]^dx[9]^dx[8]^dx[7]^dx[4]^dx[3]^dx[2]^dx[1]^dx[0]^
       di[32]^di[33]^di[35]^di[37]^di[38]^di[39]^di[41]^di[43]^di[47]^di[48]^di[49]^di[51]^di[52]^di[53]^di[56]^di[58]^di[60]^di[61]^di[62]^di[63]^
       di[65]^di[73]^di[74]^di[78]^di[81]^di[82]^di[83]^di[89]^di[92]^di[95]^di[96]^di[97]^di[98]^di[99]^di[101]^di[102];

assign co[5]=dx[31]^dx[27]^dx[25]^dx[22]^dx[20]^dx[19]^dx[11]^dx[10]^dx[9]^dx[8]^dx[7]^dx[6]^dx[3]^dx[2]^dx[1]^dx[0]^
       di[32]^di[33]^di[34]^di[36]^di[38]^di[39]^di[40]^di[42]^di[44]^di[48]^di[49]^di[50]^di[52]^di[53]^di[54]^di[57]^di[59]^di[61]^di[62]^di[63]^
       di[64]^di[66]^di[74]^di[75]^di[79]^di[82]^di[83]^di[84]^di[90]^di[93]^di[96]^di[97]^di[98]^di[99]^di[100]^di[102]^di[103];

assign co[4]=dx[31]^dx[28]^dx[25]^dx[23]^dx[22]^dx[19]^dx[18]^dx[14]^dx[12]^dx[11]^dx[7]^dx[5]^dx[2]^dx[1]^
       di[33]^di[34]^di[35]^di[36]^di[38]^di[40]^di[44]^di[45]^di[46]^di[53]^di[55]^di[56]^di[57]^di[58]^di[59]^di[62]^di[63]^
       di[64]^di[65]^di[70]^di[72]^di[73]^di[74]^di[78]^di[79]^di[83]^di[84]^di[85]^di[88]^di[91]^di[92]^di[95]^di[97]^di[99]^di[100]^di[101]^di[103];

assign co[3]=dx[31]^dx[28]^dx[27]^dx[26]^dx[25]^dx[23]^dx[18]^dx[17]^dx[14]^dx[13]^dx[12]^dx[9]^dx[8]^dx[4]^dx[1]^
       di[32]^di[34]^di[35]^di[38]^di[43]^di[44]^di[45]^di[47]^di[49]^di[50]^di[51]^di[58]^di[63]^
       di[64]^di[65]^di[66]^di[67]^di[70]^di[71]^di[72]^di[76]^di[78]^di[84]^di[85]^di[86]^di[88]^di[89]^di[93]^di[94]^di[95]^
       di[96]^di[100]^di[101]^di[102];

assign co[2]=dx[30]^dx[27]^dx[26]^dx[25]^dx[24]^dx[22]^dx[17]^dx[16]^dx[13]^dx[12]^dx[11]^dx[8]^dx[7]^dx[3]^dx[0]^
       di[33]^di[35]^di[36]^di[39]^di[44]^di[45]^di[46]^di[48]^di[50]^di[51]^di[52]^di[59]^di[64]^
       di[65]^di[66]^di[67]^di[68]^di[71]^di[72]^di[73]^di[77]^di[79]^di[85]^di[86]^di[87]^di[89]^di[90]^di[94]^di[95]^
       di[96]^di[97]^di[101]^di[102]^di[103];

assign co[1]=dx[31]^dx[30]^dx[29]^dx[28]^dx[22]^dx[16]^dx[15]^dx[14]^dx[9]^dx[8]^dx[7]^dx[2]^dx[0]^
       di[34]^di[38]^di[39]^di[40]^di[41]^di[43]^di[44]^di[45]^di[47]^di[50]^di[52]^di[53]^di[54]^di[56]^di[57]^di[59]^
       di[65]^di[66]^di[68]^di[69]^di[70]^di[75]^di[76]^di[79]^di[86]^di[87]^di[90]^di[91]^di[92]^di[94]^di[96]^di[97]^di[102]^di[103];

assign co[0]=dx[31]^dx[29]^dx[27]^dx[26]^dx[25]^dx[24]^dx[23]^dx[22]^dx[15]^dx[13]^dx[12]^dx[11]^dx[10]^dx[9]^dx[7]^dx[1]^dx[0]^
       di[35]^di[36]^di[37]^di[38]^di[40]^di[42]^di[43]^di[45]^di[48]^di[49]^di[50]^di[53]^di[55]^di[56]^di[58]^di[59]^
       di[66]^di[69]^di[71]^di[72]^di[73]^di[74]^di[75]^di[77]^di[78]^di[79]^di[87]^di[91]^di[93]^di[94]^di[97]^di[103];


endmodule 
