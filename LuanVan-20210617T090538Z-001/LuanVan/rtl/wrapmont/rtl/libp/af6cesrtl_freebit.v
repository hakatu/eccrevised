////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af69rtl_freeblk.v
// Description  : .
//
// Author       : nvcuong@HW-NVCUONG
// Created On   : Mon Jun 21 13:48:01 2010
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
//`define RTL_DEBUG
module af6cesrtl_freebit
    (clk,
     rst,

     // free block ready to be get
     wrblkrdy,
     wrblkget,
     wrblkid,
     
     // FREE BLOCK RELEASED 
     rdblkfree,      // read cache free
     rdblkid,
     
     // DEBUG
     blknum,
     
     // Alarms
     blkemp,
     blksame,
     blksameid,
     
     // Active
     active
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   ADDBLK = 11;
parameter   MAXBLK = 2048;

parameter   ADDBIT = 5;
parameter   ADDBAK = 3;
parameter   ADDBUF = 6;
parameter   TYPE = "AUTO";

parameter   NUMBLK = {1'b1,{ADDBLK{1'b0}}};
parameter   NUMBIT = {1'b1,{ADDBIT{1'b0}}};

parameter   ADDRAM = ADDBLK-ADDBIT;
parameter   LENRAM = {1'b1,{ADDRAM{1'b0}}};

parameter   LOSTBLKMON = 15; // number of milisec to declare lost block
parameter   MAXRAM = MAXBLK/NUMBIT - 1;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input                   clk,
                        rst;

// free block ready to be get
input                   wrblkget;
output                  wrblkrdy;
output [ADDBLK-1:0]     wrblkid;

// FREE BLOCK RELEASED 
input                   rdblkfree;
input [ADDBLK-1:0]      rdblkid;

// DEBUG
output [ADDBLK:0]       blknum;

// Alarms
output                  blkemp;
output                  blksame;
output [ADDBLK-1:0]     blksameid;

// Active
input                   active;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire                active1;
fflopx #(1) ppactive (clk,rst,active,active1);

// Initialize Free Block Bit Mask
wire [ADDRAM-1:0]   init_cnt;
wire                init_re,init_re1,init_re2,init_re3,init_re4,init_re5;      // enable write blk into FIFO
wire [ADDRAM-1:0]   init_ra;
wire                init_en;
wire                init_inc = (init_cnt < MAXRAM);
fflopx #(1) init_eni (clk,rst,init_inc,init_en);
 
assign              init_re = active1 & init_en;
assign              init_ra = init_cnt[ADDRAM-1:0];

fflopx #(ADDRAM) iinit_cnt (clk,rst,(!active1 ? {ADDRAM{1'b0}} : init_cnt + init_inc),init_cnt);
fflopx #(5) pp1init_re (clk,rst,{init_re,init_re1,init_re2,init_re3,init_re4},{init_re1,init_re2,init_re3,init_re4,init_re5});

// Return free block access to set bitmask
wire                free_re,free_re1,free_re2,free_re3,free_re4,free_re5;
wire [ADDRAM-1:0]   free_ra;
wire [ADDBIT-1:0]   free_id,free_id1,free_id2,free_id3,free_id4,free_id5;

assign              free_re = rdblkfree & !init_en & active1;
assign              {free_ra[ADDRAM-1:ADDBAK],free_id,free_ra[ADDBAK-1:0]} = rdblkid;
fflopx #(5) pp1free_re (clk,rst,{free_re,free_re1,free_re2,free_re3,free_re4},{free_re1,free_re2,free_re3,free_re4,free_re5});
fflopx #(5*ADDBIT) pp1free_id (clk,rst,{free_id,free_id1,free_id2,free_id3,free_id4},{free_id1,free_id2,free_id3,free_id4,free_id5});

