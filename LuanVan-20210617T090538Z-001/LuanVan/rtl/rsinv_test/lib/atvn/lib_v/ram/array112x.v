////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array112x.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Apr 14 11:04:54 2004
// History (Date, Changed By)
//  Mon Jul 27 14:40:33 2009, ndtu@HW-NDTU
//      add parameter MAXDEPTH for better resource usage
//  Fri Aug 23 09:21:00 2013, tund@HW-NDTU
//      add parameter MEM_RESET to off clear MEMORY
//  Thu Aug 20 10:04:34 2015, cuongnv@HW-NVCUONG
//      change rst_ to rst
////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy = "yes" *) module array112x
    (
     rst,
     wclk,
     wa,
     we,
     di,
     rclk,
     ra,
     do
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ADDRBIT = 5;
parameter DEPTH = 32;
parameter WIDTH = 32;
parameter TYPE = "AUTO";     //"M512" , "M4K", "M-RAM", "AUTO"
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";
parameter NUMCLK= 1;// 1 is one clock domain, 2 is two clock domain
parameter NCLK = 2;// 2: use ram2clk, 1: use ram 1clk + pp output  

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input       rst;
input       wclk;
input [ADDRBIT-1:0] wa;     // @+clk
input            we;     // @+clk
input [WIDTH-1:0] di;     // @+clk
input             rclk;
input [ADDRBIT-1:0]  ra;     // @+clk
output [WIDTH-1:0] do;     // @+clk
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

`ifdef  RTL_SIMULATION
wire [WIDTH-1:0] ido;     // @+clk
fflopx #(WIDTH) ppido (rclk,rst,ido,do);
wire   sameadd = (iwe & (iwa == ra));
wire   re = !sameadd;
iramrwpx #(ADDRBIT,DEPTH,WIDTH) array (wclk,iwa,iwe,idi,rclk,ra,re,ido,1'b0,1'b0);
`else
alsyncram112x #(ADDRBIT,DEPTH,WIDTH,TYPE,MAXDEPTH,NUMCLK,NCLK) mem
    (
    .data(idi),
    .wren(iwe),
    .wraddress(iwa),
    .rdaddress(ra),
    .wrclock(wclk),
    .rdclock(rclk),
    .q(do)
    );
`endif
endmodule 
