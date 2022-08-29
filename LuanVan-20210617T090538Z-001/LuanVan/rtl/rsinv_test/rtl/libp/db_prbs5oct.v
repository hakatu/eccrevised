////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : vmap_prbs4oct.v
// Description  : .
//
// Author       : mbsang@HW-MBSANG
// Created On   : Tue Jan 02 14:40:46 2007
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module db_prbs5oct
    (
     iprbs,
     imode,
     inob,

     oprbs,
     oendfrm
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [31:0]    iprbs;
input [2:0]     imode;
input [1:0]     inob;

output [31:0]   oprbs;
output          oendfrm;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       RESET       = 32'hff_ff_ff_fe;
parameter       PATTERN7    = 7'h12;
parameter       PATTERN15   = 15'h1234;
parameter       PATTERN23   = 23'h123456;
parameter       PATTERN31   = 31'h12345678;
parameter       PATTERNCNT  = 8'h12;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire            mode7;
wire            mode15;
wire            mode23;
wire            mode31;
wire            modecnt;
wire            modefix;
assign          mode7   = (imode == 3'd0);
assign          mode15  = (imode == 3'd1);
assign          mode23  = (imode == 3'd2);
assign          mode31  = (imode == 3'd3);
assign          modecnt = (imode == 3'd4);
assign          modefix = (imode == 3'd5);

wire            nob1;
wire            nob2;
wire            nob3;
assign          nob1    = (inob == 2'd1);
assign          nob2    = (inob == 2'd2);
assign          nob3    = (inob == 2'd3);

////////////////////////////////////////////////////////////
//PRBS Calculate
//PRBS7
wire [31:0]     oprbs7b1;
wire [31:0]     oprbs7b2;
wire [31:0]     oprbs7b3;
wire [31:0]     oprbs7b4;

db_prbscal #(32,6,13) prbs7b1(iprbs,oprbs7b1);
db_prbscal #(32,6,13) prbs7b2(oprbs7b1,oprbs7b2);
db_prbscal #(32,6,13) prbs7b3(oprbs7b2,oprbs7b3);
db_prbscal #(32,6,13) prbs7b4(oprbs7b3,oprbs7b4);

//PRBS15
wire [31:0]     oprbs15b1;
wire [31:0]     oprbs15b2;
wire [31:0]     oprbs15b3;
wire [31:0]     oprbs15b4;

db_prbscal #(32,14,13) prbs15b1(iprbs,oprbs15b1);
db_prbscal #(32,14,13) prbs15b2(oprbs15b1,oprbs15b2);
db_prbscal #(32,14,13) prbs15b3(oprbs15b2,oprbs15b3);
db_prbscal #(32,14,13) prbs15b4(oprbs15b3,oprbs15b4);

//PRBS23
wire [31:0]     oprbs23b1;
wire [31:0]     oprbs23b2;
wire [31:0]     oprbs23b3;
wire [31:0]     oprbs23b4;

db_prbscal #(32,22,17) prbs23b1(iprbs,oprbs23b1);
db_prbscal #(32,22,17) prbs23b2(oprbs23b1,oprbs23b2);
db_prbscal #(32,22,17) prbs23b3(oprbs23b2,oprbs23b3);
db_prbscal #(32,22,17) prbs23b4(oprbs23b3,oprbs23b4);

//PRBS31
wire [31:0]     oprbs31b1;
wire [31:0]     oprbs31b2;
wire [31:0]     oprbs31b3;
wire [31:0]     oprbs31b4;

db_prbscal #(32,30,27) prbs31b1(iprbs,oprbs31b1);
db_prbscal #(32,30,27) prbs31b2(oprbs31b1,oprbs31b2);
db_prbscal #(32,30,27) prbs31b3(oprbs31b2,oprbs31b3);
db_prbscal #(32,30,27) prbs31b4(oprbs31b3,oprbs31b4);

//Counter
wire [31:0]     ocnt;
wire [31:0]     ocntb1;
wire [31:0]     ocntb2;
wire [31:0]     ocntb3;
wire [31:0]     ocntb4;
assign          ocnt    = {iprbs[7:0] + 1'h1,
                           iprbs[7:0] + 2'h2,
                           iprbs[7:0] + 2'h3,
                           iprbs[7:0] + 3'h4};
assign          ocntb1  = {iprbs[23:0],ocnt[31:24]};
assign          ocntb2  = {iprbs[15:0],ocnt[31:16]};
assign          ocntb3  = {iprbs[7:0],ocnt[31:8]};
assign          ocntb4  = ocnt;

//FIX
wire [31:0]     ofixdb1;
wire [31:0]     ofixdb2;
wire [31:0]     ofixdb3;
wire [31:0]     ofixdb4;

//Fix Pattern
wire [31:0]     ofixpat ;
assign          ofixpat = {iprbs[7:0],
                           iprbs[7:0],
                           iprbs[7:0],
                           iprbs[7:0]};

assign          ofixdb1 = ofixpat;
assign          ofixdb2 = ofixpat;
assign          ofixdb3 = ofixpat;
assign          ofixdb4 = ofixpat;

////////////////////////////////////////////////////////////
//Output
wire [31:0]     oprbsb1;
wire [31:0]     oprbsb2;
wire [31:0]     oprbsb3;
wire [31:0]     oprbsb4;

wire            prbsrst;
assign          prbsrst = !(|iprbs);

assign          oprbsb1 = modecnt   ? ocntb1    :
                          prbsrst   ? RESET     :
				          mode7     ? oprbs7b1 :
                          mode15    ? oprbs15b1 :
                          mode23    ? oprbs23b1 : 
                          mode31    ? oprbs31b1 : ofixdb1;

assign          oprbsb2 = modecnt   ? ocntb2    :
                          prbsrst   ? RESET     :
				          mode7     ? oprbs7b2  :
                          mode15    ? oprbs15b2 :
                          mode23    ? oprbs23b2 :
                          mode31    ? oprbs31b2 : ofixdb2;

assign          oprbsb3 = modecnt   ? ocntb3    :
                          prbsrst   ? RESET     :
				          mode7     ? oprbs7b3  :
                          mode15    ? oprbs15b3 :
                          mode23    ? oprbs23b3 : 
                          mode31    ? oprbs31b3 : ofixdb3;

assign          oprbsb4 = modecnt   ? ocntb4    :
                          prbsrst   ? RESET     :
				          mode7     ? oprbs7b4  :
                          mode15    ? oprbs15b4 :
                          mode23    ? oprbs23b4 : 
                          mode31    ? oprbs31b4 : ofixdb4;

assign          oprbs   = nob1      ? oprbsb1 :
                          nob2      ? oprbsb2 :
                          nob3      ? oprbsb3 : oprbsb4;

wire            ecntc1;
wire            ecntc2;
wire            ecntc3;
wire            ecntc4;
wire            ecnt;

assign          ecntc1  = (oprbs[31:24]  == PATTERNCNT);
assign          ecntc2  = (oprbs[23:16]  == PATTERNCNT);
assign          ecntc3  = (oprbs[15:8]   == PATTERNCNT);
assign          ecntc4  = (oprbs[7:0]    == PATTERNCNT);
assign          ecnt    = nob1  ? ecntc1 :
                          nob2  ? ecntc1 | ecntc2 :
                          nob3  ? ecntc1 | ecntc2 | ecntc3 : 
                          ecntc1 | ecntc2 | ecntc3 | ecntc4;

assign          oendfrm = mode7  ? (iprbs[6:0]  == PATTERN7) :
				          mode15 ? (iprbs[14:0] == PATTERN15) :
                          mode23 ? (iprbs[22:0] == PATTERN23) :
                          mode31 ? (iprbs[30:0] == PATTERN31) : ecnt;

                                   
                                       
endmodule 
