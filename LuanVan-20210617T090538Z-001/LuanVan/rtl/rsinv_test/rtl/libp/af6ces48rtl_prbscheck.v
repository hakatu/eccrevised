////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af6zn13rtlmpeg_dbprbsmon.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Wed Jul 04 11:28:21 2012
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af6ces48rtl_prbscheck
    (ivld,
     idat,
     iprbs,
     oprbs,
     oerr,
     osyn
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           HI    = 15; // PRBS15
parameter           LO    = 14;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input           ivld;
input [7:0]     idat;
input [HI-1:0]  iprbs;
output [HI-1:0] oprbs;
output          oerr,
                osyn;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire [HI-1:0]       prbs1,prbs2,prbs3,prbs4,prbs5,prbs6,prbs7,prbs8,oprbs;
assign              prbs1 = {iprbs[HI-2:0],idat[7]};
assign              prbs2 = {prbs1[HI-2:0],idat[6]};
assign              prbs3 = {prbs2[HI-2:0],idat[5]};
assign              prbs4 = {prbs3[HI-2:0],idat[4]};
assign              prbs5 = {prbs4[HI-2:0],idat[3]};
assign              prbs6 = {prbs5[HI-2:0],idat[2]};
assign              prbs7 = {prbs6[HI-2:0],idat[1]};
assign              prbs8 = {prbs7[HI-2:0],idat[0]};

assign              oprbs = prbs8;

wire [7:0]          err;
assign              err[7] = idat[7] ^ iprbs[HI-1] ^ iprbs[LO-1];
assign              err[6] = idat[6] ^ prbs1[HI-1] ^ prbs1[LO-1];
assign              err[5] = idat[5] ^ prbs2[HI-1] ^ prbs2[LO-1];
assign              err[4] = idat[4] ^ prbs3[HI-1] ^ prbs3[LO-1];
assign              err[3] = idat[3] ^ prbs4[HI-1] ^ prbs4[LO-1];
assign              err[2] = idat[2] ^ prbs5[HI-1] ^ prbs5[LO-1];
assign              err[1] = idat[1] ^ prbs6[HI-1] ^ prbs6[LO-1];
assign              err[0] = idat[0] ^ prbs7[HI-1] ^ prbs7[LO-1];

wire                oerr,osyn;
assign              oerr = ivld & ((|err) | (iprbs == {HI{1'b0}}));
assign              osyn = ivld & !oerr;

endmodule 
