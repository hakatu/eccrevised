//Note:  LSB first
module ippcrc_crc12_8b
    (
     ci,
     di,

     co
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [11:0]   ci;
input [7:0]    di;

output [11:0]  co;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [11:0]    co;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [7:0]     swdi;
assign         swdi =  {di[0],di[1],di[2],di[3],di[4],di[5],di[6],di[7]};

wire [7:0]     dx;
assign         dx   =  ci[11:4]^swdi[7:0];

assign         co[11]= dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[2]^dx[1]^dx[0]^ci[3];
assign         co[10]= dx[7]^ci[2];
assign         co[9] = dx[6]^ci[1];
assign         co[8] = dx[7]^dx[5]^ci[0];
assign         co[7] = dx[6]^dx[4];
assign         co[6] = dx[5]^dx[3];
assign         co[5] = dx[4]^dx[2];
assign         co[4] = dx[3]^dx[1];
assign         co[3] = dx[2]^dx[0];
assign         co[2] = dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[2]^dx[0];
assign         co[1] = dx[0];
assign         co[0] = dx[7]^dx[6]^dx[5]^dx[4]^dx[3]^dx[2]^dx[1]^dx[0];

endmodule
       