////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : alram112x.v
// Description  : ram 256 bit x 32;
//
// Author       : PC@DESKTOP-9FI2JF9
// Created On   : Sat Apr 20 18:19:40 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
//define RWSAMECLK to enable the feature

module alram112x
    (
     clkw,//clock write
     clkr,//clock read
     rst,
     
     rdo,//data from ram
     ra,//read address
     
     wdi,//data to ram
     wa,//write address
     we //write enable
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WID = 256;
parameter AWID = 5; //address width
parameter DEP = 1<<AWID;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input clkw;
input clkr;
input rst;

output [WID-1:0] rdo;
input [AWID-1:0] ra;

input [WID-1:0]  wdi;
input [AWID-1:0] wa;
input            we;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [WID-1:0]    mem [DEP-1:0]; //

reg [AWID-1:0]   ra_reg;
reg [WID-1:0]    rdonor;

always@(posedge clkw)
    begin
    if(we)
        mem[wa] <= wdi;
    end

always@(posedge clkr)
    begin
    rdonor <= mem[ra_reg];
    ra_reg <= ra;
    end

`ifdef RWSAMECLK
wire sa; //same address
wire [WID-1:0] wdi1;
wire [WID-1:0] wdi2;

assign sa = ra == wa;

wire   sa2;
ffxkclkx #(2,1) isa (clk, rst, sa, sa2);

fflopx #(256) ifflopx1(clkw,rst,wdi,wdi1);
fflopx #(256) ifflopx2(clkw,rst,wdi1,wdi2);

assign rdo = sa2? wdi2 : rdonor;

`else

assign rdo =  rdonor;

`endif

always@(posedge clkw)
    begin
    if(rst)
        begin
        mem[18] <= 256'd0;
        mem[19] <= 256'd1;
        end
    end

`ifdef TESTWRAPMONT
always@(posedge clkw)
    begin
    if(rst)
        begin
        mem[0] <= 256'd123;//X_G
        mem[11] <= 256'd11232131;//K
        mem[30] <= 256'hACCEDE;
        end
    end
`endif

endmodule