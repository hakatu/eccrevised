////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_ifddioin.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Thu Jan 15 10:42:49 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_ifddioin
    (
     rxclk,
     rxrst_,
     idat_h,
     idat_l,
     odat_h, 
     odat_l
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DW = 10; // width data

////////////////////////////////////////////////////////////////////////////////
// input declarations
input             rxrst_;
// input from phys chip
input             rxclk;

input [DW-1: 0]   idat_h; // input data at sample posedge of clk
input [DW-1: 0]   idat_l; // input data at sample negedge of clk and latch at posedge of clk
// output data
output [DW-1: 0]  odat_h; // output data
output [DW-1: 0]  odat_l; // output data

////////////////////////////////////////////////////////////////////////////////
// signal declarations0
reg  [DW-1:0]     idat_h1;
wire [DW-1:0]     edat_l;
wire [DW-1:0]     edat_h;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation


//  Mode Normal
//         ___         _______         _______         _______         _______         _______ 
//  clk       |_______|       |_______|       |_______|       |_______|       |_______|       |
//
//                 ------- ------- ------- ------- ------- -------
//  idat ---------|D1[3:0]|D1[7:4]|D2[3:0]|D2[7:4]|D3[3:0]|D3[7:4]|---------------------------
//                 ------- ------- ------- ------- ------- -------
//                     --------------- --------------- ---------------
//  idat_h------------|    D1[3:0]    |    D2[3:0]    |    D3[3:0]    |-----------------------
//                     --------------- --------------- ---------------
//                                     --------------- --------------- ---------------
//  idat_l----------------------------|    D1[7:4]    |    D2[7:4]    |    D3[7:4]    |--------
//                                     --------------- --------------- ---------------
//                                     --------------- --------------- ---------------
//  odat_h ---------------------------|    D1[3:0]    |    D2[3:0]    |    D3[3:0]    |--------
//                                     --------------- --------------- ---------------
//                                     --------------- --------------- ---------------
//  odat_l ---------------------------|    D1[7:4]    |    D2[7:4]    |    D3[7:4]    |--------
//                                     --------------- --------------- ---------------

assign edat_h = idat_h1;
assign edat_l = idat_l;

//
always @(posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)idat_h1 <= {DW{1'b0}};
    else        idat_h1 <= idat_h;
    end

fflopx #(DW) ffdat_l (rxclk, rxrst_, edat_l, odat_l);
fflopx #(DW) ffdat_h (rxclk, rxrst_, edat_h, odat_h);

endmodule
