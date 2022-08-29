////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : mem2r1wx.v
// Description  : 
//
// Author       : ddduc@HW-DDDUC
// Created On   : Tue Oct 21 20:49:10 2003
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
////////////////////////////////////////////////////////////////////////////////

module mem2r1wx (rst_,wclk,wa,we,di,rclk1,ra1,do1,rclk2,ra2,do2);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";        //This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;

input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk1;
input [ADDRBIT-1:0] ra1;
output [WIDTH-1:0]  do1;
input               rclk2;
input [ADDRBIT-1:0] ra2;
output [WIDTH-1:0]  do2;

memrwpx #(ADDRBIT,DEPTH,WIDTH) ram1 (rst_,wclk,wa,we,di,rclk1,ra1,do1);
memrwpx #(ADDRBIT,DEPTH,WIDTH) ram2 (rst_,wclk,wa,we,di,rclk2,ra2,do2);

endmodule