// Regularly scan free block for using
wire                scan_win,scan_re,scan_re1,scan_re2,scan_re3,scan_re4,scan_re5,scan_en;
wire [ADDRAM-1:0]   scan_ra;
assign              scan_win = !rdblkfree & !init_en & active1;
assign              scan_re = scan_win & scan_en;
fflopx #(5) pp1scan_re (clk,rst,{scan_re,scan_re1,scan_re2,scan_re3,scan_re4},{scan_re1,scan_re2,scan_re3,scan_re4,scan_re5});
fflopxe #(ADDRAM) iscan_ra (clk,rst,scan_re,((scan_ra >= MAXRAM) ? {ADDRAM{1'b0}} : scan_ra + 1'b1),scan_ra);
 
// RAM store free block bit mask
wire                bit_re,bit_re1,bit_re2,bit_re3,bit_re4,bit_re5;
wire [ADDRAM-1:0]   bit_ra,bit_ra1,bit_ra2,bit_ra3,bit_ra4,bit_ra5;
assign              bit_re = active1 & (init_en | rdblkfree | scan_en);
assign              bit_ra = init_en ? init_ra : rdblkfree ? free_ra : scan_ra;
fflopx #(5) pp1bit_re (clk,rst,{bit_re,bit_re1,bit_re2,bit_re3,bit_re4},{bit_re1,bit_re2,bit_re3,bit_re4,bit_re5});
fflopx #(5*ADDRAM) pp1bit_ra (clk,rst,{bit_ra,bit_ra1,bit_ra2,bit_ra3,bit_ra4},{bit_ra1,bit_ra2,bit_ra3,bit_ra4,bit_ra5});

wire [NUMBIT-1:0]   obit4,obit5;
reg [NUMBIT-1:0]    ibit5;
fflopx #(NUMBIT) ppobit4 (clk,rst,obit4,obit5);

wire                scan_nemp4,scan_nemp5,scan_vld5;
wire [ADDBIT-1:0]   scan_id4,scan_id5;
fflopx #(1) ppscan_nemp4 (clk,rst,scan_nemp4,scan_nemp5);
fflopx #(ADDBIT) ppscan_id4 (clk,rst,scan_id4,scan_id5);

encodex #(NUMBIT,ADDBIT) srcbank (.in(obit4),.out(scan_id4),.nonz(scan_nemp4));

assign              scan_vld5 = scan_re5 & scan_nemp5;

