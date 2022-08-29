////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlpconfig.v
// Description  : .
//
// Author       : thhuy@HW-THHUY
// Created On   : Fri Aug 15 19:20:06 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlpconfig
    (
     clk,
     rst,
     upen,
     upws,
     uprs,
     updi,
     out,
     uprdy,
     updo
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WIDTH = 8;
parameter           RESET_VALUE = {WIDTH{1'b0}};

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst,
                    upen,               // Microprocessor enable
                    upws,
                    uprs;               // Microprocessor write strobe
        
input [WIDTH-1:0]   updi;   // Microprocessor data in
output [WIDTH-1:0]  out;
output              uprdy;
output [WIDTH-1:0]  updo;   // Microprocessor data out

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [WIDTH-1:0]    out;
wire                uprdy;
wire [WIDTH-1:0]    updo;   // Microprocessor data out

pconfigx #(WIDTH,RESET_VALUE) ipconfigx
    (
     .clk   (clk),
     .rst  (rst),
     .upen  (upen),
     .upws  (upws),
     .updi  (updi),
     .out   (out),
     .updo  (updo)
     );

wire                uprdy0;
assign              uprdy0 = upen & (upws | uprs);

fflopx #(1) pluprdy(clk,rst,uprdy0,uprdy);

endmodule 
