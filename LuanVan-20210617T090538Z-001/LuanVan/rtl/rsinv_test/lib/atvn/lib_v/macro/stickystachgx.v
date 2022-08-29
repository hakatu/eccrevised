//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : stickyx.v
// Description     : sticky bits, write "1" to clear
//
// Author          : lapnq@atvn.com.vn
// Created On      : Tue Jul 29 17:56:53 2003
// History (Date, Changed By)
//  Added upactive, Wed Feb 18 15:55:48 2004, by lqcuong
// Thu Aug 20 11:21:58 2015, cuongnv@HW-NVCUONG, change rst_ to rst
//////////////////////////////////////////////////////////////////////////////////

module stickystachgx
    (
     clk,
     rst,
     upactive,
     alarmvld,// should be register for good timing
     alarmsta,// should be register for good timing
     upen,
     upws,
     updi,
     updo,
     lalarm     // OR to get 
     );

parameter           WIDTH = 8;
input               clk;
input               rst;
input               upactive;
input   [1:0]       upen;           // {upen_intr,upen_alarm}
input               upws;           // processor write strobe
input   [WIDTH-1:0] alarmvld,
                    alarmsta;          // alarms in
input   [WIDTH-1:0] updi;           // processor data in

output  [WIDTH-1:0] updo;           // processor data out
output  [WIDTH-1:0] lalarm;         // latched alarms out

wire                upen_intr,upen_alarm;
assign              {upen_intr,upen_alarm} = upen[1:0];

wire                we;
assign              we = upen_intr & upws;

reg     [WIDTH-1:0] lalarm = {WIDTH{1'b0}}; // State change
reg     [WIDTH-1:0] alarm = {WIDTH{1'b0}};  // Current status

assign updo = upen_alarm ? alarm : upen_intr ? lalarm : {WIDTH{1'b0}};

// Current status
integer             i;
always @(posedge clk)
    begin
    if (rst)    
        alarm <= {WIDTH{1'b0}};
    else if (~upactive)
        begin
        if(we) alarm <= updi;
        end
    else
        begin
        for (i=0;i<WIDTH;i=i+1) if (alarmvld[i])    alarm[i] <= alarmsta[i];
        end
    end

// State change
wire [WIDTH-1:0]    alarmchg;
assign              alarmchg = alarmvld & (alarmsta ^ alarm);

always @(posedge clk)
    begin
    if (rst) 
        lalarm <= {WIDTH{1'b0}};
    else if (~upactive)
        begin
        if(we) lalarm <= updi;
        end
    else if (we)
        lalarm <= alarmchg | (lalarm & ~updi);
    else 
        lalarm <= alarmchg | lalarm;
    end

endmodule
