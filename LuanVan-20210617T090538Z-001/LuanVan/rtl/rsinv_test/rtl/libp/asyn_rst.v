////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : asyn_rst.v
// Description  : .
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Tue Jun 21 11:26:07 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module asyn_rst
    (
     clk,
     irst,
     orst
     
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           ENBBUFG = 1'b0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   clk;
input   irst;
output  orst;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire    orst;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
/*
 |irst ___________________
 |            |            |
 |          __|___       __|___
 |         |      |     |      |
 |   0-----|D    Q|-----|D    Q|------- orst
 |         |      |     |      |
 |    +----|>     |  +--|>     |
 |    |    |______|  |  |______|
 |    |              |
 |clk_|______________|
 */
  
(* ASYNC_REG = "TRUE" *) reg     irstp1 = 1'b1;
(* ASYNC_REG = "TRUE" *) reg     irstp2 = 1'b1;

always @(posedge clk or posedge irst)
    begin
    if(irst)
        begin
        irstp1 <= 1'b1;
        irstp2 <= 1'b1;
        end
    else
        begin
        irstp1 <= 1'b0;
        irstp2 <= irstp1;
        end
    end

generate
if(ENBBUFG==1'b1)
    begin : enbbufg
    BUFG BUFG (.I(irstp2), .O(orst));
    end
else
    begin : disbufg
    assign  orst = irstp2;
    end
endgenerate

endmodule 
