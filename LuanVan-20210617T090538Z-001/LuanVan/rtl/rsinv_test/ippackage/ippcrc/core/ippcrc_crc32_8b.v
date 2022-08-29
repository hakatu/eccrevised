////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : crc32_8b.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Fri Aug 10 13:24:34 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcrc_crc32_8b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [31:0]   ci;
input [7:0]    di;

output [31:0]  co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [31:0]    co;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [7:0]     swdi;
assign         swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7]};

wire [7:0]     dx;
assign         dx   =  ci[31:24]^swdi[7:0];


assign         co[31]=dx[5]^ci[23];
assign         co[30]=dx[7]^dx[4]^ci[22];
assign         co[29]=dx[7]^dx[6]^dx[3]^ci[21];
assign         co[28]=dx[6]^dx[5]^dx[2]^ci[20];
assign         co[27]=dx[7]^dx[5]^dx[4]^dx[1]^ci[19];
assign         co[26]=dx[6]^dx[4]^dx[3]^dx[0]^ci[18];
assign         co[25]=dx[3]^dx[2]^ci[17];
assign         co[24]=dx[7]^dx[2]^dx[1]^ci[16];
assign         co[23]=dx[6]^dx[1]^dx[0]^ci[15];
assign         co[22]=dx[0]^ci[14];
assign         co[21]=dx[5]^ci[13];
assign         co[20]=dx[4]^ci[12];
assign         co[19]=dx[7]^dx[3]^ci[11];
assign         co[18]=dx[7]^dx[6]^dx[2]^ci[10];
assign         co[17]=dx[6]^dx[5]^dx[1]^ci[9];
assign         co[16]=dx[5]^dx[4]^dx[0]^ci[8];
assign         co[15]=dx[7]^dx[5]^dx[4]^dx[3]^ ci[7];
assign         co[14]=dx[7]^dx[6]^dx[4]^dx[3]^dx[2]^ci[6];
assign         co[13]=dx[7]^dx[6]^dx[5]^dx[3]^dx[2]^dx[1]^ci[5];
assign         co[12]=dx[6]^dx[5]^dx[4]^dx[2]^dx[1]^dx[0]^ci[4];
assign         co[11]=dx[4]^dx[3]^dx[1]^dx[0]^ci[3];
assign         co[10]=dx[5]^dx[3]^dx[2]^dx[0]^ci[2];
assign         co[9]=dx[5]^dx[4]^dx[2]^dx[1]^ci[1];
assign         co[8]=dx[4]^dx[3]^dx[1]^dx[0]^ci[0];
assign         co[7]=dx[7]^dx[5]^dx[3]^dx[2]^dx[0];
assign         co[6]=dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1];
assign         co[5]=dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[1]^dx[0];
assign         co[4]=dx[6]^dx[4]^dx[3]^dx[2]^dx[0];
assign         co[3]=dx[7]^dx[3]^dx[2]^dx[1];
assign         co[2]=dx[7]^dx[6]^dx[2]^dx[1]^dx[0];
assign         co[1]=dx[7]^dx[6]^dx[1]^dx[0];
assign         co[0]=dx[6]^dx[0];
 

endmodule 