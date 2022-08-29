////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlreqack.v
// Description  : .
//
// Author       : tund@HW-NDTU
// Created On   : Thu Sep 27 10:00:01 2012
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlreqack
    (
     clk,
     rst,

     // REQ/ACK interface
     req,
     reqinfo,
     ack,
     vld,

     // Write valid information into a FIFO to request 
     fifowr,
     fifodi,

     // Control/monitor
     flush,
     reqen,
     fifowrerr,
     fiforderr,
     fifofull,
     fifowa,
     fifolen
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           ADD = 8;
parameter           LEN = 256;
parameter           WIDTH = 128;
parameter           TYPE = "AUTO";

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

output              req;
output [WIDTH-1:0]  reqinfo;
input               ack;
output              vld;
input               flush;
input               reqen;         
input               fifowr;
input [WIDTH-1:0]   fifodi;

output              fifowrerr;
output              fiforderr;
output              fifofull;
output [ADD-1:0]    fifowa;
output [ADD:0]      fifolen;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

rtlfifordy2ck ififo
    (
     .wrclk         (clk),
     .wrrst        (rst),
     .rdclk         (clk),
     .rdrst        (rst),
     
     // Output interface @rdclk
     .fifordy       (req),
     .fifodout      (reqinfo),
     .fifoget       (ack),
     .fifovld       (vld),
     
     // Write interface @wrclk
     .fifowr        (fifowr),
     .fifodi        (fifodi),
     
     // Control/monitor
     .flush         (flush),
     .reqen         (reqen),
     .fifowrerr     (fifowrerr),
     .fiforderr     (fiforderr),
     .fifofull      (fifofull),
     .fifolen       (fifolen),
     .fifowa        (fifowa)
     );
defparam
        ififo.ADD = ADD,
        ififo.LEN = LEN,
        ififo.WIDTH = WIDTH,
        ififo.TYPE = TYPE,
        ififo.DUAL_CLK = "OFF";

endmodule 
