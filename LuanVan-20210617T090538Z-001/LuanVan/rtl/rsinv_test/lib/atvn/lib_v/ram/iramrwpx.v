//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : iramrwpx.v
// Description     : a library of read write port RAM model with dual clocks
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 16:38:23 2002
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//      Wed Sep 07 15:31:33 2005, ddduc
//          modified from ramrwpx
//          added new control signals and violation reports
//      Fri Sep 09 16:55:04 2005, ddduc
//          added write violations
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
//
//////////////////////////////////////////////////////////////////////////////////
// +display collision at write side
//      DISPLAY_ERR_RAM_WR = "ON"
// +no display collision at write side
//      DISPLAY_ERR_RAM_WR = "OFF" or define `DISPLAY_ERR_RAM_WR_OFF
// +display collision at read side
//      DISPLAY_ERR_RAM_RD = "ON"
// +no display collision at read side
//      DISPLAY_ERR_RAM_WR = "OFF" or define `DISPLAY_ERR_RAM_WR_OFF
// +turn off write X when collision at write side
//      `ERR_RAM_WR_X_OFF

module iramrwpx
    (
     wclk,
     wa,
     we,
     di,
     
     rclk,
     ra,
     re,
     do,
     
     test,
     mask
     );

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter DISPLAY_ERR_RAM_WR = "ON";
parameter DISPLAY_ERR_RAM_RD = "ON";
parameter ERR_RAM_WR_X  = "ON";
parameter ERR_RAM_RD_X  = "ON";

input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
input               re;
output [WIDTH-1:0]  do;
input               mask;   // =1 -> re is disable
input               test;   // wr and rd are disable

reg [WIDTH-1:0] ram [DEPTH-1:0]/*synthesis syn_ramstyle = "block_ram" */;
//reg [WIDTH-1:0] ram [DEPTH-1:0]/*synthesis syn_ramstyle = "RAMB8BWER" */;
reg [WIDTH-1:0] do;

integer i;
initial begin for(i=0;i<DEPTH;i=i+1) ram[i] = {WIDTH{1'b0}}; end

always @ (posedge wclk)
    begin
    if (we)
            begin
            ram[wa] <= di;
            end
         
    end

always @ (posedge rclk)
    begin
    if (re)
            begin
            do  <= ram[ra];
            end
    else    do  <= {WIDTH{1'bx}};
    end


endmodule

