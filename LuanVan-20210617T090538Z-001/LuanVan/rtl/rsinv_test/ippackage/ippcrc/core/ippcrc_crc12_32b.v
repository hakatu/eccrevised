module ippcrc_crc12_32b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [31:0]   di;

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

assign          co[11]=dx[9]^dx[8]^dx[5]^dx[4]^dx[3]^dx[2]^dx[1]^
                di[15]^di[16]^di[17]^di[18]^di[19]^di[20]^di[21]^di[24]^di[25]^di[26]^di[27]^di[28]^di[29]^di[30]^di[31];

assign          co[10]=dx[11]^dx[9]^dx[7]^dx[5]^dx[0]^
                di[15]^di[22]^di[24];

assign          co[9]=dx[10]^dx[8]^dx[6]^dx[4]^
                di[12]^di[16]^di[23]^di[25];

assign          co[8]=dx[9]^dx[7]^dx[5]^dx[3]^
                di[13]^di[17]^di[24]^di[26];

assign          co[7]=dx[11]^dx[8]^dx[6]^dx[4]^dx[2]^
                di[14]^di[18]^di[25]^di[27];

assign          co[6]=dx[10]^dx[7]^dx[5]^dx[3]^dx[1]^
                di[15]^di[19]^di[26]^di[28];

assign          co[5]=dx[9]^dx[6]^dx[4]^dx[2]^dx[0]^
                di[16]^di[20]^di[27]^di[29];

assign          co[4]=dx[8]^dx[5]^dx[3]^dx[1]^
                di[12]^di[17]^di[21]^di[28]^di[30];

assign          co[3]=dx[7]^dx[4]^dx[2]^dx[0]^
                di[13]^di[18]^di[22]^di[29]^di[31];

assign          co[2]=dx[9]^dx[8]^dx[6]^dx[5]^dx[4]^dx[2]^
                di[12]^di[14]^di[15]^di[16]^di[17]^di[18]^di[20]^di[21]^di[23]^di[24]^di[25]^di[26]^di[27]^di[28]^di[29]^di[31];

assign          co[1]=dx[11]^dx[9]^dx[7]^dx[2]^
                di[13]^di[20]^di[22]^di[31];

assign          co[0]=dx[10]^dx[9]^dx[6]^dx[5]^dx[4]^dx[3]^dx[2]^
                di[14]^di[15]^di[16]^di[17]^di[18]^di[19]^di[20]^di[23]^di[24]^di[25]^di[26]^di[27]^di[28]^di[29]^di[30]^di[31];

endmodule
