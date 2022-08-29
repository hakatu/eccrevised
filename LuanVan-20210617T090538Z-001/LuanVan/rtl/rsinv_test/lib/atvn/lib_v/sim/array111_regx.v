////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array111_regx.v
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
////////////////////////////////////////////////////////////////////////////////

module array111_regx (rst_,wclk,wa,we,di,rclk,ra,do);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";
parameter RSTVAL = {WIDTH{1'b0}};

input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
output [WIDTH-1:0]  do;

////////////////////////////////////////////////////////////////////////////////
reg [WIDTH-1:0]     do;
reg [WIDTH-1:0]     reg_array [DEPTH-1:0];

integer i;

always @ (posedge wclk or negedge rst_)
    begin
    if (~rst_)
        begin
        for (i = 0; i < DEPTH; i = i + 1)
            begin
            //reg_array[i] <= {WIDTH{1'b0}};
            reg_array[i] <= RSTVAL;
            end
        end
    else if (we)
        begin
        reg_array[wa] <= di;
        end
    end

always @ (posedge rclk or negedge rst_)
    begin
    if (~rst_)
        begin
        do <= {WIDTH{1'b0}};
        end
    else
        begin
        do <= reg_array[ra];
        end
    end

endmodule