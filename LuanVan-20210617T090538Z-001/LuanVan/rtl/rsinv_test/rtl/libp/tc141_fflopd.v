////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : tc141_fflopd.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Sun Aug 16 14:55:43 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module tc141_fflopd
    (
     clk    ,
     rstn   ,
     din    ,
     dout   
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           DAT = 1;
parameter           NPP = 1;
parameter           VAL = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk ;
input               rstn;
input [DAT-1:0]     din;
output [DAT-1:0]    dout;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [DAT*NPP-1:0]  nxt_temp,temp;

tc141_fflopx #(DAT,VAL)   cr_temp[NPP-1:0](clk,rstn,nxt_temp,temp);

generate
if(NPP==0)
    begin : bypass
    assign          dout = din;
    end
else
    begin : delay
    assign          dout = temp[DAT-1:0];
    end
endgenerate

generate
if(NPP==1)
    begin : delay_1
    assign              nxt_temp = din;
    end
else
    begin : delay_n
    assign              nxt_temp = {din,temp[DAT*NPP-1:DAT]};
    end
endgenerate



endmodule 
