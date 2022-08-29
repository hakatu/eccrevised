////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af4eos_agg_ffcvrt.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Fri Oct 14 14:29:05 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af4eos_agg_ffcvrt
    (
     // write direction
     wclk,
     wrst,
     wen,
     wdat,
     wfull,
     whfull,
     wlen,
     // readn direction
     rclk,
     rrst,
     ren,
     rdat,
     rempty
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           ADR = 8,
                    DEP = 256,
                    DAT = 8,
                    TYP = "AUTO",
                    MAX = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
// write direction
input               wclk;
input               wrst;
input               wen;
input [DAT-1:0]     wdat;
output              wfull;
output              whfull;
output [ADR:0]      wlen;

// readn direction
input               rclk;
input               rrst;
input               ren;
output [DAT-1:0]    rdat;
output              rempty;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
/****************************************************************************************************************
 *                                           _______________________                                            *
 *                                          |                       |                                           *
 * wdat ===================================>|wdat              rdat |===================================>rdat   *
 *                                ______    |                       |                                           *
 *                         wen   |      |   |      FIFO MEMORY      |                                           *
 *          +------------------->|      |   |                       |                                           *
 *          |                    |    & |==>|wen                    |                                           *
 * wfull <--|-----------+------->|~     |   |                       |                                           *
 *          |           |  wfull |______|   |                       |                                           *
 *          |    _______|______             |                       |             ______________                *
 *          |   |              |            |                       |            |              |               *
 *          |   | wprt controll|            |                       |            | rprt controll|               *
 *          |   |              |            |                       |            |              |               *
 *          |   |         waddr|===========>|waddr             raddr|<===========|raddr         |               *
 *          |   |              |            |                       |            |              |               *
 *          |   |              |     wclk-->|>wclk                  |            |              |               *
 *          |   |              |            |_______________________|            |              |               *
 * wen------+-->|wen           |                                                 |          ren |<-------ren    *
 *              |        gwprt |=====================\\    //====================|grprt         |               *
 *              |              |                      \\  //                     |       rempty |------->rempty *
 *              |              |    ____      ____     \\//    ____      ____    |              |               *
 *              |              |   |    |    |    |    //\    |    |    |    |   |              |               *
 *              |         grprt|<==|    |<===|    |<==// \\==>|    |===>|    |==>|gwprt         |               *
 *          +-->|>wclk         |   |    |    |    |           |    |    |    |   |         rclk<|<--+           *
 *          |   |              |   |   <|<-+ |   <|<-+     +->|>   | +->|>   |   |              |   |           *
 *          |   |______________|   |____|  | |____|  |     |  |____| |  |____|   |______________|   |           *
 *          |           |            |     |    |    |     |    |    |    |              |          |           *
 *          |           |            |     |    |    |     |    |    |    |              |          |           *
 * wclk ----+-----------|------------|-----+----|----+     +----|----+----|--------------|----------+----rclk   *
 *                      |            |          |               |         |              |                      *
 * wrst----------------+------------+----------+               +---------+--------------+---------------rrst  *
 *                                                                                                              *
 ****************************************************************************************************************
 */
wire [ADR-1:0]      waddr;
wire [ADR-1:0]      raddr;
wire [ADR:0]        gwprt;
wire [ADR:0]        grprt;

wire                rst;
assign              rst = wrst | rrst;
/*
//2 clk domain change like this may cause rd wr pointer not be reset same time 
wire                rrstwclk0,rrstwclk;
fflopnx #(1)         ffrrstwclk0 (wclk,wrst,rrst,rrstwclk0);
fflopnx #(1)         ffrrstwclk (wclk,wrst,rrstwclk0,rrstwclk);

wire                wrstrclk0,wrstrclk;
fflopnx #(1)         ffwrstrclk0 (rclk,rrst,wrst,wrstrclk0);
fflopnx #(1)         ffwrstrclk (rclk,rrst,wrstrclk0,wrstrclk);

wire                rstwrclk;
assign              rstwrclk = wrst | rrstwclk;

wire                rstrdclk;
assign              rstrdclk = rrst | wrstrclk;
*/

wire                owrst;
asyn_rst           wr_asyn_rst (.clk (wclk), .irst (rst), .orst (owrst));
//asyn_rst           wr_asyn_rst (.clk (wclk), .irst (rstwrclk), .orst (owrst));
wire                orrst;
asyn_rst           rd_asyn_rst (.clk (rclk), .irst (rst), .orst (orrst));
//asyn_rst           rd_asyn_rst (.clk (rclk), .irst (rstrdclk), .orst (orrst));

// pointer write
af4eos_agg_wprt_ctrl    af4eos_agg_wprt_ctrl
    (
     .wrst     (owrst),
     .wclk      (wclk),
     .wen       (wen),
     .waddr     (waddr),
     .gwprt     (gwprt),
     .grprt     (grprt),
     .wfull     (wfull),
     .whfull    (whfull),
     .wlen      (wlen)
     
     );
defparam            af4eos_agg_wprt_ctrl.ADDR = ADR,
                    af4eos_agg_wprt_ctrl.DEP  = DEP;//130702 minhtc fix bug_aggdec_130621
// pointer read
af4eos_agg_rprt_ctrl    af4eos_agg_rprt_ctrl
    (
     .rrst     (orrst),
     .rclk      (rclk),
     .ren       (ren),
     .raddr     (raddr),
     .grprt     (grprt),
     .gwprt     (gwprt),
     .rempty    (rempty),
     .rdy       ()
     
     );
defparam            af4eos_agg_rprt_ctrl.ADDR = ADR;
// data
/*
altsyncram112x_2clk af4eos_agg_data
    (
     .wrclock   (wclk),
     .wren      (wen),
     .wraddress (waddr),
     .data      (wdat),
     .rdclock   (rclk),
     .rden      (ren),
     .rdaddress (raddr),
     .q         (rdat)
     );
defparam            af4eos_agg_data.ADR = ADR,
                    af4eos_agg_data.DEP = DEP,
                    af4eos_agg_data.DAT = DAT,
                    af4eos_agg_data.TYP = TYP,
                    af4eos_agg_data.MAX = MAX;
 */
// use old lib
iarray112x    af4eos_agg_data
    (
     .wrst     (owrst),
     .wclk      (wclk),
     .wa        (waddr),
     .we        (wen),
     .di        (wdat),

     .rrst     (orrst),
     .rclk      (rclk),
     .ra        (raddr),
     .re        (ren),
     .do        (rdat),

     .test      (1'b0),
     .mask      (1'b0)
     );
defparam af4eos_agg_data.ADDRBIT    = ADR,
         af4eos_agg_data.DEPTH      = DEP,
         af4eos_agg_data.WIDTH      = DAT,
         af4eos_agg_data.TYPE       = TYP,
         af4eos_agg_data.MAXDEPTH   = MAX,
         af4eos_agg_data.MEM_RESET  = "OFF",
         af4eos_agg_data.NUMCLK     = 2;


endmodule 
