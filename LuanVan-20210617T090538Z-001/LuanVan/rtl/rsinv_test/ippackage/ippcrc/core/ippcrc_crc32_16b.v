////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : crc32_16b.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Fri Aug 10 13:47:03 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcrc_crc32_16b
    (
     ci,
     di,

     co
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [31:0]    ci;
input [15:0]    di;

output [31:0]   co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [31:0]     co;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [15:0] swdi;
assign      swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11],di[12],di[13],di[14],di[15]};

wire [15:0] dx;
assign      dx   =  ci[31:16]^swdi[15:0];

assign      co[31]=dx[15]^dx[11]^dx[9]^dx[8]^dx[5]^ci[15];
assign      co[30]=dx[14]^dx[10]^dx[8]^dx[7]^dx[4]^ci[14];
assign      co[29]=dx[13]^dx[9]^dx[7]^dx[6]^dx[3]^ci[13];
assign      co[28]=dx[12]^dx[8]^dx[6]^dx[5]^dx[2]^ci[12];
assign      co[27]=dx[11]^dx[7]^dx[5]^dx[4]^dx[1]^ci[11];
assign      co[26]=dx[10]^dx[6]^dx[4]^dx[3]^dx[0]^ci[10];
assign      co[25]=dx[15]^dx[11]^dx[8]^dx[3]^dx[2]^ci[9];
assign      co[24]=dx[14]^dx[10]^dx[7]^dx[2]^dx[1]^ci[8];
assign      co[23]=dx[15]^dx[13]^dx[9]^dx[6]^dx[1]^dx[0]^ci[7];
assign      co[22]=dx[14]^dx[12]^dx[11]^dx[9]^dx[0]^ci[6];
assign      co[21]=dx[13]^dx[10]^dx[9]^dx[5]^ci[5];
assign      co[20]=dx[12]^dx[9]^dx[8]^dx[4]^ci[4];
assign      co[19]=dx[15]^dx[11]^dx[8]^dx[7]^dx[3]^ci[3];
assign      co[18]=dx[15]^dx[14]^dx[10]^dx[7]^dx[6]^dx[2]^ci[2];
assign      co[17]=dx[14]^dx[13]^dx[9]^dx[6]^dx[5]^dx[1]^ci[1];
assign      co[16]=dx[13]^dx[12]^dx[8]^dx[5]^dx[4]^dx[0]^ci[0];
assign      co[15]=dx[15]^dx[12]^dx[9]^dx[8]^dx[7]^dx[5]^dx[4]^dx[3];
assign      co[14]=dx[15]^dx[14]^dx[11]^dx[8]^dx[7]^dx[6]^dx[4]^dx[3]^dx[2];
assign      co[13]=dx[14]^dx[13]^dx[10]^dx[7]^dx[6]^dx[5]^dx[3]^dx[2]^dx[1];
assign      co[12]=dx[15]^dx[13]^dx[12]^dx[9]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1]^dx[0];
assign      co[11]=dx[15]^dx[14]^dx[12]^dx[9]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[10]=dx[14]^dx[13]^dx[9]^dx[5]^dx[3]^dx[2]^dx[0];
assign      co[9]=dx[13]^dx[12]^dx[11]^dx[9]^dx[5]^dx[4]^dx[2]^dx[1];
assign      co[8]=dx[12]^dx[11]^dx[10]^dx[8]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[7]=dx[15]^dx[10]^dx[8]^dx[7]^dx[5]^dx[3]^dx[2]^dx[0];
assign      co[6]=dx[14]^dx[11]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1];
assign      co[5]=dx[13]^dx[10]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[4]=dx[15]^dx[12]^dx[11]^dx[8]^dx[6]^dx[4]^dx[3]^dx[2]^dx[0];
assign      co[3]=dx[15]^dx[14]^dx[10]^dx[9]^dx[8]^dx[7]^dx[3]^dx[2]^dx[1];
assign      co[2]=dx[14]^dx[13]^dx[9]^dx[8]^dx[7]^dx[6]^dx[2]^dx[1]^dx[0];
assign      co[1]=dx[13]^dx[12]^dx[11]^dx[9]^dx[7]^dx[6]^dx[1]^dx[0];
assign      co[0]=dx[12]^dx[10]^dx[9]^dx[6]^dx[0];
      
endmodule 
