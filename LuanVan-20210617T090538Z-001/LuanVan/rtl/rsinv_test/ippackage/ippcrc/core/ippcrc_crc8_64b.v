//x8 + x2 + x + 1
module ippcrc_crc8_64b
    (
     ci,
     di,
     
     co
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [7:0]    ci;
input [63:0]   di;

output [7:0]  co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [7:0]    co;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [7:0] swdi;
assign     swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7]};

wire [7:0] dx;
assign     dx   =  ci[7:0]^swdi[7:0];

assign     co[7]=dx[7]^dx[6]^dx[3]^
           di[8]^di[10]^di[11]^di[12]^di[14]^di[15]^di[16]^di[19]^di[21]^di[24]^di[25]^di[29]^di[30]^di[33]^di[34]^di[36]^di[41]^di[43]^di[45]^di[46]^di[48]^di[50]^di[52]^di[56]^di[57]^di[58];

assign     co[6]=dx[6]^dx[5]^dx[2]^
           di[9]^di[11]^di[12]^di[13]^di[15]^di[16]^di[17]^di[20]^di[22]^di[25]^di[26]^di[30]^di[31]^di[34]^di[35]^di[37]^di[42]^di[44]^di[46]^di[47]^di[49]^di[51]^di[53]^di[57]^di[58]^di[59];

assign     co[5]=dx[7]^dx[5]^dx[4]^dx[1]^
           di[10]^di[12]^di[13]^di[14]^di[16]^di[17]^di[18]^di[21]^di[23]^di[26]^di[27]^di[31]^di[32]^di[35]^di[36]^di[38]^di[43]^di[45]^di[47]^di[48]^di[50]^di[52]^di[54]^di[58]^di[59]^di[60];

assign     co[4]=dx[7]^dx[6]^dx[4]^dx[3]^dx[0]^
           di[11]^di[13]^di[14]^di[15]^di[17]^di[18]^di[19]^di[22]^di[24]^di[27]^di[28]^di[32]^di[33]^di[36]^di[37]^di[39]^di[44]^di[46]^di[48]^di[49]^di[51]^di[53]^di[55]^di[59]^di[60]^di[61];

assign     co[3]=dx[7]^dx[6]^dx[5]^dx[3]^dx[2]^
           di[8]^di[12]^di[14]^di[15]^di[16]^di[18]^di[19]^di[20]^di[23]^di[25]^di[28]^di[29]^di[33]^di[34]^di[37]^di[38]^di[40]^di[45]^di[47]^di[49]^di[50]^di[52]^di[54]^di[56]^di[60]^di[61]^di[62];

assign     co[2]=dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1]^
           di[9]^di[13]^di[15]^di[16]^di[17]^di[19]^di[20]^di[21]^di[24]^di[26]^di[29]^di[30]^di[34]^di[35]^di[38]^di[39]^di[41]^di[46]^di[48]^di[50]^di[51]^di[53]^di[55]^di[57]^di[61]^di[62]^di[63];

assign     co[1]=dx[7]^dx[5]^dx[4]^dx[1]^dx[0]^
           di[8]^di[11]^di[12]^di[15]^di[17]^di[18]^di[19]^di[20]^di[22]^di[24]^di[27]^di[29]^di[31]^di[33]^di[34]^di[35]^di[39]^di[40]^di[41]^di[42]^di[43]^di[45]^di[46]^di[47]^di[48]^di[49]^di[50]^di[51]^di[54]^di[57]^di[62]^di[63];

assign     co[0]=dx[7]^dx[4]^dx[0]^
           di[9]^di[10]^di[11]^di[13]^di[14]^di[15]^di[18]^di[20]^di[23]^di[24]^di[28]^di[29]^di[32]^di[33]^di[35]^di[40]^di[42]^di[44]^di[45]^di[47]^di[49]^di[51]^di[55]^di[56]^di[57]^di[63];

endmodule