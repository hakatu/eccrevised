////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array121_regx.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Mon Apr 19 14:53:03 2004
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module array121_regx (rst_,wclk,wa,we,di,rclk1,ra1,do1,rclk2,ra2,do2);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
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


////////////////////////////////////////////////////////////////////////////////
reg [WIDTH-1:0]     do1, do2;
reg [WIDTH-1:0]     reg_array [DEPTH-1:0];

integer i;

always @ (posedge wclk or negedge rst_)
    begin
    if (~rst_)
        begin
        for (i = 0; i < DEPTH; i = i + 1)
            begin
            reg_array[i] <= {WIDTH{1'b0}};
            end
        end
    else if (we)
        begin
        reg_array[wa] <= di;
        end
    end

always @ (posedge rclk1 or negedge rst_)
    begin
    if (~rst_)
        begin
        do1 <= {WIDTH{1'b0}};
        end
    else
        begin
        do1 <= reg_array[ra1];
        end
    end

always @ (posedge rclk2 or negedge rst_)
    begin
    if (~rst_)
        begin
        do2 <= {WIDTH{1'b0}};
        end
    else
        begin
        do2 <= reg_array[ra2];
        end
    end

endmodule