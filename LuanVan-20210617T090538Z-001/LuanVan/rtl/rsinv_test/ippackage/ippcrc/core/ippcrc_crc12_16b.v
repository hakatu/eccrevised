module ippcrc_crc12_16b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [15:0]   di;

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

assign          co[11]=dx[11]^dx[10]^dx[9]^dx[8]^dx[7]^dx[6]^dx[3]^dx[2]^dx[1]^dx[0]^
                       di[12]^di[13]^di[14]^di[15];

assign          co[10]=dx[5]^dx[3];
       
assign          co[9] =dx[11]^dx[4]^dx[2];
       
assign          co[8] =dx[10]^dx[3]^dx[1];
       
assign          co[7] =dx[9]^dx[2]^dx[0];
       
assign          co[6] =dx[8]^dx[1]^
                       di[12];

assign          co[5] =dx[11]^dx[7]^dx[0]^
                       di[13];

assign          co[4] =dx[10]^dx[6]^
                       di[12]^di[14];

assign          co[3] =dx[9]^dx[5]^
                       di[13]^di[15];

assign          co[2] =dx[11]^dx[10]^dx[9]^dx[7]^dx[6]^dx[4]^dx[3]^dx[2]^dx[1]^dx[0]^
                       di[12]^di[13]^di[15];

assign          co[1] =dx[7]^dx[5]^
                       di[15];

assign          co[0] =dx[11]^dx[10]^dx[9]^dx[8]^dx[7]^dx[4]^dx[3]^dx[2]^dx[1]^dx[0]^
                       di[12]^di[13]^di[14]^di[15];

endmodule