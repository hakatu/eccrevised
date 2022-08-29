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
function [15:0]	get_maxdepth;
input [31:0]	W;
input [31:0]	D;
reg [15:0]	n [5:0];
reg [15:0]	m [5:0];
reg [15:0]	d0,w0;

integer    	i,pos;
reg [31:0]	temp0,temp1;
begin
for(i=0;i<6;i=i+1)
	begin
	d0 = i==0 ? 512 :
		 i==1 ? 1024:
		 i==2 ? 2048:
		 i==3 ? 4096:
		 i==4 ? 8192: 16384;
	w0 = i==0 ? 36  :
		 i==1 ? 18  :
		 i==2 ?  9  :
		 i==3 ?  4  :
		 i==4 ?  2  : 1;
	
	n[i]=(D/d0)+((D%d0) ? 1 : 0);
	m[i]=(W/w0)+((W%w0) ? 1 : 0);
	
	end
pos=0;
for(i=0;i<6;i=i+1)
	begin
	if(n[i]<8)
		begin
		pos= i;
		i  = 6;
		end
	end

temp0=n[pos]*m[pos];
for(i=pos+1;i<6;i=i+1)
	begin
	temp1 = n[i]*m[i];
	pos = (temp1 < temp0) ? i : pos;
	end
get_maxdepth = pos==0 ? 512 :
		       pos==1 ? 1024:
		       pos==2 ? 2048:
		       pos==3 ? 4096:
		       pos==4 ? 8192: 16384;
end
endfunction


localparam  DEPADR  = 1<<ADR;

localparam  IDEP = (DEP < DEPADR)   ? DEP : DEPADR;
localparam	IMAXDEP = get_maxdepth(DAT,IDEP);
/*
localparam	IMAXDEP = (MAX!=0)      ?   MAX :
					  (IDEP<=  512) ?   512 :
					  (IDEP<= 1024) ?  1024 :
					  (IDEP<= 2048) ?  2048 :
					  (IDEP<= 4096) ?  4096 :
					  (IDEP<= 8192) ?  8192 :
					  (IDEP<=16384) ? 16384 : 2048;
*/

localparam  DIV  = (IMAXDEP==  512) ? 36 :
                   (IMAXDEP== 1024) ? 18 :
				   (IMAXDEP== 2048) ?  9 :
				   (IMAXDEP== 4096) ?  4 :
				   (IMAXDEP== 8192) ?  2 : 1;

localparam  INT1 = DAT/DIV;
localparam  REM1 = DAT%DIV;

localparam  IDAT = INT1*DIV;
localparam  RDAT = REM1;

localparam	SELTYP = DIS_SMALL_RAM2MLAB	? ((TYP=="MLAB") ? 0 : 1) : 
					 (IDEP < THDEP)		? 0 : 
					((IDEP ==THDEP)	&& (DAT < 32))	? 0 : 1;


/*
initial
	begin
	$display("%m \n: ADR %d, DAT %d, DEP %d, IDEP %d, DIV %d, INT1 %d, REM1 %d, IDAT %d, RDAT %d",ADR,DAT,DEP,IDEP,DIV,INT1,REM1,IDAT,RDAT);
	end
*/
