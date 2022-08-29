////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : vmap_prbscal.v
// Description  : calculate new prbs value from previous prbs value
//                  after generating 8 bits (1 byte) data.
//
// Author       : mbsang@HW-MBSANG
// Created On   : Fri Nov 26 18:07:23 2004
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module db_prbscal
    (
     iprbs,
     oprbs
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           LEN       = 15;
parameter           HIGHEXP   = 14;
parameter           LOWEXP    = 13;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [LEN-1:0]     iprbs;

output [LEN-1:0]    oprbs;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire                fback,fback1,fback2,fback3,fback4,fback5,fback6,fback7;
wire [LEN-1:0]      gen1,gen2,gen3,gen4,gen5,gen6,gen7,gen8;

assign              fback = iprbs[HIGHEXP] ^ iprbs[LOWEXP];
assign              gen1[LEN-1:0]={iprbs[LEN-2:0],fback};

assign              fback1 = gen1[HIGHEXP] ^ gen1[LOWEXP];
assign              gen2[LEN-1:0]={gen1[LEN-2:0],fback1};

assign              fback2 = gen2[HIGHEXP] ^ gen2[LOWEXP];
assign              gen3[LEN-1:0]={gen2[LEN-2:0],fback2};

assign              fback3 = gen3[HIGHEXP] ^ gen3[LOWEXP];
assign              gen4[LEN-1:0]={gen3[LEN-2:0],fback3};

assign              fback4 = gen4[HIGHEXP] ^ gen4[LOWEXP];
assign              gen5[LEN-1:0]={gen4[LEN-2:0],fback4};

assign              fback5 = gen5[HIGHEXP] ^ gen5[LOWEXP];
assign              gen6[LEN-1:0]={gen5[LEN-2:0],fback5};

assign              fback6 = gen6[HIGHEXP] ^ gen6[LOWEXP];
assign              gen7[LEN-1:0]={gen6[LEN-2:0],fback6};

assign              fback7 = gen7[HIGHEXP] ^ gen7[LOWEXP];
assign              gen8[LEN-1:0]={gen7[LEN-2:0],fback7};

assign              oprbs = gen8;

endmodule 
