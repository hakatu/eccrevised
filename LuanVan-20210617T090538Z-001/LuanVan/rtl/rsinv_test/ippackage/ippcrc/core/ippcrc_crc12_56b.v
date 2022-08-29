module ippcrc_crc12_56b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [55:0]   di;

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

assign          co[11]=dx[9]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[2]^
                di[12]^di[21]^di[22]^di[23]^di[26]^di[27]^di[30]^di[31]^di[32]^di[33]^di[34]^di[39]^di[40]^di[41]^di[42]^di[43]^di[44]^di[45]^di[48]^di[49]^di[50]^di[51]^di[52]^di[53]^di[54]^di[55];

assign          co[10]=dx[9]^dx[8]^dx[7]^dx[1]^
                di[12]^di[13]^di[21]^di[24]^di[26]^di[28]^di[30]^di[35]^di[39]^di[46]^di[48];

assign          co[9]=dx[11]^dx[8]^dx[7]^dx[6]^dx[0]^
                di[13]^di[14]^di[22]^di[25]^di[27]^di[29]^di[31]^di[36]^di[40]^di[47]^di[49];

assign          co[8]=dx[10]^dx[7]^dx[6]^dx[5]^
                di[12]^di[14]^di[15]^di[23]^di[26]^di[28]^di[30]^di[32]^di[37]^di[41]^di[48]^di[50];

assign          co[7]=dx[9]^dx[6]^dx[5]^dx[4]^
                di[13]^di[15]^di[16]^di[24]^di[27]^di[29]^di[31]^di[33]^di[38]^di[42]^di[49]^di[51];

assign          co[6]=dx[8]^dx[5]^dx[4]^dx[3]^
                di[14]^di[16]^di[17]^di[25]^di[28]^di[30]^di[32]^di[34]^di[39]^di[43]^di[50]^di[52];

assign          co[5]=dx[11]^dx[7]^dx[4]^dx[3]^dx[2]^
                di[15]^di[17]^di[18]^di[26]^di[29]^di[31]^di[33]^di[35]^di[40]^di[44]^di[51]^di[53];

assign          co[4]=dx[11]^dx[10]^dx[6]^dx[3]^dx[2]^dx[1]^
                di[16]^di[18]^di[19]^di[27]^di[30]^di[32]^di[34]^di[36]^di[41]^di[45]^di[52]^di[54];

assign          co[3]=dx[10]^dx[9]^dx[5]^dx[2]^dx[1]^dx[0]^
                di[17]^di[19]^di[20]^di[28]^di[31]^di[33]^di[35]^di[37]^di[42]^di[46]^di[53]^di[55];

assign          co[2]=dx[11]^dx[8]^dx[7]^dx[6]^dx[5]^dx[3]^dx[2]^dx[1]^dx[0]^
                di[18]^di[20]^di[22]^di[23]^di[26]^di[27]^di[29]^di[30]^di[31]^di[33]^di[36]^di[38]^di[39]^di[40]^di[41]^di[42]^di[44]^di[45]^di[47]^di[48]^di[49]^di[50]^di[51]^di[52]^di[53]^di[55];

assign          co[1]=dx[11]^dx[10]^dx[9]^dx[3]^dx[1]^dx[0]^
                di[19]^di[22]^di[24]^di[26]^di[28]^di[33]^di[37]^di[44]^di[46]^di[55];

assign          co[0]=dx[10]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[0]^
                di[20]^di[21]^di[22]^di[25]^di[26]^di[29]^di[30]^di[31]^di[32]^di[33]^di[38]^di[39]^di[40]^di[41]^di[42]^di[43]^di[44]^di[47]^di[48]^di[49]^di[50]^di[51]^di[52]^di[53]^di[54]^di[55];

endmodule