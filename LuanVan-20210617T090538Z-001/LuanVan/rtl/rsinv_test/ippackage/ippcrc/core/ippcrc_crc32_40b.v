////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : crc32_40b.v
// Description  :  -with the polynomial:
//                  1 + x^1  + x^2  + x^4  + x^5  + x^7 + x^8 + x^10 + x^11 + x^12
//                    + x^16 + x^22 + x^23 + x^26 + x^32
//
// Author       : lqson@HW-LQSON
// Created On   : Thu Aug 09 14:33:37 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ippcrc_crc32_40b
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
input [39:0]    di;

output [31:0]   co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [31:0] co;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [31:0] swdi;
/*
assign      swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11],di[12],di[13],di[14],di[15],
                     di[16],di[17],di[18],di[19],di[20],di[21],di[22],di[23],di[24],di[25],di[26],di[27],di[28],di[29],di[30],di[31]};
*/

assign      swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7],di[8],di[9],di[10],di[11],di[12],di[13],di[14],di[15],
                     di[16],di[17],di[18],di[19],di[20],di[21],di[22],di[23],di[24],di[25],di[26],di[27],di[28],di[29],di[30],di[31]};

wire [31:0] dx;
assign      dx   =  ci[31:0]^swdi[31:0];

assign      co[31]=dx[28]^dx[25]^dx[23]^dx[22]^dx[21]^dx[20]^dx[19]^dx[17]^dx[16]^dx[15]^dx[7]^dx[3]^dx[1]^dx[0]^
            di[34];

assign      co[30]=dx[27]^dx[24]^dx[22]^dx[21]^dx[20]^dx[19]^dx[18]^dx[16]^dx[15]^dx[14]^dx[6]^dx[2]^dx[0]^
            di[32]^di[35];

assign      co[29]=dx[26]^dx[23]^dx[21]^dx[20]^dx[19]^dx[18]^dx[17]^dx[15]^dx[14]^dx[13]^dx[5]^dx[1]^
            di[32]^di[33]^di[36];

assign      co[28]=dx[25]^dx[22]^dx[20]^dx[19]^dx[18]^dx[17]^dx[16]^dx[14]^dx[13]^dx[12]^dx[4]^dx[0]^
            di[33]^di[34]^di[37];

assign      co[27]=dx[31]^dx[24]^dx[21]^dx[19]^dx[18]^dx[17]^dx[16]^dx[15]^dx[13]^dx[12]^dx[11]^dx[3]^
            di[32]^di[34]^di[35]^di[38];

assign      co[26]=dx[31]^dx[30]^dx[23]^dx[20]^dx[18]^dx[17]^dx[16]^dx[15]^dx[14]^dx[12]^dx[11]^dx[10]^dx[2]^
            di[33]^di[35]^di[36]^di[39];

assign      co[25]=dx[30]^dx[29]^dx[28]^dx[25]^dx[23]^dx[21]^dx[20]^dx[14]^dx[13]^dx[11]^dx[10]^dx[9]^dx[7]^dx[3]^dx[0]^
            di[36]^di[37];

assign      co[24]=dx[31]^dx[29]^dx[28]^dx[27]^dx[24]^dx[22]^dx[20]^dx[19]^dx[13]^dx[12]^dx[10]^dx[9]^dx[8]^dx[6]^dx[2]^
            di[32]^di[37]^di[38];

assign      co[23]=dx[31]^dx[30]^dx[28]^dx[27]^dx[26]^dx[23]^dx[21]^dx[19]^dx[18]^dx[12]^dx[11]^dx[9]^dx[8]^dx[7]^dx[5]^dx[1]^
            di[33]^di[38]^di[39];

assign      co[22]=dx[30]^dx[29]^dx[28]^dx[27]^dx[26]^dx[23]^dx[21]^dx[19]^dx[18]^dx[16]^dx[15]^dx[11]^dx[10]^dx[8]^dx[6]^dx[4]^dx[3]^dx[1]^
            di[39];

assign      co[21]=dx[29]^dx[27]^dx[26]^dx[23]^dx[21]^dx[19]^dx[18]^dx[16]^dx[14]^dx[10]^dx[9]^dx[5]^dx[2]^dx[1]^
            di[34];

assign      co[20]=dx[31]^dx[28]^dx[26]^dx[25]^dx[22]^dx[20]^dx[18]^dx[17]^dx[15]^dx[13]^dx[9]^dx[8]^dx[4]^dx[1]^dx[0]^
            di[35];

assign      co[19]=dx[30]^dx[27]^dx[25]^dx[24]^dx[21]^dx[19]^dx[17]^dx[16]^dx[14]^dx[12]^dx[8]^dx[7]^dx[3]^dx[0]^
            di[32]^di[36];

assign      co[18]=dx[31]^dx[29]^dx[26]^dx[24]^dx[23]^dx[20]^dx[18]^dx[16]^dx[15]^dx[13]^dx[11]^dx[7]^dx[6]^dx[2]^
            di[32]^di[33]^di[37];

