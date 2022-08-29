////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlwartermark.v
// Description  : .
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Fri Oct 03 10:26:16 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlwartermark
    (
     clk,
     rst,
     dtvl,
     data,
     //CPU
     upact,
     upen,
     upa,
     upws,
     uprs,
     updi,
     updo,
     uprdy
     );

parameter BW = 32;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input           clk;
input           rst;
input           dtvl;
input [BW-1:0]  data;

input           upact;
input           upen;
input [1:0]     upa;
input           upws;
input           uprs;
input [BW-1:0]  updi;
output [BW-1:0] updo;
output          uprdy;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//current data
wire            crrdtvl;
fflopx #(1)     ppin (clk,rst,dtvl,crrdtvl);

wire            crrpen;
wire [BW-1:0]   crrpdo;
reg [BW-1:0]    crrdata;
always @(posedge clk)
    begin
    if(rst) crrdata <= {BW{1'b0}};
    else if(dtvl) crrdata <= data;
    end
assign crrpdo = crrpen ? crrdata : {BW{1'b0}};

//Mininum data
wire            minpen;
wire [BW-1:0]   minpdo;
watermarkx #(BW,1)  wmmin
    (
     .clk       (clk),
     .rst      (rst),
     .dtvl      (crrdtvl),
     .alarm     (crrdata),
     .upact     (upact),
     .upen      (minpen),
     .upws      (upws),
     .updi      (updi[BW-1:0]),
     .updo      (minpdo),
     .lalarm    ()
     );

//Mininum data
wire            maxpen;
wire [BW-1:0]   maxpdo;
watermarkx #(BW,0)  wmmax
    (
     .clk       (clk),
     .rst      (rst),
     .dtvl      (crrdtvl),
     .alarm     (crrdata),
     .upact     (upact),
     .upen      (maxpen),
     .upws      (upws),
     .updi      (updi[BW-1:0]),
     .updo      (maxpdo),
     .lalarm    ()
     );

wire            uprdy;
assign          uprdy = upen & (upws | uprs);
wire [BW-1:0]   updo;
assign          updo = crrpdo | minpdo | maxpdo;
assign          minpen = upen & (upa[1:0] == 2'b00);
assign          maxpen = upen & (upa[1:0] == 2'b01);
assign          crrpen = upen & (upa[1:0] == 2'b10);
 
endmodule 
