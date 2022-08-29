////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array111x.v
// Description  : a library of a register array model with
//                  1 read ports and 1 write port.
//
// Author       : ddduc@HW-DDDUC
// Created On   : Tue Oct 21 20:49:10 2003
// History (Date, Changed By)
//  Thu Nov 13 09:36:19 2003, ddduc, Added rst_ pin 
//  Mon Jul 27 14:40:33 2009, ndtu@HW-NDTU
//      add parameter MAXDEPTH for better resource usage
//  Fri Aug 23 09:21:00 2013, tund@HW-NDTU
//      add parameter MEM_RESET to off clear MEMORY
//
////////////////////////////////////////////////////////////////////////////////

module array111x (rst_,wclk,wa,we,di,rclk,ra,do);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";

input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
output [WIDTH-1:0]  do;

ramrwpx #(ADDRBIT,DEPTH,WIDTH) ram (wclk,wa,we,di,rclk,ra,do);

endmodule