////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlrd2clrcntram.v
// Description  : .
//    + upa[CNTSIZE+1]
//          + 0: counter
//          + 1: sticky for per channel
//    + upa[CNTSIZE]
//          + 0: read 2 clear
//          + 1: read only
//    + CPU can write 0 to clear
//    + mode
//          + 0: rollover
//          + 1: saturation
//    + interface iarray111x
// Author       : ndthanh@HW-NDTHANH
// Created On   : Wed May 07 14:54:20 2008
// History (Date, Changed By)
//  + Fri Jun 26 10:12:35 2009, ndtu@HW-NDTU, Added icnum (num of valid need counted)
//  + Wed Nov 02 10:46:11 2011, thanhnd@HW-NDTHANH, Optimite timing 155Mhz,
//    Interface requirement: user ID interleave least 4clk
//    CPU can't write when active = 1
////////////////////////////////////////////////////////////////////////////////
module af6cesrtl_cntid113_2page
    (
     clk,
     rst,
     mode, //1:saturation; 0:rollover
     pulse,
     
     icnum,
     alarm,
     id,
     
     oint,
     
     // ram output
     owa,        // write address, output
     owe,        // write enable, output
     odi,        // write data, output
     ore,        // read enable, output
     ora,        // read address, output
     ido,        // ram data out, input      
     
     pact,
     upen,
     upwr,
     uprd,
     upa,
     updi,
     uprdy,
     updo
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter CNTID    = 8;
parameter CNTWID   = 32;
parameter CNTBIT    = 9;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input                   clk,
                        rst;
input                   mode;
input                   pulse;

input [CNTBIT-1:0]      icnum;
input                   alarm;
input [CNTID-1:0]       id;
output                  oint;


output [CNTID:0]        owa,
                        ora;
output                  owe;
output                  ore;
output [CNTWID-1:0]     odi;
input [CNTWID-1:0]      ido;

input                   pact;
input                   upen;
input                   upwr;
input                   uprd;
input [CNTID:0]         upa;
input [CNTWID-1:0]      updi;
output [CNTWID-1:0]     updo;
output                  uprdy;
 
////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                    pulse1,pulse2; //1: page act 0: page stb
fflopx #(1) ipulse1 (clk,rst, pulse,pulse1);
fflopx #(1) ipulse2 (clk,rst, pulse1,pulse2);
wire                    pg_act = pulse1;
wire                    pg_stb = ~pulse1;

// Pipeline input
wire [CNTBIT-1:0]     cnum,cnum1,cnum2,cnum3,cnum4,cnum5,cnum6,cnum7,cnum8;
fflopx #(CNTBIT) ppicnum (clk,rst,icnum,cnum);
fflopx #(CNTBIT) icnum1 (clk,rst,cnum,cnum1);
fflopx #(CNTBIT) icnum2 (clk,rst,cnum1,cnum2);
fflopx #(CNTBIT) icnum3 (clk,rst,(cnum2+1'b1),cnum3);
fflopx #(CNTBIT) icnum4 (clk,rst,cnum3,cnum4);
fflopx #(CNTBIT) icnum5 (clk,rst,cnum4,cnum5);
fflopx #(CNTBIT) icnum6 (clk,rst,cnum5,cnum6);
fflopx #(CNTBIT) icnum7 (clk,rst,cnum6,cnum7);
fflopx #(CNTBIT) icnum8 (clk,rst,cnum7,cnum8);
wire                    cvld,cvld1,cvld2,cvld3,cvld4,cvld5,cvld6,cvld7,cvld8,cvld9;
fflopx #(1)  icvld (clk,rst,alarm,cvld);
fflopx #(1)  icvld1 (clk,rst,cvld,cvld1);
fflopx #(1)  icvld2 (clk,rst,cvld1,cvld2);
fflopx #(1)  icvld3 (clk,rst,cvld2,cvld3);
fflopx #(1)  icvld4 (clk,rst,cvld3,cvld4);
fflopx #(1)  icvld5 (clk,rst,cvld4,cvld5);
fflopx #(1)  icvld6 (clk,rst,cvld5,cvld6);
fflopx #(1)  icvld7 (clk,rst,cvld6,cvld7);
fflopx #(1)  icvld8 (clk,rst,cvld7,cvld8);
fflopx #(1)  icvld9 (clk,rst,cvld8,cvld9);

// CPU access
reg                     cpu_re=1'b0;
reg                     cpu_we=1'b0;

wire                    cpu_win,cpu_vld,cpu_vld1,cpu_vld2,cpu_vld3,cpu_vld4,cpu_vld5;
wire                    cpu_vld9;

wire                    cpu_wr2clr_win,cpu_rd2clr_win;
//assign                  cpu_rd2clr_win = (!alarm | (upa[CNTID-1:0] == id)) & cpu_re;
//assign                  cpu_wr2clr_win = (!alarm | (upa[CNTID-1:0] == id)) & cpu_we;
wire [CNTBIT-1:0]       rm_cnum;    //previous clr, so wait next cycle to update
wire [CNTBIT-1:0]       rm_cnum_pp;
wire                    rm_cnum_vld;
wire                    alarm4,alarm8;

wire                    engwin = alarm /*| rm_cnum_vld*/;
assign                  cpu_rd2clr_win = (!engwin /*| (upa[CNTID-1:0] == id)*/) & cpu_re;
assign                  cpu_wr2clr_win = (!engwin /*| (upa[CNTID-1:0] == id)*/) & cpu_we;

assign                  cpu_win = cpu_rd2clr_win | cpu_wr2clr_win;

fflopx #(1)  icpu_vld (clk,rst,cpu_win,cpu_vld);
fflopx #(1)  icpu_vld1 (clk,rst,cpu_vld,cpu_vld1);
fflopx #(1)  icpu_vld2 (clk,rst,cpu_vld1,cpu_vld2);
fflopx #(1)  icpu_vld3 (clk,rst,cpu_vld2,cpu_vld3);
fflopx #(1)  icpu_vld4 (clk,rst,cpu_vld3,cpu_vld4);
fflopx #(1)  icpu_vld5 (clk,rst,cpu_vld4,cpu_vld5);
ffxkclkx #(5,1) icpu_vld9 (clk,rst,cpu_vld4,cpu_vld9);
always @ (posedge clk)
    begin
    if (rst)      cpu_re <= 1'b0;
    else if (upen & uprd)   cpu_re <= 1'b1;
    else if (cpu_rd2clr_win)   cpu_re <= 1'b0;
    end

// CPU wr2clr
//assign                  cpu_wr2clr_win = (!alarm | (upa[CNTID-1:0] == id)) & cpu_we;
always @ (posedge clk)
    begin
    if (rst)      cpu_we <= 1'b0;
    else if (upen & upwr)   cpu_we <= 1'b1;
    else if (cpu_wr2clr_win)   cpu_we <= 1'b0;
    end

wire cpu_we0,cpu_we1,cpu_we2,cpu_we3,cpu_we4;
fflopx #(1) icpu_we0 (clk,rst,cpu_we,cpu_we0);
fflopx #(1) icpu_we1 (clk,rst,cpu_we0,cpu_we1);
fflopx #(1) icpu_we2 (clk,rst,cpu_we1,cpu_we2);
fflopx #(1) icpu_we3 (clk,rst,cpu_we2,cpu_we3);
fflopx #(1) icpu_we4 (clk,rst,cpu_we3,cpu_we4);

wire [CNTID-1:0] id4;
ffxkclkx #(4,CNTID) ippid4 (clk,rst,id,id4);

// RAM arbitration
wire                    ram_vld,ram_re,ram_re1,ram_re2,ram_re3,ram_re4;
wire [CNTID:0]          ram_add,ram_ra,ram_ra1,ram_ra2,ram_ra3,ram_ra4;
wire                    upr2c,cpu_r2c,cpu_r2c1,cpu_r2c2,cpu_r2c3,cpu_r2c4,cpu_r2c9;
wire [CNTID-1:0]        scanid4;
wire                    ram_vld4;
wire [CNTID:0]          ram_add4;
wire [CNTID:0]          eng_add_up;
wire                    sta1s_chg4;      //change evrery 1s
wire                    sta1s_rs;
wire                    sta1s_fl;
wire [CNTID-1:0]        ram_ra4_1s;
wire                    clr_upd_same4; //auto clr conflict alarm set
wire                    clr_upd_same8; //auto clr conflict alarm set
wire                    sta1s_chg4_win;

wire                    cur_1s;
assign                  alarm4 = cvld3;
//ffxkclkx #(4,1) ipp_larm8 (clk,rst,alarm4,alarm8);
ffxkclkx #(5,1) ipp_larm8 (clk,rst,alarm4,alarm8);

//assign                  ram_vld = alarm | cpu_re | cpu_we ;
//assign                  ram_add = alarm ? {pg_act,id} : {pg_stb,upa[CNTID-1:0]};   //cpu only acssess stb

//assign                  eng_add_up = sta1s_chg4 ? {!cur_1s,id4} :  {cur_1s,id4};
assign                  clr_upd_same4 = sta1s_chg4 & alarm4 & (id4==scanid4);
ffxkclkx #(4,1) ipp_clrupd_same8    (clk,rst,clr_upd_same4,clr_upd_same8);
assign sta1s_chg4_win = (sta1s_chg4 & (!cpu_vld3));

assign                  eng_add_up = alarm4 ? {cur_1s,id4} : /*sta1s_rs ? {1'b1,ram_ra4_1s} : {1'b0,ram_ra4_1s}*/ {cur_1s,ram_ra4_1s};
assign                  ram_vld4 = alarm4 | cpu_vld3 | sta1s_chg4 /*| (|rm_cnum)*/;
assign                  ram_add4 = (alarm4| sta1s_chg4_win) ? eng_add_up : cpu_vld3 ? {!cur_1s,upa[CNTID-1:0]} : {cur_1s,ram_ra4_1s};

assign                  upr2c   = !upa[CNTID];

//fflopx #(1)  iram_re (clk,rst,ram_vld,ram_re);
ffxkclkx #(2,1)  iram_re (clk,rst,ram_vld4,ram_re);
fflopx #(1)  iram_re1 (clk,rst,ram_re,ram_re1);
fflopx #(1)  iram_re2 (clk,rst,ram_re1,ram_re2);
fflopx #(1)  iram_re3 (clk,rst,ram_re2,ram_re3);
fflopx #(1)  iram_re4 (clk,rst,ram_re3,ram_re4);

//fflopx #(CNTID+1)  iram_ra  (clk,rst,ram_add,ram_ra);
ffxkclkx #(2,CNTID+1)  iram_ra  (clk,rst,ram_add4,ram_ra);

fflopx #(CNTID+1)  iram_ra1 (clk,rst,ram_ra, ram_ra1);
fflopx #(CNTID+1)  iram_ra2 (clk,rst,ram_ra1,ram_ra2);
fflopx #(CNTID+1)  iram_ra3 (clk,rst,ram_ra2,ram_ra3);
fflopx #(CNTID+1)  iram_ra4 (clk,rst,ram_ra3,ram_ra4);

fflopx #(1)  icpu_r2c (clk,rst,upr2c,cpu_r2c);
fflopx #(1)  icpu_r2c1 (clk,rst,cpu_r2c,cpu_r2c1);
fflopx #(1)  icpu_r2c2 (clk,rst,cpu_r2c1,cpu_r2c2);
fflopx #(1)  icpu_r2c3 (clk,rst,cpu_r2c2,cpu_r2c3);
fflopx #(1)  icpu_r2c4 (clk,rst,cpu_r2c3,cpu_r2c4);
ffxkclkx #(5,1) icpu_r2c9 (clk,rst,cpu_r2c4,cpu_r2c9);

wire                    cpu_we9;
ffxkclkx #(5,1) ipp_cpuwe   (clk,rst,cpu_we4,cpu_we9);

wire [CNTWID-1:0]       ocount3,ocount4,icount4;
wire [CNTWID:0]         cntinc3,cntinc4;
wire [CNTWID-1:0]       ocount8,ocount9,icount9;
wire [CNTWID:0]         cntinc8,cntinc9;
wire                    sta1s_chg8,sta1s_chg9;
wire [CNTBIT-1:0]       rm_cnum8;

//ffxkclkx #(4,1) ipp_stachg8 (clk,rst,sta1s_chg4,sta1s_chg8);
ffxkclkx #(5,1) ipp_stachg8 (clk,rst,sta1s_chg4_win,sta1s_chg8);
fflopx #(1)     ipp_stachg9 (clk,rst,sta1s_chg8,sta1s_chg9);

//assign                  cntinc3 = {1'b0,ocount3} + {1'b0,cnum3};
//fflopx #(CNTWID+1) icntinc4 (clk,rst,cntinc3,cntinc4);
//fflopx #(CNTWID) iocount4 (clk,rst,ocount3,ocount4);

assign                  cntinc8 = sta1s_chg8 ?(alarm8 ? cnum8 : {CNTWID{1'b0}}) : {1'b0,ocount8} + {1'b0,cnum8} /*+ rm_cnum8*/;
fflopx #(CNTWID+1) icntinc4 (clk,rst,cntinc8,cntinc9);
fflopx #(CNTWID) iocount4 (clk,rst,ocount8,ocount9);

wire [CNTWID-1:0]       cntalm4;
wire [CNTWID-1:0]       cntalm9;

//assign                  cntalm4 = cvld4 ? (cntinc4[CNTWID] & mode ? {CNTWID{1'b1}} : cntinc4[CNTWID-1:0]) : ocount4;
assign                  cntalm9 = (cvld9|sta1s_chg9) ? cntinc9[CNTWID-1:0] : ocount9;

//assign                  icount4 = (cpu_vld4 & cpu_r2c4) ? {CNTWID{1'b0}} : ( cpu_vld4 & cpu_we4) ? updi[CNTWID-1:0] : cntalm4;
assign icount9 = (cpu_vld9 & cpu_r2c9) ? {CNTWID{1'b0}} : ( cpu_vld9 & cpu_we9) ? updi[CNTWID-1:0] : cntalm9;
// Counter value to CPU
wire [CNTWID-1:0]       updo;
//fflopx #(CNTWID) iupdo (clk,rst,(cpu_vld4 ? cntalm4 : upen ? updo : {CNTWID{1'b0}}),updo);
fflopx #(CNTWID) iupdo (clk,rst,(cpu_vld9 ? cntalm9 : upen ? updo : {CNTWID{1'b0}}),updo);

wire                    uprdy0,uprdy;
fflopx #(1) iuprdy0 (clk,rst,(upen & (upwr | cpu_vld9)),uprdy0);
fflopx #(1) iuprdy (clk,rst,uprdy0,uprdy);

wire                    oint = 1'b0;

// Buffer control
rtlramstappdi113x #(CNTID+1,CNTWID) cntsta 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(ram_re),       //cvld5
     .eng_ra(ram_ra),
     .eng_rdd(ocount8),
     .eng_we(ram_re4),
     .eng_wa(ram_ra4),
     .eng_wrd(icount9),
     
     // CPU interface
     .upen(1'b0),     
     .upa({CNTID+1{1'b0}}),
     .upws(1'b0),
     .uprs(1'b0),
     .updi({CNTWID{1'b0}}),
     .updo(),
     .uprdy(),
     .active(1'b1),

     // RAM or Register File Interface
     .memwe(owe),
     .memre(ore),
     .memwa(owa),
     .memwrd(odi),
     .memra(ora),
     .memrdd(ido)
     );
//------------------------------------------------------------------------------
//add status 1s change per id for auto clr
wire                    ram_re_1s; //~ram_re
reg [CNTID-1:0]         scanid = {CNTID{1'b0}};
wire                    sta_cfl4;
wire [CNTID-1:0]        ram_ra5_1s;
wire                    pend_scan = alarm | cpu_re | cpu_we;

always @(posedge clk)
    begin
    scanid <= pend_scan ? scanid : scanid + 1;
    end
reg [CNTID-1:0]         ram_ra_1s;
//wire                  ext_win = alarm | cpu_re | cpu_we ;

always @(posedge clk)
    begin
    if(alarm) ram_ra_1s <= id;
    else if (cpu_win) ram_ra_1s <= upa[CNTID-1:0];
    else ram_ra_1s <= scanid;
    end
ffxkclkx #(4,CNTID) ippscanid4  (clk,rst,scanid,scanid4);
ffxkclkx #(3,CNTID) ippramra4   (clk,rst,ram_ra_1s,ram_ra4_1s);
ffxkclkx #(1,CNTID) ippramra5   (clk,rst,ram_ra4_1s,ram_ra5_1s);
wire [CNTID-1:0]        owa_1s,
                        ora_1s;
wire                    owe_1s;
wire                    ore_1s;
wire [1:0]         odi_1s;
wire [1:0]         ido_1s;
wire                    alarm_cfl = cvld3 & sta1s_chg4;
wire [CNTBIT-1:0]       rm_cnum_update = alarm_cfl ? cnum4 : |rm_cnum ? 'd0 : rm_cnum;
ffxkclkx #(4,CNTBIT) ipp_rmcnum8 (clk,rst,rm_cnum                  ,rm_cnum8);
ffxkclkx #(1,CNTBIT) ipp_rmcnum5 (clk,rst,rm_cnum_update           ,rm_cnum_pp);
assign rm_cnum_vld = (|rm_cnum);


//assign sta_cfl4      = sta1s_chg4 & alarm4;
assign nxt_1s       = pulse2;
assign sta1s_rs     = (!cur_1s) &  pulse1;
assign sta1s_fl     = cur_1s    & (!pulse1);
//assign sta1s_chg4   = sta1s_rs  |  sta1s_fl;
wire                    nxt_sta_chg4;
assign nxt_sta_chg4 = sta1s_rs  |  sta1s_fl;

wire                    sta_we4 = pact & (/*!alarm_cfl*/!(cvld3|cpu_vld3));
wire                    sta_we5;
wire                    sta1s_chg5;

ffxkclkx #(1)   ippsta_we5  (clk,rst,sta_we4,sta_we5);
ffxkclkx #(1)   ippsta_chg5 (clk,rst,nxt_sta_chg4,sta1s_chg5);

rtlramstappdi113x #(CNTID,2) sta_1s 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(pact),
     .eng_ra(ram_ra_1s),          //id1
     .eng_rdd({sta1s_chg4,cur_1s}),  //ram_vld4
     .eng_we(sta_we5),
     .eng_wa(ram_ra5_1s),
     .eng_wrd({sta1s_chg5,nxt_1s}),
     
     // CPU interface
     .upen(1'b0),     
     .upa({CNTID+1{1'b0}}),
     .upws(1'b0),
     .uprs(1'b0),
     .updi({CNTWID{1'b0}}),
     .updo(),
     .uprdy(),
     .active(1'b1),

     // RAM or Register File Interface
     .memwe(owe_1s),
     .memre(ore_1s),
     .memwa(owa_1s),
     .memwrd(odi_1s),
     .memra(ora_1s),
     .memrdd(ido_1s)
     );

iarray113x #(CNTID,1<<CNTID,2,"MLAB") ins_mem_sta1s
    (
     .wrst(rst),
     .wclk(clk),
     .wa    (owa_1s),
     .we    (owe_1s),
     .di    (odi_1s),

     .rrst(rst),
     .rclk(clk),
     .ra    (ora_1s),
     .re    (ore_1s),
     .do    (ido_1s),

     .test(1'b0),
     .mask(1'b0)
     );
endmodule 
