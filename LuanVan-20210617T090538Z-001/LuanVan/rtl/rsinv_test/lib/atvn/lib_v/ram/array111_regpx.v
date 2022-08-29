////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array111_regpx.v
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
//  Thu Aug 20 09:59:18 2015, cuongnv@HW-NVCUONG
//      change rst_ to rst
////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy = "yes" *) module array111_regpx (rst,wclk,wa,we,di,rclk,ra,do,par_ctrl,par_err);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";
parameter RSTVAL = {WIDTH{1'b0}};
parameter NUMCLK= 1;// 1 is one clock domain, 2 is two clock domain

input               rst;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
output [WIDTH-1:0]  do;
input [1:0]         par_ctrl;
                //[0]: parity error clear - [1]: Disable parity calculation for testing
output              par_err; // Parity Error Sticky Out
assign              par_err  = 1'b0;

reg [ADDRBIT-1:0]   cnt;
wire [ADDRBIT-1:0]  iwa;
wire                iwe;
wire [WIDTH-1:0]    idi;

generate
    if (MEM_RESET == "ON")
        begin: on_reset
always @(posedge wclk) cnt <= cnt + 1'b1;
assign iwa  = rst ? cnt : wa;
assign iwe  = rst ? 1'b1 : we;
assign idi  = rst ? {WIDTH{1'b0}} : di;
        end
    else
        begin: off_reset
assign iwa  = wa;
assign iwe  = we;
assign idi  = di;
        end
endgenerate

altsyncram111x #(ADDRBIT,DEPTH,WIDTH,TYPE,MAXDEPTH) ram(idi,iwe,iwa,ra,wclk,rclk,do);

endmodule