always @ (*)
    begin
    ibit5 = obit5;
    if (init_re5)       ibit5 = {NUMBIT{1'b1}};
    else if (free_re5)  ibit5[free_id5] = 1'b1;
    else if (scan_vld5) ibit5[scan_id5] = 1'b0;    
    end

// Same block detect
wire                blksame;
fflopx #(1) iblksame (clk,rst,(free_re5 & obit5[free_id5]),blksame);

wire [ADDBLK-1:0]   blksameid;
fflopx #(ADDBLK) iblksameid (clk,rst,{bit_ra5[ADDRAM-1:ADDBAK],free_id5,bit_ra5[ADDBAK-1:0]},blksameid);

// Buffer bitmap
wire                freebit_we;
wire [ADDRAM-1:0]   freebit_wa;
wire [NUMBIT-1:0]   freebit_wrd;
wire                freebit_re;
wire [ADDRAM-1:0]   freebit_ra;
wire [NUMBIT-1:0]   freebit_rdd;

/* -----\/----- EXCLUDED -----\/-----
rtlconflict113x #(ADDRAM,NUMBIT) bitmaskctrl 
    (.clk(clk),
     .rst(rst),

      // Engine Read/rdite interface
     .eng_re(bit_re1),
     .eng_ra(bit_ra1),
     .eng_rdd3(obit4),
     .eng_wrd4(ibit5),
     
     // RAM or Register File Interface
     .memwe(freebit_we),
     .memre(freebit_re),
     .memwa(freebit_wa),
     .memwrd(freebit_wrd),
     .memra(freebit_ra),
     .memrdd(freebit_rdd)
     );
 -----/\----- EXCLUDED -----/\----- */
rtlstappdi113x #(ADDRAM,NUMBIT) status_ctrl 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(bit_re1),
     .eng_ra(bit_ra1),
     .eng_rdd(obit4),
     .eng_we(bit_re5),
     .eng_wa(bit_ra5),
     .eng_wrd(ibit5),
     
     // CPU interface
     .upen(1'b0),     
     .upa({ADDRAM{1'b0}}),
     .upws(1'b0),
     .uprs(1'b0),
     .updi({NUMBIT{1'b0}}),
     .updo(),
     .uprdy(),
     .active(1'b1),

     // RAM or Register File Interface
     .memwe(freebit_we),
     .memre(freebit_re),
     .memwa(freebit_wa),
     .memwrd(freebit_wrd),
     .memra(freebit_ra),
     .memrdd(freebit_rdd)
     );
iarray113x #(ADDRAM,LENRAM,NUMBIT,TYPE,0,"ON")  freebit_buf
    (
     .wrst         (rst       ),
     .wclk          (clk        ),
     .wa            (freebit_wa ),
     .we            (freebit_we ),
     .di            (freebit_wrd),
     .rclk          (clk        ),
     .rrst         (rst       ),
     .ra            (freebit_ra ),
     .re            (freebit_re ),
     .do            (freebit_rdd),
     .mask          (1'b0       ),
     .test          (1'b0       )
     );

////////////////////////////////////////////////////////////////////////////////
// Scan free block and write to a FIFO 
wire                fiford,fiford1,fiford2,notempty,ovldfull;
wire [ADDBUF:0]     fifolen;
fflopx #(2) pp1fiford (clk,rst,{fiford,fiford1},{fiford1,fiford2});
fflopx #(1) iscan_en (clk,rst,(fifolen < ({ADDBUF{1'b1}} - 4'd6)),scan_en);

wire                fifo_we;
wire [ADDBUF-1:0]   fifo_wa;
wire [ADDBLK-1:0]   fifo_wrd = {bit_ra5[ADDRAM-1:ADDBAK],scan_id5,bit_ra5[ADDBAK-1:0]};
wire                fifo_re;
wire [ADDBUF-1:0]   fifo_ra;
wire [ADDBLK-1:0]   fifo_rdd;

iarray112x #(ADDBUF,{1'b1,{ADDBUF{1'b0}}},ADDBLK,"MLAB") memfifo
    (
     .wrst(rst),
     .wclk(clk),
     .wa(fifo_wa),
     .we(fifo_we),
     .di(fifo_wrd),
     .rclk(clk),
     .rrst(rst),
     .ra(fifo_ra),
     .re(fifo_re),
     .do(fifo_rdd),
     .mask(1'b0),
     .test(1'b0)
     );

fifoc_fshx #(ADDBUF,{1'b1,{ADDBUF{1'b0}}}) fifobuf
    (
     .clk(clk),
     .rst(rst),
     
     .fiford(fiford),    // FIFO control
     .fifowr(scan_vld5),
     .fifofsh(!active1),   // FIFO flush

     .fifofull(ovldfull),  // high when fifo full
     .notempty(notempty),  // high when fifo not empty
     .fifolen(fifolen),   

                // Connect to memories
     .write(fifo_we),     // enable to write memories
     .wraddr(fifo_wa),    // write address of memories
     .read(fifo_re),      // enable to read memories
     .rdaddr(fifo_ra)     // read address of memories
     );

////////////////////////////////////////////////////////////////////////////////
// Request
wire        reqrd,reqnemp,reqfull;
reg [2:0]   reqlen =  3'd0;
assign      reqfull = reqlen[2];

reg         wrblkrdy = {1{1'b0}};
assign      reqrd = reqnemp & (!wrblkrdy | wrblkget);
assign      fiford = notempty & (!reqfull);

always @ (posedge clk)
    begin
    if (rst)    wrblkrdy <= 1'd0;
    else        wrblkrdy <= (!wrblkget & wrblkrdy) | reqnemp;
    end
always @ (posedge clk)
    begin
    if (rst)    reqlen <= 3'd0;
    else
        case ({reqrd,fiford})
            2'b01:      reqlen <= reqlen + 1'b1;
            2'b10:      reqlen <= reqlen - 1'b1;
            default:    reqlen <= reqlen;
        endcase
    end

fifox #(2,4,ADDBLK,1'b0) fiforeq
    (
     .clk(clk),
     .rst(rst),
     .fiford(reqrd),        // fifo read signal
     .fifowr(fiford2),        // fifo write signal
     .fifodin(fifo_rdd),       // fifo data in
     .fifofull(),      // fifo full signal(), high when fifo is full
     .fifolen(),       // fifo len
     .notempty(reqnemp),      // fifo not empty signal(), high when fifo is not empty
     .fifodout(wrblkid)       // fifo data out
     );

// MOnitor number of free block
wire                wrblkget1;
fflopx #(1) ppwrblkget (clk,rst,wrblkget,wrblkget1);

reg [ADDBLK:0]      blknum;
always @ (posedge clk)
    begin
    if (rst)  blknum <= {(ADDBLK+1){1'b0}};
    else if (!active1)  blknum <= {(ADDBLK+1){1'b0}};
    else if (init_re)  blknum <= blknum + NUMBIT;
    else
        case ({wrblkget1,free_re1})
            2'b01:  blknum <= blknum + 1'b1;
            2'b10:  blknum <= blknum - 1'b1;
            default:    blknum <= blknum;
        endcase
    end

// Free block empty
wire        blkemp;
fflopx #(1) iblkemp (clk,rst,(wrblkget1 & (blknum == 1'b1)),blkemp);

////////////////////////////////////////////////////////////////////////////////
// DEBUG, auto removed when synthesize

`ifdef RTL_DEBUG
always @ (posedge clk)
    begin
    if (blksame)    $fdisplay(testtop.rtlerror,"%m same blk%h @time%t  ",blksameid,$time);
    if (blkemp)   $fdisplay(testtop.rtlerror,"%m blkemp @time %t  %m",$time);
    if (!wrblkrdy & wrblkget)   $fdisplay(testtop.rtlerror,"%m blkgap @time %t  %m",$time);
    end

// Monitor lost block (apply for maxblk 16000)
wire [16:0] clkcnt;
wire        msvld = (clkcnt >= 17'd77759);

fflopx #(17) iclkcnt (clk,rst,msvld ? 17'd0 : clkcnt + 1'b1,clkcnt);
 
reg [4:0]   blkmon [NUMBLK-1:0];
integer     j;

always @ (posedge clk)
    begin
    if (rst)  
        begin
        for (j=0;j<NUMBLK;j=j+1)      blkmon[j] <= 3'd0;
        end
    else if (wrblkget & !rdblkfree)   blkmon[wrblkid] <= 3'd1;
    else if (!wrblkget & rdblkfree)   blkmon[rdblkid] <= 3'd0;
    else if (wrblkget & rdblkfree)
        begin
        if (wrblkid == rdblkid) $fdisplay(testtop.rtlerror,"af6cesrtl_freebit: wrblkid == freeblk @time %t %m",$time);
        else
            begin
            blkmon[wrblkid] <= 3'd1;
            blkmon[rdblkid] <= 3'd0;
            end
        end
    else if (msvld)
        begin
        for (j=0;j<NUMBLK;j=j+1)
            begin
            if (blkmon[j] == LOSTBLKMON)   $fdisplay(testtop.rtlerror,"af6cesrtl_freebit: lost blk%h @time %t %m",j,$time);
            if (|blkmon[j])   blkmon[j] <= (blkmon[j] == LOSTBLKMON) ? 3'd0 : blkmon[j] + 1'b1;
            end
        end
    end

`endif



endmodule 
