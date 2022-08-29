////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlddr3sim.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Thu May 14 14:04:22 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlddr3sim
    (clk,
     rst,
     req,
     reqrnw,
     reqwrd,
     reqrow,
     reqbak,
     reqcol,
     ack,
     rvl,
     rdd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter               WID = 512;
parameter               ROW = 14;
parameter               BAK = 3;
parameter               COL = 8;
parameter               LATENCY = 30;

parameter               SAMEBANK = 6'd21;  // 65ns ~ 40 cycle 311M

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               req,
                    reqrnw;
input [WID-1:0]     reqwrd;
input [ROW-1:0]     reqrow;
input [BAK-1:0]     reqbak;
input [COL-1:0]     reqcol;

output              ack,
                    rvl;
output [WID-1:0]    rdd;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg [11:0]          precharge_cnt;
wire                precharge_en,precharge_win;
//assign              precharge_en = (precharge_cnt == 12'd2488); // 8us of clk311
assign              precharge_en = (precharge_cnt == 12'd1253); // 4us of clk311
assign              precharge_win = precharge_cnt < 12'd93;  // 300ns

always @ (posedge clk)
    begin
    if (rst)  precharge_cnt <= 12'd0;
    else if (precharge_en)  precharge_cnt <= 12'd0;
    else    precharge_cnt <= precharge_cnt + 1'b1;
    end

// ACK depend on BW and same bank
wire [7:0]          baksame,rowbaksame;
wire                ack,fifofull,groupdis;
assign              ack = req & (!baksame[reqbak] | rowbaksame[reqbak]) & !fifofull & !precharge_win & !groupdis;

// Time to open command
wire [2:0]          prebak;
wire                prernw;
fflopxe #(4) iprebakrnw (clk,rst,ack,{reqrnw,reqbak},{prernw,prebak});

reg [3:0]           cmdcnt;
wire                cmdmask = |cmdcnt;

always @ (posedge clk)
    begin
    if (rst)  cmdcnt <= 4'd0;
    else if (ack & (reqbak != prebak)) cmdcnt <= /*reqrnw^prernw ? cmdcnt + 2'd2 : */cmdcnt + 2'd1;
    else if (cmdmask)   cmdcnt <= cmdcnt - 1'b1;
    end

// Bank group constraint
wire            reqgroup = reqbak[0];
wire            pregroup = prebak[0];

wire [1:0]      groupcnt;
fflopx #(2) iack1 (clk,rst,ack ? 2'd2 : groupcnt - (|groupcnt),groupcnt);
assign          groupdis = req & (groupcnt != 2'd0) & (pregroup == reqgroup);

// Mask same bank
reg [ROW-1:0]   bakrow0;
reg [ROW-1:0]   bakrow1;
reg [ROW-1:0]   bakrow2;
reg [ROW-1:0]   bakrow3;
reg [ROW-1:0]   bakrow4;
reg [ROW-1:0]   bakrow5;
reg [ROW-1:0]   bakrow6;
reg [ROW-1:0]   bakrow7;
reg [5:0]   bakcnt0;
reg [5:0]   bakcnt1;
reg [5:0]   bakcnt2;
reg [5:0]   bakcnt3;
reg [5:0]   bakcnt4;
reg [5:0]   bakcnt5;
reg [5:0]   bakcnt6;
reg [5:0]   bakcnt7;

wire        bakdis;
assign      bakdis = cmdmask | precharge_win;

assign      baksame[0] = (bakcnt0 != 6'd0) & !bakdis;
assign      baksame[1] = (bakcnt1 != 6'd0) & !bakdis;
assign      baksame[2] = (bakcnt2 != 6'd0) & !bakdis;
assign      baksame[3] = (bakcnt3 != 6'd0) & !bakdis;
assign      baksame[4] = (bakcnt4 != 6'd0) & !bakdis;
assign      baksame[5] = (bakcnt5 != 6'd0) & !bakdis;
assign      baksame[6] = (bakcnt6 != 6'd0) & !bakdis;
assign      baksame[7] = (bakcnt7 != 6'd0) & !bakdis;

assign      rowbaksame[0] = (reqbak == 3'd0) & (reqrow == bakrow0);
assign      rowbaksame[1] = (reqbak == 3'd1) & (reqrow == bakrow1);
assign      rowbaksame[2] = (reqbak == 3'd2) & (reqrow == bakrow2);
assign      rowbaksame[3] = (reqbak == 3'd3) & (reqrow == bakrow3);
assign      rowbaksame[4] = (reqbak == 3'd4) & (reqrow == bakrow4);
assign      rowbaksame[5] = (reqbak == 3'd5) & (reqrow == bakrow5);
assign      rowbaksame[6] = (reqbak == 3'd6) & (reqrow == bakrow6);
assign      rowbaksame[7] = (reqbak == 3'd7) & (reqrow == bakrow7);

always @ (posedge clk)
    begin
    if (rst)  
        begin
        bakrow0 <= {ROW{1'b0}};
        bakrow1 <= {ROW{1'b0}};
        bakrow2 <= {ROW{1'b0}};
        bakrow3 <= {ROW{1'b0}};
        bakrow4 <= {ROW{1'b0}};
        bakrow5 <= {ROW{1'b0}};
        bakrow6 <= {ROW{1'b0}};
        bakrow7 <= {ROW{1'b0}};
        bakcnt0 <= 6'd0;        
        bakcnt1 <= 6'd0;
        bakcnt2 <= 6'd0;
        bakcnt3 <= 6'd0;
        bakcnt4 <= 6'd0;
        bakcnt5 <= 6'd0;
        bakcnt6 <= 6'd0;
        bakcnt7 <= 6'd0;
        end
    else
        begin
        bakcnt0 <= ack & (reqbak == 3'd0) ? SAMEBANK : bakcnt0 - baksame[0];
        bakcnt1 <= ack & (reqbak == 3'd1) ? SAMEBANK : bakcnt1 - baksame[1];
        bakcnt2 <= ack & (reqbak == 3'd2) ? SAMEBANK : bakcnt2 - baksame[2];
        bakcnt3 <= ack & (reqbak == 3'd3) ? SAMEBANK : bakcnt3 - baksame[3];
        bakcnt4 <= ack & (reqbak == 3'd4) ? SAMEBANK : bakcnt4 - baksame[4];
        bakcnt5 <= ack & (reqbak == 3'd5) ? SAMEBANK : bakcnt5 - baksame[5];
        bakcnt6 <= ack & (reqbak == 3'd6) ? SAMEBANK : bakcnt6 - baksame[6];
        bakcnt7 <= ack & (reqbak == 3'd7) ? SAMEBANK : bakcnt7 - baksame[7];
        
        bakrow0 <= ack & (reqbak == 3'd0) ? reqrow : bakrow0;
        bakrow1 <= ack & (reqbak == 3'd1) ? reqrow : bakrow1;
        bakrow2 <= ack & (reqbak == 3'd2) ? reqrow : bakrow2;
        bakrow3 <= ack & (reqbak == 3'd3) ? reqrow : bakrow3;
        bakrow4 <= ack & (reqbak == 3'd4) ? reqrow : bakrow4;
        bakrow5 <= ack & (reqbak == 3'd5) ? reqrow : bakrow5;
        bakrow6 <= ack & (reqbak == 3'd6) ? reqrow : bakrow6;
        bakrow7 <= ack & (reqbak == 3'd7) ? reqrow : bakrow7;
        end
    end


// Write to a FIFO command
parameter           INFO = WID+ROW+BAK+COL+1;

wire [INFO-1:0]     oreqinfo;
wire                oreq,
                    oreqrnw;
wire  [WID-1:0]     oreqwrd;
wire  [ROW-1:0]     oreqrow;
wire  [BAK-1:0]     oreqbak;
wire [COL-1:0]      oreqcol;
wire                fiford,notempty;

fflopx #(1) ppfiford (clk,rst,fiford,oreq);


fifox #(2,4,INFO) fiforeq 
    (.clk(clk),
     .rst(rst),
     .fiford(fiford),    
     .fifowr(ack),
     .fifodin({reqwrd,reqrow,reqbak,reqcol,reqrnw}),
     .fifofull(fifofull),
     .fifolen(),
     .notempty(notempty),
     .fifodout(oreqinfo)
     );

// Read FIFO
wire [3:0]  cnt;    
fflopx #(4) icnt (clk,rst,(cnt + 1'b1),cnt);
//assign              fiford = notempty & (|cnt);   // 311*512*(15/16) = 149G
assign              fiford = notempty & (cnt < 4'd12);   // 311*512*(12/16) = 119G

wire [LATENCY-1:0]  oreqshift;
fflopx #(LATENCY) pporeq (clk,rst,{oreqshift[LATENCY-2:0],oreq},oreqshift);

wire [LATENCY*INFO-1:0] oreqinfoshift;
fflopx #(LATENCY*INFO) pporeqinfo (clk,rst,{oreqinfoshift[(LATENCY-1)*INFO-1:0],oreqinfo},oreqinfoshift);

wire                    oreqddr = oreqshift[LATENCY-1];
assign                  {oreqwrd,oreqrow,oreqbak,oreqcol,oreqrnw} = oreqinfoshift[LATENCY*INFO-1:(LATENCY-1)*INFO];

// Memory DDR
parameter               DDRADD = ROW+BAK+COL;
parameter               DDRLEN = {1'b1,{DDRADD{1'b0}}};
fflopx #(1) irvl (clk,rst,(oreqddr & oreqrnw),rvl);

iarray111x #(DDRADD,DDRLEN,WID) memddr
    (
     .wrst(rst),
     .wclk(clk),
     .wa({oreqrow,oreqbak,oreqcol}),
     .we(oreqddr & !oreqrnw),
     .di(oreqwrd),
     .rclk(clk),
     .rrst(rst),
     .ra({oreqrow,oreqbak,oreqcol}),
     .re(oreqddr & oreqrnw),
     .do(rdd),
     .mask(1'b0),
     .test(1'b0)
     );

endmodule 
