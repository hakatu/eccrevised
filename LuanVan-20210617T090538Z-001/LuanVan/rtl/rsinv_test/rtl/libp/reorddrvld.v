////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtl_reorvld.v
// Description  : .
//
// Author       : nvcuong@HW-NVCUONG
// Created On   : Sat Sep 06 10:03:24 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module reorddrvld
    (clk,
     rst,

     // ACK and valid from link list
     iack,    
     iackseqid,    // segment sequence id
     iackinfo,     // segment info, valid by illack
     ivld,
     ivldseqid,  // sequence id from link list, valid by illvld
     ivld1,
     ivldseqid1,  // sequence id from link list, valid by illvld
     onumreq,
     
     // Segment info to tx header processor
     ovld,
     ovldinfo,
     ovldseq,
     
     // Flush engine
     iflush,

     // Sticky report
     oerror
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   ADDSEQ = 4;
parameter   NUMSEQ = 16;

parameter   ADDINFO = 40;
parameter   TYPE = "MLAB";
parameter   GAPMOD = 1'b1;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   clk,
        rst;

input [ADDSEQ-1:0]          iackseqid;
input [ADDINFO-1:0]         iackinfo;
input                       iack;
input                       ivld,
                            ivld1;
input [ADDSEQ-1:0]          ivldseqid,
                            ivldseqid1;

output                      ovld;
output [ADDINFO-1:0]        ovldinfo;
output [ADDSEQ-1:0]         ovldseq;
output [ADDSEQ:0]           onumreq;

input                       iflush;
output                      oerror;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg                         flush = 1'b1;
always @ (posedge clk)
    begin
    if (rst)    flush <= 1'b1;
    else        flush <= iflush;
    end

wire                        ivldp,
                            ivld1p;
wire  [ADDSEQ-1:0]          ivldseqidp,
                            ivldseqid1p;
fflopx #(1) ppivld (clk,rst,ivld,ivldp);
fflopx #(1) ppivld1 (clk,rst,ivld1,ivld1p);
fflopx #(ADDSEQ) ppivldseqid (clk,rst,ivldseqid,ivldseqidp);
fflopx #(ADDSEQ) ppivldseqid1 (clk,rst,ivldseqid1,ivldseqid1p);

// Write ACK segment to a FIFO for correct sequence control
wire [ADDSEQ-1:0]   vldseq,vldseq1;
wire [ADDINFO-1:0]  vldinfo;
wire                fifofull,vldget,vldget1,vldreq;
fflopx #(ADDSEQ) ppvldseq (clk,rst,vldseq,vldseq1);
fflopx #(1) ppvldget (clk,rst,vldget,vldget1);

generate
    begin
    if (GAPMOD == 1'b1)
        begin
af6cesrtl_gapbuf #(ADDSEQ,ADDINFO+ADDSEQ,TYPE) fiforeq
    (.clk(clk),
     .rst(rst),

     // Write valid info to buffer
     .ivld(iack),
     .ivldinfo({iackinfo,iackseqid}),
     .ovldfull(fifofull),
     .ovldlen(onumreq),
     
     // Flush
     .flush(flush),
     
     // Request info
     .oreq(vldreq),
     .oreqinfo({vldinfo,vldseq}),
     .iget(vldget)   
     );
        end
    else
        begin
af6cesrtl_reqbuf #(ADDSEQ,ADDINFO+ADDSEQ,TYPE) fiforeq
    (.clk(clk),
     .rst(rst),

     // Write valid info to buffer
     .ivld(iack),
     .ivldinfo({iackinfo,iackseqid}),
     .ovldfull(fifofull),
     .ovldlen(onumreq),
     
     // Flush
     .flush(flush),
     
     // Request info
     .oreq(vldreq),
     .oreqinfo({vldinfo,vldseq}),
     .iget(vldget)   
     );
        end 
    end
endgenerate
////////////////////////////////////////////////////////////////////////////////
// Re arrange the sequence of illvld segment follow the illack

// Latch valid sequence
reg [NUMSEQ-1:0]    ivldlat = {NUMSEQ{1'b0}};    // latch ivld
wire                ivld1same;
assign              ivld1same = ivldp & (ivldseqidp == ivldseqid1p);

wire                ivld1ok;
assign              ivld1ok = ivld1p & (!ivld1same);

always @ (posedge clk)
    begin
    if (flush)    ivldlat <= {NUMSEQ{1'b0}};    
    else
        begin
        if (ivldp)              ivldlat[ivldseqidp] <= 1'b1;
        if (ivld1ok)            ivldlat[ivldseqid1p] <= 1'b1;
        if (vldget1)            ivldlat[vldseq1] <= 1'b0;
        end
    end

// segment valid
assign          vldget = vldreq & ivldlat[vldseq];
assign          ovld = vldget1;
fflopx #(ADDSEQ+ADDINFO) ppovldinfo (clk,rst,{vldinfo,vldseq},{ovldinfo,ovldseq});

// Error: fifo full error or sequence error
wire        iackerr,ivld1err,ivld1errsame,ivlderrsame;
assign      iackerr = fifofull & iack;
assign      ivld1err = ivld1p & ivld1same;
assign      ivlderrsame = ivldp & ivldlat[ivldseqidp];
assign      ivld1errsame = ivld1p & ivldlat[ivldseqid1p];

wire        oerror,error;
assign      error = iackerr | ivld1err | ivld1errsame | ivlderrsame;
fflopx #(1) pp1error (clk,rst,error,oerror);
    
endmodule 
