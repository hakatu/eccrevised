////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_sel_param.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon Jul 06 10:53:47 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

localparam [7:0] NUMBLK = (DEP/MAX)+((DEP%MAX) ? 1 : 0);

localparam	NLSB = (MAX==  512) ?  9 :
                   (MAX== 1024) ? 10 :
				   (MAX== 2048) ? 11 :
				   (MAX== 4096) ? 12 :
				   (MAX== 8192) ? 13 :
				   (MAX==16384) ? 14 : 11;

localparam	NADR = 8+NLSB;

localparam	ADR7 = NLSB+7;
localparam	ADR6 = NLSB+6;
localparam	ADR5 = NLSB+5;
localparam	ADR4 = NLSB+4;
localparam	ADR3 = NLSB+3;
localparam	ADR2 = NLSB+2;
localparam	ADR1 = NLSB+1;
localparam	ADR0 = NLSB+0;

wire [NADR-1:0]	nwadr,nradr;
assign			nwadr = {{NADR-ADR{1'b0}},wad};
assign			nradr = {{NADR-ADR{1'b0}},rad};

wire			wen7,ren7;wire [ADR7-1:0]	wad7,rad7;
wire			wen6,ren6;wire [ADR6-1:0]	wad6,rad6;
wire			wen5,ren5;wire [ADR5-1:0]	wad5,rad5;
wire			wen4,ren4;wire [ADR4-1:0]	wad4,rad4;
wire			wen3,ren3;wire [ADR3-1:0]	wad3,rad3;
wire			wen2,ren2;wire [ADR2-1:0]	wad2,rad2;
wire			wen1,ren1;wire [ADR1-1:0]	wad1,rad1;
wire			wen0,ren0;wire [ADR0-1:0]	wad0,rad0;

assign	wen7 = wen & NUMBLK[7] & (nwadr[NADR-1:NADR-1]==1'b0);
assign	wen6 = wen & NUMBLK[6] & (nwadr[NADR-1:NADR-2]==2'b10);
assign	wen5 = wen & NUMBLK[5] & (nwadr[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	wen4 = wen & NUMBLK[4] & (nwadr[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	wen3 = wen & NUMBLK[3] & (nwadr[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	wen2 = wen & NUMBLK[2] & (nwadr[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	wen1 = wen & NUMBLK[1] & (nwadr[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	wen0 = wen & NUMBLK[0] & (nwadr[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
/*
assign	ren7 = ren & NUMBLK[7] & (nradr[NADR-1:NADR-1]==1'b0);
assign	ren6 = ren & NUMBLK[6] & (nradr[NADR-1:NADR-2]==2'b10);
assign	ren5 = ren & NUMBLK[5] & (nradr[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	ren4 = ren & NUMBLK[4] & (nradr[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	ren3 = ren & NUMBLK[3] & (nradr[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	ren2 = ren & NUMBLK[2] & (nradr[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	ren1 = ren & NUMBLK[1] & (nradr[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	ren0 = ren & NUMBLK[0] & (nradr[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
*/
assign	ren7 = ren;
assign	ren6 = ren;
assign	ren5 = ren;
assign	ren4 = ren;
assign	ren3 = ren;
assign	ren2 = ren;
assign	ren1 = ren;
assign	ren0 = ren;

assign	wad7 = nwadr[NADR-2:0];	assign	rad7 = nradr[NADR-2:0];
assign	wad6 = nwadr[NADR-3:0];	assign	rad6 = nradr[NADR-3:0];
assign	wad5 = nwadr[NADR-4:0];	assign	rad5 = nradr[NADR-4:0];
assign	wad4 = nwadr[NADR-5:0];	assign	rad4 = nradr[NADR-5:0];
assign	wad3 = nwadr[NADR-6:0];	assign	rad3 = nradr[NADR-6:0];
assign	wad2 = nwadr[NADR-7:0];	assign	rad2 = nradr[NADR-7:0];
assign	wad1 = nwadr[NADR-8:0];	assign	rad1 = nradr[NADR-8:0];
assign	wad0 = nwadr[NADR-9:0];	assign	rad0 = nradr[NADR-9:0];

wire	rsel7,rsel7_p1,rsel7_p2;
wire	rsel6,rsel6_p1,rsel6_p2;
wire	rsel5,rsel5_p1,rsel5_p2;
wire	rsel4,rsel4_p1,rsel4_p2;
wire	rsel3,rsel3_p1,rsel3_p2;
wire	rsel2,rsel2_p1,rsel2_p2;
wire	rsel1,rsel1_p1,rsel1_p2;
wire	rsel0,rsel0_p1,rsel0_p2;
assign	rsel7 = ren ? (NUMBLK[7] & (nradr[NADR-1:NADR-1]==1'b0 )) : rsel7_p1;
assign	rsel6 = ren ? (NUMBLK[6] & (nradr[NADR-1:NADR-2]==2'b10)) : rsel6_p1;
assign	rsel5 = ren ? (NUMBLK[5] & (nradr[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0})) : rsel5_p1;
assign	rsel4 = ren ? (NUMBLK[4] & (nradr[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0})) : rsel4_p1;
assign	rsel3 = ren ? (NUMBLK[3] & (nradr[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0})) : rsel3_p1;
assign	rsel2 = ren ? (NUMBLK[2] & (nradr[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0})) : rsel2_p1;
assign	rsel1 = ren ? (NUMBLK[1] & (nradr[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0})) : rsel1_p1;
assign	rsel0 = ren ? (NUMBLK[0] & (nradr[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0})) : rsel0_p1;

wire [DAT-1:0] rda7,rda6,rda5,rda4,rda3,rda2,rda1,rda0;
wire [DAT-1:0] wda7,wda6,wda5,wda4,wda3,wda2,wda1,wda0;
assign		wda7 = wda;
assign		wda6 = wda;
assign		wda5 = wda;
assign		wda4 = wda;
assign		wda3 = wda;
assign		wda2 = wda;
assign		wda1 = wda;
assign		wda0 = wda;

generate
if(DEL==1)
	begin : sel_del1
	assign	rda  = rsel7_p1 ? rda7 :
				   rsel6_p1 ? rda6 :
				   rsel5_p1 ? rda5 :
				   rsel4_p1 ? rda4 :
				   rsel3_p1 ? rda3 :
				   rsel2_p1 ? rda2 :
				   rsel1_p1 ? rda1 : rda0;
	end
else
	begin : sel_del2
	assign	rda  = rsel7_p2 ? rda7 :
				   rsel6_p2 ? rda6 :
				   rsel5_p2 ? rda5 :
				   rsel4_p2 ? rda4 :
				   rsel3_p2 ? rda3 :
				   rsel2_p2 ? rda2 :
				   rsel1_p2 ? rda1 : rda0;
	end
endgenerate
































/*
initial
	begin
	$display("%m \n: ADR %d, DAT %d, DEP %d, IDEP %d, DIV %d, INT1 %d, REM1 %d, IDAT %d, RDAT %d",ADR,DAT,DEP,IDEP,DIV,INT1,REM1,IDAT,RDAT);
	end
*/
