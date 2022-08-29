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

wire [NADR-1:0]	nadra,nadrb;
assign			nadra = {{NADR-ADR{1'b0}},adra};
assign			nadrb = {{NADR-ADR{1'b0}},adrb};

wire			wena7,rena7,wenb7,renb7;wire [ADR7-1:0]	adra7,adrb7;
wire			wena6,rena6,wenb6,renb6;wire [ADR6-1:0]	adra6,adrb6;
wire			wena5,rena5,wenb5,renb5;wire [ADR5-1:0]	adra5,adrb5;
wire			wena4,rena4,wenb4,renb4;wire [ADR4-1:0]	adra4,adrb4;
wire			wena3,rena3,wenb3,renb3;wire [ADR3-1:0]	adra3,adrb3;
wire			wena2,rena2,wenb2,renb2;wire [ADR2-1:0]	adra2,adrb2;
wire			wena1,rena1,wenb1,renb1;wire [ADR1-1:0]	adra1,adrb1;
wire			wena0,rena0,wenb0,renb0;wire [ADR0-1:0]	adra0,adrb0;

assign	wena7 = wena & NUMBLK[7] & (nadra[NADR-1:NADR-1]==1'b0);
assign	wena6 = wena & NUMBLK[6] & (nadra[NADR-1:NADR-2]==2'b10);
assign	wena5 = wena & NUMBLK[5] & (nadra[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	wena4 = wena & NUMBLK[4] & (nadra[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	wena3 = wena & NUMBLK[3] & (nadra[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	wena2 = wena & NUMBLK[2] & (nadra[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	wena1 = wena & NUMBLK[1] & (nadra[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	wena0 = wena & NUMBLK[0] & (nadra[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
/*
assign	rena7 = rena & NUMBLK[7] & (nadra[NADR-1:NADR-1]==1'b0);
assign	rena6 = rena & NUMBLK[6] & (nadra[NADR-1:NADR-2]==2'b10);
assign	rena5 = rena & NUMBLK[5] & (nadra[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	rena4 = rena & NUMBLK[4] & (nadra[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	rena3 = rena & NUMBLK[3] & (nadra[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	rena2 = rena & NUMBLK[2] & (nadra[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	rena1 = rena & NUMBLK[1] & (nadra[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	rena0 = rena & NUMBLK[0] & (nadra[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
*/
assign	rena7 = rena;
assign	rena6 = rena;
assign	rena5 = rena;
assign	rena4 = rena;
assign	rena3 = rena;
assign	rena2 = rena;
assign	rena1 = rena;
assign	rena0 = rena;

assign	wenb7 = wenb & NUMBLK[7] & (nadrb[NADR-1:NADR-1]==1'b0);
assign	wenb6 = wenb & NUMBLK[6] & (nadrb[NADR-1:NADR-2]==2'b10);
assign	wenb5 = wenb & NUMBLK[5] & (nadrb[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	wenb4 = wenb & NUMBLK[4] & (nadrb[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	wenb3 = wenb & NUMBLK[3] & (nadrb[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	wenb2 = wenb & NUMBLK[2] & (nadrb[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	wenb1 = wenb & NUMBLK[1] & (nadrb[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	wenb0 = wenb & NUMBLK[0] & (nadrb[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
/*
assign	renb7 = renb & NUMBLK[7] & (nadrb[NADR-1:NADR-1]==1'b0);
assign	renb6 = renb & NUMBLK[6] & (nadrb[NADR-1:NADR-2]==2'b10);
assign	renb5 = renb & NUMBLK[5] & (nadrb[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0});
assign	renb4 = renb & NUMBLK[4] & (nadrb[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0});
assign	renb3 = renb & NUMBLK[3] & (nadrb[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0});
assign	renb2 = renb & NUMBLK[2] & (nadrb[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0});
assign	renb1 = renb & NUMBLK[1] & (nadrb[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0});
assign	renb0 = renb & NUMBLK[0] & (nadrb[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0});
*/
assign	renb7 = renb;
assign	renb6 = renb;
assign	renb5 = renb;
assign	renb4 = renb;
assign	renb3 = renb;
assign	renb2 = renb;
assign	renb1 = renb;
assign	renb0 = renb;

assign	adra7 = nadra[NADR-2:0];	assign	adrb7 = nadrb[NADR-2:0];
assign	adra6 = nadra[NADR-3:0];	assign	adrb6 = nadrb[NADR-3:0];
assign	adra5 = nadra[NADR-4:0];	assign	adrb5 = nadrb[NADR-4:0];
assign	adra4 = nadra[NADR-5:0];	assign	adrb4 = nadrb[NADR-5:0];
assign	adra3 = nadra[NADR-6:0];	assign	adrb3 = nadrb[NADR-6:0];
assign	adra2 = nadra[NADR-7:0];	assign	adrb2 = nadrb[NADR-7:0];
assign	adra1 = nadra[NADR-8:0];	assign	adrb1 = nadrb[NADR-8:0];
assign	adra0 = nadra[NADR-9:0];	assign	adrb0 = nadrb[NADR-9:0];

wire	rsela7,rsela7_p1,rsela7_p2;wire	rselb7,rselb7_p1,rselb7_p2;
wire	rsela6,rsela6_p1,rsela6_p2;wire	rselb6,rselb6_p1,rselb6_p2;
wire	rsela5,rsela5_p1,rsela5_p2;wire	rselb5,rselb5_p1,rselb5_p2;
wire	rsela4,rsela4_p1,rsela4_p2;wire	rselb4,rselb4_p1,rselb4_p2;
wire	rsela3,rsela3_p1,rsela3_p2;wire	rselb3,rselb3_p1,rselb3_p2;
wire	rsela2,rsela2_p1,rsela2_p2;wire	rselb2,rselb2_p1,rselb2_p2;
wire	rsela1,rsela1_p1,rsela1_p2;wire	rselb1,rselb1_p1,rselb1_p2;
wire	rsela0,rsela0_p1,rsela0_p2;wire	rselb0,rselb0_p1,rselb0_p2;

assign	rsela7 = rena ? (NUMBLK[7] & (nadra[NADR-1:NADR-1]==1'b0 )) : rsela7_p1;
assign	rsela6 = rena ? (NUMBLK[6] & (nadra[NADR-1:NADR-2]==2'b10)) : rsela6_p1;
assign	rsela5 = rena ? (NUMBLK[5] & (nadra[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0})) : rsela5_p1;
assign	rsela4 = rena ? (NUMBLK[4] & (nadra[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0})) : rsela4_p1;
assign	rsela3 = rena ? (NUMBLK[3] & (nadra[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0})) : rsela3_p1;
assign	rsela2 = rena ? (NUMBLK[2] & (nadra[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0})) : rsela2_p1;
assign	rsela1 = rena ? (NUMBLK[1] & (nadra[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0})) : rsela1_p1;
assign	rsela0 = rena ? (NUMBLK[0] & (nadra[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0})) : rsela0_p1;

assign	rselb7 = renb ? (NUMBLK[7] & (nadrb[NADR-1:NADR-1]==1'b0 )) : rselb7_p1;
assign	rselb6 = renb ? (NUMBLK[6] & (nadrb[NADR-1:NADR-2]==2'b10)) : rselb6_p1;
assign	rselb5 = renb ? (NUMBLK[5] & (nadrb[NADR-1:NADR-3]=={NUMBLK[7:6],1'b0})) : rselb5_p1;
assign	rselb4 = renb ? (NUMBLK[4] & (nadrb[NADR-1:NADR-4]=={NUMBLK[7:5],1'b0})) : rselb4_p1;
assign	rselb3 = renb ? (NUMBLK[3] & (nadrb[NADR-1:NADR-5]=={NUMBLK[7:4],1'b0})) : rselb3_p1;
assign	rselb2 = renb ? (NUMBLK[2] & (nadrb[NADR-1:NADR-6]=={NUMBLK[7:3],1'b0})) : rselb2_p1;
assign	rselb1 = renb ? (NUMBLK[1] & (nadrb[NADR-1:NADR-7]=={NUMBLK[7:2],1'b0})) : rselb1_p1;
assign	rselb0 = renb ? (NUMBLK[0] & (nadrb[NADR-1:NADR-8]=={NUMBLK[7:1],1'b0})) : rselb0_p1;

wire [DAT-1:0] rdaa7,rdaa6,rdaa5,rdaa4,rdaa3,rdaa2,rdaa1,rdaa0;
wire [DAT-1:0] rdab7,rdab6,rdab5,rdab4,rdab3,rdab2,rdab1,rdab0;

wire [DAT-1:0] wdaa7,wdaa6,wdaa5,wdaa4,wdaa3,wdaa2,wdaa1,wdaa0;
wire [DAT-1:0] wdab7,wdab6,wdab5,wdab4,wdab3,wdab2,wdab1,wdab0;

assign		wdaa7 = wdaa;assign		wdab7 = wdab;
assign		wdaa6 = wdaa;assign		wdab6 = wdab;
assign		wdaa5 = wdaa;assign		wdab5 = wdab;
assign		wdaa4 = wdaa;assign		wdab4 = wdab;
assign		wdaa3 = wdaa;assign		wdab3 = wdab;
assign		wdaa2 = wdaa;assign		wdab2 = wdab;
assign		wdaa1 = wdaa;assign		wdab1 = wdab;
assign		wdaa0 = wdaa;assign		wdab0 = wdab;

generate
if(DEL==1)
	begin : sel_del1
	assign	rdaa  = rsela7_p1 ? rdaa7 :
				    rsela6_p1 ? rdaa6 :
				    rsela5_p1 ? rdaa5 :
				    rsela4_p1 ? rdaa4 :
				    rsela3_p1 ? rdaa3 :
				    rsela2_p1 ? rdaa2 :
				    rsela1_p1 ? rdaa1 : rdaa0;
	assign	rdab  = rselb7_p1 ? rdab7 :
				    rselb6_p1 ? rdab6 :
				    rselb5_p1 ? rdab5 :
				    rselb4_p1 ? rdab4 :
				    rselb3_p1 ? rdab3 :
				    rselb2_p1 ? rdab2 :
				    rselb1_p1 ? rdab1 : rdab0;
	end
else
	begin : sel_del2
	assign	rdaa  = rsela7_p2 ? rdaa7 :
				    rsela6_p2 ? rdaa6 :
				    rsela5_p2 ? rdaa5 :
				    rsela4_p2 ? rdaa4 :
				    rsela3_p2 ? rdaa3 :
				    rsela2_p2 ? rdaa2 :
				    rsela1_p2 ? rdaa1 : rdaa0;
	assign	rdab  = rselb7_p2 ? rdab7 :
				    rselb6_p2 ? rdab6 :
				    rselb5_p2 ? rdab5 :
				    rselb4_p2 ? rdab4 :
				    rselb3_p2 ? rdab3 :
				    rselb2_p2 ? rdab2 :
				    rselb1_p2 ? rdab1 : rdab0;
	end
endgenerate
































/*
initial
	begin
	$display("%m \n: ADR %d, DAT %d, DEP %d, IDEP %d, DIV %d, INT1 %d, REM1 %d, IDAT %d, RDAT %d",ADR,DAT,DEP,IDEP,DIV,INT1,REM1,IDAT,RDAT);
	end
*/
