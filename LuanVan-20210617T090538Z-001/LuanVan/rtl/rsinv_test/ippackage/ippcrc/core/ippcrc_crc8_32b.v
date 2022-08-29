//x8 + x2 + x + 1
module ippcrc_crc8_32b
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
input [31:0]   di;

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

assign     co[7]=dx[6]^dx[5]^dx[3]^
           di[9]^di[11]^di[13]^di[14]^di[16]^di[18]^di[20]^di[24]^di[25]^di[26];

assign     co[6]=dx[5]^dx[4]^dx[2]^
           di[10]^di[12]^di[14]^di[15]^di[17]^di[19]^di[21]^di[25]^di[26]^di[27];

assign     co[5]=dx[7]^dx[4]^dx[3]^dx[1]^
           di[11]^di[13]^di[15]^di[16]^di[18]^di[20]^di[22]^di[26]^di[27]^di[28];

assign     co[4]=dx[7]^dx[6]^dx[3]^dx[2]^dx[0]^
           di[12]^di[14]^di[16]^di[17]^di[19]^di[21]^di[23]^di[27]^di[28]^di[29];

assign     co[3]=dx[6]^dx[5]^dx[2]^dx[1]^
           di[8]^di[13]^di[15]^di[17]^di[18]^di[20]^di[22]^di[24]^di[28]^di[29]^di[30];

assign     co[2]=dx[5]^dx[4]^dx[1]^dx[0]^
           di[9]^di[14]^di[16]^di[18]^di[19]^di[21]^di[23]^di[25]^di[29]^di[30]^di[31];

assign     co[1]=dx[6]^dx[5]^dx[4]^dx[0]^
           di[8]^di[9]^di[10]^di[11]^di[13]^di[14]^di[15]^di[16]^di[17]^di[18]^di[19]^di[22]^di[25]^di[30]^di[31];

assign     co[0]=dx[7]^dx[6]^dx[4]^
           di[8]^di[10]^di[12]^di[13]^di[15]^di[17]^di[19]^di[23]^di[24]^di[25]^di[31];

endmodule 