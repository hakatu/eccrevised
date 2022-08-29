////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : watermarkx.v
// Description  : .
//
// Author       : ndthanh@HW-NDTHANH
// Created On   : Mon Jul 07 13:50:57 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module watermarkx
    (
     clk,
     rst,
     dtvl,
     alarm,
     upact,
     upen,
     upws,
     updi,
     updo,
     lalarm
     );

parameter           WIDTH = 8;
parameter           MODE  = 0;// 0:higher watermark; 1:lower watermark

input               clk;
input               rst;
input               dtvl;
input   [WIDTH-1:0] alarm;          // alarms in
input               upact;
input               upen;           // processor enable
input               upws;           // processor write strobe
input   [WIDTH-1:0] updi;           // processor data in

output  [WIDTH-1:0] updo;           // processor data out
output  [WIDTH-1:0] lalarm;         // latched alarms out

wire                we;
assign              we = upen & upws;

reg [WIDTH-1:0]     lalarm;

assign              updo = upen ? lalarm : {WIDTH{1'b0}};

always @(posedge clk)
    begin
    if (rst) 
        lalarm <= MODE ? {WIDTH{1'b1}} : {WIDTH{1'b0}};
    else if (!upact) 
        lalarm <= MODE ? {WIDTH{1'b1}} : {WIDTH{1'b0}};
    else if (we) 
        lalarm <= updi;
    else if (dtvl)
        begin
        if (MODE)
            begin
            if(alarm < lalarm) lalarm <= alarm;
            end
        else
            begin
            if(alarm > lalarm) lalarm <= alarm;
            end
        end
    end

endmodule
