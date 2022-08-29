////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlcore.v
// Description  : .
//
// Author       : cuongnv@LTHP022018
// Created On   : Tue May 29 14:52:17 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module tbcoretest
    (clk,
     rst,

     // Data in
     fifowr,
     fifodi,

     // Data out
     fiford,
     fifodo,
     fifodovld
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   WID = 8;
parameter   WRBW = 50;   // 50%, adjust this value to test full/empty
parameter   RDBW = 50;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

     // Data in
output              fifowr;
output [WID-1:0]    fifodi;


     // Data out
output              fiford;
input [WID-1:0]     fifodo;
input               fifodovld;


////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [7:0]           bwcnt;  // generate 100 timeslot for BW calculation, step 10%
always @ (posedge clk or posedge rst)
    begin
    if (rst)    bwcnt <= 8'd0;
    else        bwcnt <= (bwcnt >= 8'd99) ? 8'd0 : bwcnt + 1'b1;
    end

reg                 fifowr = 1'b0;
wire                fifowr_en = (bwcnt < WRBW); 
always @ (posedge clk)  fifowr <= fifowr_en;

reg [WID-1:0]       fifodi = 8'd0;
always @ (posedge clk)  fifodi <= fifodi + fifowr_en;// sequence data to test

reg                 fiford = 1'b0;
wire                fiford_en = (bwcnt < RDBW); 
always @ (posedge clk)  fiford <= fiford_en;

reg [WID-1:0]       fifodo_lat = 8'd0;
always @ (posedge clk)  if (fifodovld)  fifodo_lat <= fifodo;

wire                error;
assign              error = fifodovld & (fifodo != fifodo_lat + 1'b1);

////////////////////////////////////////////////////////////////////////////////
`ifdef  RTL_LOG_FILE
always @ (posedge clk)
    begin
    if (error) $fdisplay (rtllogfile,"ERROR @time %t",$time);
    end
`endif
endmodule 
