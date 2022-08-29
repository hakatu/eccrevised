////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af6x_reqbuf.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Mon Jun 27 13:44:28 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af6cesrtl_gapbuf_115
    (clk,
     rst,

     // Write valid info to buffer
     ivld,
     ivldinfo,
     ovldfull,
     ovldlen,
     
     // Flush
     flush,
     
     // Request info
     oreq,
     oreqinfo,
     iget
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   ADD = 4;
parameter   INFO = 32;
parameter   TYPE = "AUTO";

parameter   LEN = {1'b1,{ADD{1'b0}}};
 
////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               ivld;
input [INFO-1:0]    ivldinfo;
output              ovldfull;
output [ADD:0]      ovldlen;

input               flush;

output              oreq;
output [INFO-1:0]   oreqinfo;
input               iget;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg                 flush1; 
reg                 flush2/*synthesis preserve*/; 

always @ (posedge clk)
    begin
    if (rst)
        begin
        flush1 <= 1'b1;
        flush2 <= 1'b1;
        end
    else
        begin
        flush1 <= flush;
        flush2 <= flush1;
        end
    end

wire                fiford,notempty,ovldfull;
//wire [ADD:0]        fifolen;

wire                fifo_we;
wire [ADD-1:0]      fifo_wa;
wire [INFO-1:0]     fifo_di = ivldinfo;
wire                fifo_re;
wire [ADD-1:0]      fifo_ra;
wire [INFO-1:0]     fifo_rdd;

fifoc_fshx #(ADD,LEN) fifobuf
    (
     .clk(clk),
     .rst(rst),
     
     .fiford(fiford),    // FIFO control
     .fifowr(ivld),
     .fifofsh(flush2),   // FIFO flush

     .fifofull(),  // high when fifo full
     .notempty(notempty),  // high when fifo not empty
     .fifolen(),   

                // Connect to memories
     .write(fifo_we),     // enable to write memories
     .wraddr(fifo_wa),    // write address of memories
     .read(fifo_re),      // enable to read memories
     .rdaddr(fifo_ra)     // read address of memories
     );
iarray115_bigram #(ADD,LEN,INFO,TYPE) memfifo
    (
     .wrst(1'b1),
     .wclk(clk),
     .wa(fifo_wa),
     .we(fifo_we),
     .di(fifo_di),
     .rclk(clk),
     .rrst(1'b1),
     .ra(fifo_ra),
     .re(fifo_re),
     .do(fifo_rdd),
     .mask(1'b0),
     .test(1'b0)
     );

////////////////////////////////////////////////////////////////////////////////
// Read RAM and store to a register FIFO to request clock by clock
// This logic refer to fifox.v on atvn/lib_v/macro
reg                 fiford1 = 1'b0;
reg                 fiford2 = 1'b0;
reg                 fiford3 = 1'b0;
reg                 fiford4 = 1'b0;
reg                 fiford5 = 1'b0;
always @ (posedge clk)
    begin
    if (flush2) {fiford1,fiford2,fiford3,fiford4,fiford5} <= 5'd0;
    else        {fiford1,fiford2,fiford3,fiford4,fiford5} <= {fiford,fiford1,fiford2,fiford3,fiford4};
    end

reg [INFO-1:0]  reqfifo0 = {INFO{1'b0}};
reg [INFO-1:0]  reqfifo1 = {INFO{1'b0}};
reg [INFO-1:0]  reqfifo2 = {INFO{1'b0}};
reg [INFO-1:0]  reqfifo3 = {INFO{1'b0}};

reg [2:0]       reqlen = 3'd0;
reg [1:0]       reqwrcnt = 2'd0;

wire [1:0]      reqrdcnt;
assign          reqrdcnt = reqwrcnt - reqlen[1:0];

wire            reqnemp;
assign          reqnemp = |reqlen;

wire            reqread;

wire            reqfull;
assign          reqfull = reqlen[2];

wire            reqwrite;
assign          reqwrite = fiford5 & (~reqfull);

//wire            reqwerr;
//assign          reqwerr = fiford5 & reqfull;

always @(posedge clk)
    begin
    if (flush2)         reqwrcnt <= {2{1'b0}};
    else if (reqwrite)  reqwrcnt <= reqwrcnt + 1'b1;
    end

always @(posedge clk)
    begin
    if (flush2) reqlen <= {1'b0,{2{1'b0}}};
    else 
        begin
        case ({reqread,reqwrite})
            2'b01: reqlen <= reqlen + 1'b1;
            2'b10: reqlen <= reqlen - 1'b1;
            default:    reqlen <= reqlen;
        endcase
    end
    end

always @ (posedge clk)
    begin
    if  (reqwrite & (reqwrcnt == 2'd0)) reqfifo0 <= fifo_rdd;
    if  (reqwrite & (reqwrcnt == 2'd1)) reqfifo1 <= fifo_rdd;
    if  (reqwrite & (reqwrcnt == 2'd2)) reqfifo2 <= fifo_rdd;
    if  (reqwrite & (reqwrcnt == 2'd3)) reqfifo3 <= fifo_rdd;
    end

reg         oreq = 1'b0;
always @ (posedge clk)
    begin
    if (flush2) oreq <= 1'd0;
    else        oreq <= !iget & (reqnemp | oreq);
    end

assign          reqread = reqnemp & (!oreq);

reg [INFO-1:0]  oreqinfo = {INFO{1'b0}};
always @ (posedge clk)
    begin
    if (reqread)    
        begin
        case (reqrdcnt)
            2'd0:       oreqinfo <= reqfifo0;
            2'd1:       oreqinfo <= reqfifo1;
            2'd2:       oreqinfo <= reqfifo2;
            default:    oreqinfo <= reqfifo3;
        endcase     
        end
    else                        oreqinfo <= oreqinfo;   
    end

// FIFO len for flow control
reg [2:0]       reqwrlen = 3'd0;
wire            reqwrfull;
assign          reqwrfull = reqwrlen[2];
assign          fiford = notempty & (!reqwrfull);

always @(posedge clk)
    begin
    if (flush2) reqwrlen <= {1'b0,{2{1'b0}}};
    else 
        begin
        case ({reqread,fiford})
            2'b01: reqwrlen <= reqwrlen + 1'b1;
            2'b10: reqwrlen <= reqwrlen - 1'b1;
            default: reqwrlen <= reqwrlen;
        endcase
        end
    end

////////////////////////////////////////////////////////////////////////////////
wire        iget1;
fflopx #(1) ppiget (clk,1'b1,iget,iget1);

reg [ADD:0] ovldlen = {ADD+1{1'b0}};
wire        ovldwr = !ovldlen[ADD] & ivld;
wire        ovldrd = (|ovldlen) & iget1; 
assign      ovldfull = ovldlen[ADD];

always @ (posedge clk)
    begin
    if (flush2) ovldlen <= {ADD+1{1'b0}};
    else
        case ({ovldwr,ovldrd})
            2'b10:      ovldlen <= ovldlen + 1'b1;
            2'b01:      ovldlen <= ovldlen - 1'b1;
            default:    ovldlen <= ovldlen;
        endcase
    end

endmodule 
