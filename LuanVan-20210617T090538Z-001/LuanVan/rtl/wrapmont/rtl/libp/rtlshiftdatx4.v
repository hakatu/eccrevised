////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af6fh2rtl_shf8to32.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Fri Jun 17 14:25:49 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlshiftdatx4
    (clk,
     rst,

     // Input 
     idat,
     ivld,
     isop,
     ieop,
     iinf,
     inob,
     
     // Output x4
     odat,
     ovld,
     osop,
     oeop,
     oinf,
     onob
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WID = 32;
parameter           NOB = 2;
parameter           INF = 1;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               clk,
                    rst;

     // Input 8 bit
input [WID-1:0]     idat;
input               ivld,
                    isop,
                    ieop;
input [NOB-1:0]     inob;
input [INF-1:0]     iinf;

     // Output 32 bit
output [WID*4-1:0]  odat;
output              ovld,
                    osop,
                    oeop;
output [NOB+1:0]    onob;
output [INF-1:0]    oinf;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire                ovld;
wire [WID*3-1:0]    odatlat,idatlat;
wire [WID*4-1:0]    odat;
wire [NOB+1:0]      onob;
wire [1:0]          nob;            
wire                oeop,osop,osoplat;
wire [INF-1:0]      oinf;

assign              ovld = ivld & (ieop | (&onob));
assign              osop = ovld & osoplat;
assign              oeop = ieop;
assign              oinf = iinf;
assign              odat = (nob == 2'd0) ? {idat,{(3*WID){1'b0}}} :
                           (nob == 2'd1) ? {odatlat[WID-1:0],idat,{(2*WID){1'b0}}} :
                           (nob == 2'd2) ? {odatlat[2*WID-1:0],idat,{(1*WID){1'b0}}} : {odatlat,idat};
assign              onob = {nob,inob};
assign              idatlat = (nob == 2'd0) ? idat : 
                              (nob == 2'd1) ? {odatlat[WID-1:0],idat} : {odatlat[2*WID-1:0],idat};
 
fflopx #(2) ppnob (clk,rst,ivld & ieop ? 2'd0 : nob + ivld,nob);
fflopx #(1) iosoplat (clk,rst,ovld ? 1'b0 : ivld & isop ? 1'b1 : osoplat,osoplat);
fflopxe #(3*WID) iodatlat (clk,rst,ivld,idatlat,odatlat);

endmodule 
