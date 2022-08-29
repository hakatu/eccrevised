////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : normalize23.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Thu Nov 08 10:47:06 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module normalize23
    (
     nori,//not normalized data in
     noro,//normalized data out
     bias //bias data for exponent calculation
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDIN = 48;
parameter WIDOUT = 23;
parameter BIASD = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input [WIDIN-1:0] nori;

output [WIDOUT-1:0] noro;
output [BIASD-1:0] bias;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [WIDOUT-1:0]mux1o,mux2o,mux3o,mux4o,mux5o,mux6o,mux7o,mux8o,mux9o,mux10o,mux11o,mux12o,mux13o,mux14o,mux15o,mux16o,mux17o,mux18o,mux19o,mux20o,mux21o,mux22o,mux23o,mux24o,mux25o,mux26o,mux27o,mux28o,mux29o,mux30o,mux31o,mux32o,mux33o,mux34o,mux35o,mux36o,mux37o,mux38o,mux39o,mux40o,mux41o,mux42o,mux43o,mux44o,mux45o,mux46o,mux47o;

mux #(WIDOUT) mux1i(23'b0,{nori[0],22'b0},nori[1],mux1o);
mux #(WIDOUT) mux2i(mux1o,{nori[1:0],21'b0},nori[2],mux2o);
mux #(WIDOUT) mux3i(mux2o,{nori[2:0],20'b0},nori[3],mux3o);
mux #(WIDOUT) mux4i(mux3o,{nori[3:0],19'b0},nori[4],mux4o);
mux #(WIDOUT) mux5i(mux4o,{nori[4:0],18'b0},nori[5],mux5o);
mux #(WIDOUT) mux6i(mux5o,{nori[5:0],17'b0},nori[6],mux6o);
mux #(WIDOUT) mux7i(mux6o,{nori[6:0],16'b0},nori[7],mux7o);
mux #(WIDOUT) mux8i(mux7o,{nori[7:0],15'b0},nori[8],mux8o);
mux #(WIDOUT) mux9i(mux8o,{nori[8:0],14'b0},nori[9],mux9o);
mux #(WIDOUT) mux10i(mux9o,{nori[9:0],13'b0},nori[10],mux10o);
mux #(WIDOUT) mux11i(mux10o,{nori[10:0],12'b0},nori[11],mux11o);
mux #(WIDOUT) mux12i(mux11o,{nori[11:0],11'b0},nori[12],mux12o);
mux #(WIDOUT) mux13i(mux12o,{nori[12:0],10'b0},nori[13],mux13o);
mux #(WIDOUT) mux14i(mux13o,{nori[13:0],9'b0},nori[14],mux14o);
mux #(WIDOUT) mux15i(mux14o,{nori[14:0],8'b0},nori[15],mux15o);
mux #(WIDOUT) mux16i(mux15o,{nori[15:0],7'b0},nori[16],mux16o);
mux #(WIDOUT) mux17i(mux16o,{nori[16:0],6'b0},nori[17],mux17o);
mux #(WIDOUT) mux18i(mux17o,{nori[17:0],5'b0},nori[18],mux18o);
mux #(WIDOUT) mux19i(mux18o,{nori[18:0],4'b0},nori[19],mux19o);
mux #(WIDOUT) mux20i(mux19o,{nori[19:0],3'b0},nori[20],mux20o);
mux #(WIDOUT) mux21i(mux20o,{nori[20:0],2'b0},nori[21],mux21o);
mux #(WIDOUT) mux22i(mux21o,{nori[21:0],1'b0},nori[22],mux22o);
mux #(WIDOUT) mux23i(mux22o,nori[22:0],nori[23],mux23o);
mux #(WIDOUT) mux24i(mux23o,nori[23:1],nori[24],mux24o);
mux #(WIDOUT) mux25i(mux24o,nori[24:2],nori[25],mux25o);
mux #(WIDOUT) mux26i(mux25o,nori[25:3],nori[26],mux26o);
mux #(WIDOUT) mux27i(mux26o,nori[26:4],nori[27],mux27o);
mux #(WIDOUT) mux28i(mux27o,nori[27:5],nori[28],mux28o);
mux #(WIDOUT) mux29i(mux28o,nori[28:6],nori[29],mux29o);
mux #(WIDOUT) mux30i(mux29o,nori[29:7],nori[30],mux30o);
mux #(WIDOUT) mux31i(mux30o,nori[30:8],nori[31],mux31o);
mux #(WIDOUT) mux32i(mux31o,nori[31:9],nori[32],mux32o);
mux #(WIDOUT) mux33i(mux32o,nori[32:10],nori[33],mux33o);
mux #(WIDOUT) mux34i(mux33o,nori[33:11],nori[34],mux34o);
mux #(WIDOUT) mux35i(mux34o,nori[34:12],nori[35],mux35o);
mux #(WIDOUT) mux36i(mux35o,nori[35:13],nori[36],mux36o);
mux #(WIDOUT) mux37i(mux36o,nori[36:14],nori[37],mux37o);
mux #(WIDOUT) mux38i(mux37o,nori[37:15],nori[38],mux38o);
mux #(WIDOUT) mux39i(mux38o,nori[38:16],nori[39],mux39o);
mux #(WIDOUT) mux40i(mux39o,nori[39:17],nori[40],mux40o);
mux #(WIDOUT) mux41i(mux40o,nori[40:18],nori[41],mux41o);
mux #(WIDOUT) mux42i(mux41o,nori[41:19],nori[42],mux42o);
mux #(WIDOUT) mux43i(mux42o,nori[42:20],nori[43],mux43o);
mux #(WIDOUT) mux44i(mux43o,nori[43:21],nori[44],mux44o);
mux #(WIDOUT) mux45i(mux44o,nori[44:22],nori[45],mux45o);
mux #(WIDOUT) mux46i(mux45o,nori[45:23],nori[46],mux46o);
mux #(WIDOUT) mux47i(mux46o,nori[46:24],nori[47],mux47o);
// mux #(WIDOUT) mux48i(mux47o,nori[47:25],nori[48],mux48o);

assign              noro = mux47o;

assign bias = nori[47]? 8'd126 :
       nori[46]? 8'd127 :
       nori[45]? 8'd128 :
       nori[44]? 8'd129 :
       nori[43]? 8'd130 :
       nori[42]? 8'd131 :
       nori[41]? 8'd132 :
       nori[40]? 8'd133 :
       nori[39]? 8'd134 :
       nori[38]? 8'd135 :    
       nori[37]? 8'd136 :
       nori[36]? 8'd137 :
       nori[35]? 8'd138 :
       nori[34]? 8'd139 :
       nori[33]? 8'd140 :
       nori[32]? 8'd141 :
       nori[31]? 8'd142 :
       nori[30]? 8'd143 :
       nori[29]? 8'd144 :
       nori[28]? 8'd145 :
       nori[27]? 8'd146 :
       nori[26]? 8'd147 :
       nori[25]? 8'd148 :
       nori[24]? 8'd149 :
       nori[23]? 8'd150 :
       nori[22]? 8'd151 :
       nori[21]? 8'd152 :
       nori[20]? 8'd153 :
       nori[19]? 8'd154 :
       nori[18]? 8'd155 :
       nori[17]? 8'd156 :
       nori[16]? 8'd157 :
       nori[15]? 8'd158 :
       nori[14]? 8'd159 :
       nori[13]? 8'd160 :
       nori[12]? 8'd161 :
       nori[11]? 8'd162 :
       nori[10]? 8'd163 :
       nori[9]? 8'd164 :
       nori[8]? 8'd165 :
       nori[7]? 8'd166 :
       nori[6]? 8'd167 :
       nori[5]? 8'd168 :
       nori[4]? 8'd169 :
       nori[3]? 8'd170 :
       nori[2]? 8'd171 :
       nori[1]? 8'd172 :
       nori[0]? 8'd173 : 8'd174;       
endmodule 
