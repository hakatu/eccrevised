////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : db_prbs154oct.v
// Description  : .
//
// Author       : tund@HW-NDTU
// Created On   : Wed Oct 17 11:05:20 2012
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module db_prbs154oct
    (
     iprbs,
     oprbs
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [31:0]    iprbs;
output [31:0]   oprbs;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       RESET       = 32'hff_ff_ff_fe;
parameter       PATTERN15   = 15'h1234;
parameter       PATTERN23   = 23'h123456;
parameter       PATTERN31   = 31'h12345678;
parameter       PATTERNCNT  = 8'h12;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//wire            mode15;
//wire            mode23;
//wire            mode31;
//wire            modecnt;
//assign          mode15  = (imode == 2'd0);
//assign          mode23  = (imode == 2'd1);
//assign          mode31  = (imode == 2'd2);
//assign          modecnt = (imode == 2'd3);

////////////////////////////////////////////////////////////
//PRBS Calculate
//PRBS15
wire [31:0]     oprbs15b1;
wire [31:0]     oprbs15b2;
wire [31:0]     oprbs15b3;
wire [31:0]     oprbs15b4;

db_prbscal #(32,14,13) prbs15b1(iprbs,oprbs15b1);
db_prbscal #(32,14,13) prbs15b2(oprbs15b1,oprbs15b2);
db_prbscal #(32,14,13) prbs15b3(oprbs15b2,oprbs15b3);
db_prbscal #(32,14,13) prbs15b4(oprbs15b3,oprbs15b4);

////////////////////////////////////////////////////////////
//Output
assign          oprbs   = iprbs == 32'b0 ? RESET : oprbs15b4; 
                                       
endmodule 
