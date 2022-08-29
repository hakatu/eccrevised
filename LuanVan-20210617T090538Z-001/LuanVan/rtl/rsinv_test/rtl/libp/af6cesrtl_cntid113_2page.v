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

// Synchronize pulse
wire [2:0]              pulses;
fflopx #(3) ipulses (clk,rst,{pulses[1:0],pulse},pulses);

wire                    pulse_tick;
assign                  pulse_tick = (pulses[2:1] == 2'b01);

// Create page because external pulse is just a strobe sometime
wire                    page,page4,page5;
fflopxe #(1) ipage (clk,rst,pulse_tick,(!page),page);
ffxkclkx #(4,1) pp4page (clk,rst,page,page4);
ffxkclkx #(1,1) pppage4 (clk,rst,page4,page5);

// Pipeline input
wire [CNTBIT-1:0]       cnum3,cnum4,cnum5;
ffxkclkx #(4,CNTBIT) ppicnum (clk,rst,icnum,cnum3);
fflopx #(CNTBIT) icnum4 (clk,rst,(cnum3+1'b1),cnum4);
fflopx #(CNTBIT) icnum5 (clk,rst,cnum4,cnum5);

wire                    cvld,cvld4;
fflopx #(1)  icvld (clk,rst,alarm,cvld);
ffxkclkx #(4,1)  icvld4 (clk,rst,cvld,cvld4);

wire [CNTID-1:0]        cid;
fflopx #(CNTID) icid (clk,rst,id,cid);

////////////////////////////////////////////////////////////////////////////////
// Mux 3 source access RAM counter: CPU, engine and scan
// 1: CPU access
reg                     cpu_re = 1'b0;   // just support RO & R2C
wire                    cpu_vld,cpu_vld4,cpu_vldr2c4;
assign                  cpu_vld = !cvld & cpu_re;
always @ (posedge clk)
    begin
    if (upen & uprd)    cpu_re <= 1'b1;
    else if (cpu_vld)   cpu_re <= 1'b0;
    end
ffxkclkx #(4,1)  icpu_vld4 (clk,rst,cpu_vld,cpu_vld4);
ffxkclkx #(4,1) icpu_r2c4 (clk,rst,(!upa[CNTID] & cpu_vld),cpu_vldr2c4);

// Scan ID access every tick 1s to clear status in case no valid or CPU access to clear
reg [CNTID-1:0]         scanid = {CNTID{1'b0}};

reg                     scanre = 1'b0;
wire                    scanre1;

wire                    scanvld,scanvld4,scanvld5;
assign                  scanvld = scanre & !(cvld | cpu_re);
always @(posedge clk)
    begin
    scanre <= pulse_tick ? 1'b1 : scanvld & (scanid >= {(CNTID){1'b1}}) ? 1'b0 : scanre;  
    scanid <= pulse_tick ? {CNTID{1'b0}} : scanid + scanvld;
    end
ffxkclkx #(1,1)  iscanre   (clk,rst,scanre,scanre1);
ffxkclkx #(4,1)  iscanvld4 (clk,rst,scanvld,scanvld4);
ffxkclkx #(1,1)  iscanvld5 (clk,rst,scanvld,scanvld5);
// Mux Engine access by cvld (highest priority) with CPU & scan: CPU PAGE == !PAGE, engine PAGE = PAGE
wire                    ram_re,ram_re1,ram_re4,ram_re5;
wire [CNTID:0]          ram_ra,ram_ra1,ram_ra4,ram_ra5;
assign                  ram_re = cpu_re | scanre | cvld;
assign                  ram_ra = cvld ? {page,cid} : cpu_re ? {!page,upa[CNTID-1:0]} : {page,scanid};

fflopx #(CNTID+1) ppram_ra (clk,rst,ram_ra,ram_ra1);
ffxkclkx #(3,CNTID+1) ppram_ra1 (clk,rst,ram_ra1,ram_ra4);
ffxkclkx #(1,CNTID+1) ppram_ra4 (clk,rst,ram_ra4,ram_ra5);

fflopx #(1) ppram_re (clk,rst,ram_re,ram_re1);
ffxkclkx #(3,1) ppram_re1 (clk,rst,ram_re1,ram_re4);
ffxkclkx #(1,1) ppram_re4 (clk,rst,ram_re4,ram_re5);
 
////////////////////////////////////////////////////////////////////////////////
// Counter 2 page processing: CPU PAGE == PAGE, engine PAGE = !PAGE
wire [CNTWID-1:0]   opagecnt4,opagecnt5,ipagecnt5,pagecntinc5;
wire                opagecur4,ipagecur5,opagecur5;
fflopx #(CNTWID) iopagecnt5 (clk,rst,opagecnt4,opagecnt5);
fflopx #(CNTWID) ipagecntinc5 (clk,rst,(opagecnt4 + cnum4),pagecntinc5);

// PAGE counter
wire                pageclr5;  // CPU R2C or scan clear
wire                pagefst5;  // first valid come in a page
wire                pageinc5;  // page increase counter
fflopx #(1) ipageclr5 (clk,rst,(cpu_vldr2c4 | (scanvld4 & (ram_ra4[CNTID]^opagecur4))),pageclr5);
fflopx #(1) ipagefst5 (clk,rst,(cvld4 & (ram_ra4[CNTID]^opagecur4)),pagefst5);
fflopx #(1) ipageinc5 (clk,rst,(cvld4 & !(ram_ra4[CNTID]^opagecur4)),pageinc5);

assign              ipagecnt5 = pageclr5 ? {CNTWID{1'b0}} : pagefst5 ? cnum5 : pageinc5 ? pagecntinc5 : opagecnt5;

// Store current page to compare when switch page
assign              ipagecur5 = page5;
fflopx #(1) ipp_pagecur (clk,rst,opagecur4,opagecur5);

// Counter value to CPU
wire [CNTWID-1:0]   updo,nupdo;
assign              nupdo = cpu_vld4 ? opagecnt4 : upen ? updo : {CNTWID{1'b0}};
fflopx #(CNTWID) iupdo (clk,rst,nupdo,updo);

wire                uprdy,nuprdy;
assign              nuprdy = (upen & upwr) | cpu_vld4;
ffxkclkx #(2,1) iuprdy (clk,rst,nuprdy,uprdy);

wire                oint = 1'b0;

// Buffer control
rtlstappdi113x #(CNTID+1,CNTWID) cntsta 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(ram_re1),
     .eng_ra(ram_ra1),
     .eng_rdd(opagecnt4),
     .eng_we(ram_re5),
     .eng_wa(ram_ra5),
     .eng_wrd(ipagecnt5),
     
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
// page status , rd cur page to decide addr of write cnt
// pririty : alarm/cpu/scan
wire [CNTID-1:0]    owa_pg,
                    ora_pg;
wire                owe_pg;
wire                ore_pg;
wire                odi_pg;
wire                ido_pg;
fflopx #(1) ipp_stachg (clk,rst,opagecur4 ^ page4,page_chg5);

rtlramstappdi113x #(CNTID,1) sta_page
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(ram_re1),
     .eng_ra(ram_ra1[CNTID-1:0]),                  //id1
     .eng_rdd(opagecur4),   //ram_vld4
     .eng_we(ram_re5),
     .eng_wa(ram_ra5[CNTID-1:0]),
     .eng_wrd(ipagecur5),
     
     // CPU interface
     .upen(1'b0),     
     .upa({CNTID{1'b0}}),
     .upws(1'b0),
     .uprs(1'b0),
     .updi({1{1'b0}}),
     .updo(),
     .uprdy(),
     .active(1'b1),

     // RAM or Register File Interface
     .memwe(owe_pg),
     .memre(ore_pg),
     .memwa(owa_pg),
     .memwrd(odi_pg),
     .memra(ora_pg),
     .memrdd(ido_pg)
     );

parameter TYPE_RAM_PG = "AUTO";

iarray113x #(CNTID,1<<CNTID,1,TYPE_RAM_PG) ins_mem_page
    (
     .wrst(rst),
     .wclk(clk),
     .wa    (owa_pg),
     .we    (owe_pg),
     .di    (odi_pg),

     .rrst(rst),
     .rclk(clk),
     .ra    (ora_pg),
     .re    (ore_pg),
     .do    (ido_pg),

     .test(1'b0),
     .mask(1'b0)
     );
endmodule 
