////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : crc32_24b.v
// Description  : .
//
// Author       : lqson@HW-LQSON
// Created On   : Fri Aug 10 13:53:20 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcrc_crc32_24b
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
input [23:0]    di;

output [31:0]   co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [31:0]     co;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [23:0] swdi;

assign      swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11],di[12],di[13],di[14],di[15],
                     di[16],di[17],di[18],di[19],di[20],di[21],di[22],di[23]};

wire [23:0] dx;
assign      dx   =  ci[31:8]^swdi[23:0];


assign      co[31]=dx[23]^dx[15]^dx[11]^dx[9]^dx[8]^dx[5]^ci[7];
assign      co[30]=dx[23]^dx[22]^dx[14]^dx[10]^dx[8]^dx[7]^dx[4]^ci[6];
assign      co[29]=dx[23]^dx[22]^dx[21]^dx[13]^dx[9]^dx[7]^dx[6]^dx[3]^ci[5];
assign      co[28]=dx[22]^dx[21]^dx[20]^dx[12]^dx[8]^dx[6]^dx[5]^dx[2]^ci[4];
assign      co[27]=dx[23]^dx[21]^dx[20]^dx[19]^dx[11]^dx[7]^dx[5]^dx[4]^dx[1]^ci[3];
assign      co[26]=dx[23]^dx[22]^dx[20]^dx[19]^dx[18]^dx[10]^dx[6]^dx[4]^dx[3]^dx[0]^ci[2];
assign      co[25]=dx[22]^dx[21]^dx[19]^dx[18]^dx[17]^dx[15]^dx[11]^dx[8]^dx[3]^dx[2]^ci[1];
assign      co[24]=dx[21]^dx[20]^dx[18]^dx[17]^dx[16]^dx[14]^dx[10]^dx[7]^dx[2]^dx[1]^ci[0];
assign      co[23]=dx[20]^dx[19]^dx[17]^dx[16]^dx[15]^dx[13]^dx[9]^dx[6]^dx[1]^dx[0];
assign      co[22]=dx[23]^dx[19]^dx[18]^dx[16]^dx[14]^dx[12]^dx[11]^dx[9]^dx[0];
assign      co[21]=dx[22]^dx[18]^dx[17]^dx[13]^dx[10]^dx[9]^dx[5];
assign      co[20]=dx[23]^dx[21]^dx[17]^dx[16]^dx[12]^dx[9]^dx[8]^dx[4];
assign      co[19]=dx[22]^dx[20]^dx[16]^dx[15]^dx[11]^dx[8]^dx[7]^dx[3];
assign      co[18]=dx[23]^dx[21]^dx[19]^dx[15]^dx[14]^dx[10]^dx[7]^dx[6]^dx[2];
assign      co[17]=dx[23]^dx[22]^dx[20]^dx[18]^dx[14]^dx[13]^dx[9]^dx[6]^dx[5]^dx[1];
assign      co[16]=dx[22]^dx[21]^dx[19]^dx[17]^dx[13]^dx[12]^dx[8]^dx[5]^dx[4]^dx[0];
assign      co[15]=dx[21]^dx[20]^dx[18]^dx[16]^dx[15]^dx[12]^dx[9]^dx[8]^dx[7]^dx[5]^dx[4]^dx[3];
assign      co[14]=dx[23]^dx[20]^dx[19]^dx[17]^dx[15]^dx[14]^dx[11]^dx[8]^dx[7]^dx[6]^dx[4]^dx[3]^dx[2];
assign      co[13]=dx[22]^dx[19]^dx[18]^dx[16]^dx[14]^dx[13]^dx[10]^dx[7]^dx[6]^dx[5]^dx[3]^dx[2]^dx[1];
assign      co[12]=dx[21]^dx[18]^dx[17]^dx[15]^dx[13]^dx[12]^dx[9]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1]^dx[0];
assign      co[11]=dx[20]^dx[17]^dx[16]^dx[15]^dx[14]^dx[12]^dx[9]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[10]=dx[19]^dx[16]^dx[14]^dx[13]^dx[9]^dx[5]^dx[3]^dx[2]^dx[0];
assign      co[9]=dx[23]^dx[18]^dx[13]^dx[12]^dx[11]^dx[9]^dx[5]^dx[4]^dx[2]^dx[1];
assign      co[8]=dx[23]^dx[22]^dx[17]^dx[12]^dx[11]^dx[10]^dx[8]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[7]=dx[23]^dx[22]^dx[21]^dx[16]^dx[15]^dx[10]^dx[8]^dx[7]^dx[5]^dx[3]^dx[2]^dx[0];
assign      co[6]=dx[22]^dx[21]^dx[20]^dx[14]^dx[11]^dx[8]^dx[7]^dx[6]^dx[5]^dx[4]^dx[2]^dx[1];
assign      co[5]=dx[21]^dx[20]^dx[19]^dx[13]^dx[10]^dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[1]^dx[0];
assign      co[4]=dx[20]^dx[19]^dx[18]^dx[15]^dx[12]^dx[11]^dx[8]^dx[6]^dx[4]^dx[3]^dx[2]^dx[0];
assign      co[3]=dx[19]^dx[18]^dx[17]^dx[15]^dx[14]^dx[10]^dx[9]^dx[8]^dx[7]^dx[3]^dx[2]^dx[1];
assign      co[2]=dx[18]^dx[17]^dx[16]^dx[14]^dx[13]^dx[9]^dx[8]^dx[7]^dx[6]^dx[2]^dx[1]^dx[0];
assign      co[1]=dx[17]^dx[16]^dx[13]^dx[12]^dx[11]^dx[9]^dx[7]^dx[6]^dx[1]^dx[0];
assign      co[0]=dx[16]^dx[12]^dx[10]^dx[9]^dx[6]^dx[0];
       
endmodule 