assign      co[17]=dx[30]^dx[28]^dx[25]^dx[23]^dx[22]^dx[19]^dx[17]^dx[15]^dx[14]^dx[12]^dx[10]^dx[6]^dx[5]^dx[1]^
            di[33]^di[34]^di[38];

assign      co[16]=dx[29]^dx[27]^dx[24]^dx[22]^dx[21]^dx[18]^dx[16]^dx[14]^dx[13]^dx[11]^dx[9]^dx[5]^dx[4]^dx[0]^
            di[34]^di[35]^di[39];

assign      co[15]=dx[26]^dx[25]^dx[22]^dx[19]^dx[16]^dx[13]^dx[12]^dx[10]^dx[8]^dx[7]^dx[4]^dx[1]^dx[0]^
            di[32]^di[34]^di[35]^di[36];

assign      co[14]=dx[25]^dx[24]^dx[21]^dx[18]^dx[15]^dx[12]^dx[11]^dx[9]^dx[7]^dx[6]^dx[3]^dx[0]^
            di[32]^di[33]^di[35]^di[36]^di[37];

assign      co[13]=dx[24]^dx[23]^dx[20]^dx[17]^dx[14]^dx[11]^dx[10]^dx[8]^dx[6]^dx[5]^dx[2]^
            di[32]^di[33]^di[34]^di[36]^di[37]^di[38];

assign      co[12]=dx[23]^dx[22]^dx[19]^dx[16]^dx[13]^dx[10]^dx[9]^dx[7]^dx[5]^dx[4]^dx[1]^
            di[33]^di[34]^di[35]^di[37]^di[38]^di[39];

assign      co[11]=dx[28]^dx[25]^dx[23]^dx[20]^dx[19]^dx[18]^dx[17]^dx[16]^dx[12]^dx[9]^dx[8]^dx[7]^dx[6]^dx[4]^dx[1]^
            di[35]^di[36]^di[38]^di[39];

assign      co[10]=dx[31]^dx[28]^dx[27]^dx[25]^dx[24]^dx[23]^dx[21]^dx[20]^dx[18]^dx[11]^dx[8]^dx[6]^dx[5]^dx[1]^
            di[34]^di[36]^di[37]^di[39];
    
assign      co[9]=dx[31]^dx[30]^dx[28]^dx[27]^dx[26]^dx[25]^dx[24]^dx[21]^dx[16]^dx[15]^dx[10]^dx[5]^dx[4]^dx[3]^dx[1]^
            di[34]^di[35]^di[37]^di[38];

assign      co[8]=dx[30]^dx[29]^dx[27]^dx[26]^dx[25]^dx[24]^dx[23]^dx[20]^dx[15]^dx[14]^dx[9]^dx[4]^dx[3]^dx[2]^dx[0]^
            di[35]^di[36]^di[38]^di[39];

assign      co[7]=dx[31]^dx[29]^dx[26]^dx[24]^dx[21]^dx[20]^dx[17]^dx[16]^dx[15]^dx[14]^dx[13]^dx[8]^dx[7]^dx[2]^dx[0]^
            di[32]^di[34]^di[36]^di[37]^di[39];

assign      co[6]=dx[30]^dx[22]^dx[21]^dx[17]^dx[14]^dx[13]^dx[12]^dx[6]^dx[3]^dx[0]^
            di[32]^di[33]^di[34]^di[35]^di[37]^di[38];

assign      co[5]=dx[31]^dx[29]^dx[21]^dx[20]^dx[16]^dx[13]^dx[12]^dx[11]^dx[5]^dx[2]^
            di[32]^di[33]^di[34]^di[35]^di[36]^di[38]^di[39];

assign      co[4]=dx[31]^dx[30]^dx[25]^dx[23]^dx[22]^dx[21]^dx[17]^dx[16]^dx[12]^dx[11]^dx[10]^dx[7]^dx[4]^dx[3]^dx[0]^
            di[33]^di[35]^di[36]^di[37]^di[39];

assign      co[3]=dx[31]^dx[30]^dx[29]^dx[28]^dx[25]^dx[24]^dx[23]^dx[19]^dx[17]^dx[11]^dx[10]^dx[9]^dx[7]^dx[6]^dx[2]^dx[1]^dx[0]^
            di[32]^di[36]^di[37]^di[38];

assign      co[2]=dx[31]^dx[30]^dx[29]^dx[28]^dx[27]^dx[24]^dx[23]^dx[22]^dx[18]^dx[16]^dx[10]^dx[9]^dx[8]^dx[6]^dx[5]^dx[1]^dx[0]^
            di[32]^di[33]^di[37]^di[38]^di[39];

assign      co[1]=dx[30]^dx[29]^dx[27]^dx[26]^dx[25]^dx[20]^dx[19]^dx[16]^dx[9]^dx[8]^dx[5]^dx[4]^dx[3]^dx[1]^
            di[32]^di[33]^di[38]^di[39];

assign      co[0]=dx[29]^dx[26]^dx[24]^dx[23]^dx[22]^dx[21]^dx[20]^dx[18]^dx[17]^dx[16]^dx[8]^dx[4]^dx[2]^dx[1]^
            di[33]^di[39];
       

endmodule 
