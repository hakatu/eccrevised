//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : ramspx.v
// Description     : a library of single port RAM model
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 15:49:51 2002
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////// 

module ramspx (clk,a,we,di,do);

parameter ADDRBIT = 11;
parameter DEPTH = 1536;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

input               clk;
input [ADDRBIT-1:0] a;
input               we;
input [WIDTH-1:0]   di;
output [WIDTH-1:0]  do;

reg [WIDTH-1:0] ram [DEPTH-1:0];
reg [WIDTH-1:0] do;

integer i;
initial
    begin 
    for(i=0;i<DEPTH;i=i+1)
        ram[i] = {WIDTH{1'b0}};
    end

always @ (posedge clk)
    begin
    if (we)
        begin
        ram[a] <= di;
        //do <= {WIDTH{1'bx}};  do not like altera model.
        end
    else do <= ram[a];
    end

endmodule

