//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : iram2rwx.v
// Description     : a library of true dual port RAM model
//
// Author          : nlgiang@HW-NLGIANG
// Created On      : Sat Oct 09 08:17:21 2004
// History (Date, Changed By)
//      Wed Sep 07 15:31:33 2005, ddduc
//          modified from ramspx
//          added new control signals and violation reports
//      Fri Sep 09 16:55:04 2005, ddduc
//          added write violations
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
//
//////////////////////////////////////////////////////////////////////////////////
// +display collision at write side
//      DISPLAY_ERR_RAM_WR = "ON"
// +no display collision at write side
//      DISPLAY_ERR_RAM_WR = "OFF" or define `DISPLAY_ERR_RAM_WR_OFF
// +display collision at read side
//      DISPLAY_ERR_RAM_RD = "ON"
// +no display collision at read side
//      DISPLAY_ERR_RAM_WR = "OFF" or define `DISPLAY_ERR_RAM_WR_OFF
// +turn off write X when collision at write side
//      `ERR_RAM_WR_X_OFF
//

module iram2rwx
    (
     clk0,
     a0,
     we0,
     re0,
     di0,
     do0,
     
     clk1,
     a1,
     we1,
     re1,
     di1,
     do1,
     
     test,
     mask
     );

parameter ADDRBIT_A = 11;
parameter DEPTH_A = 1536;
parameter WIDTH_A = 32;

parameter ADDRBIT_B = 11;
parameter DEPTH_B = 1536;
parameter WIDTH_B = 32;

parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

parameter DISPLAY_ERR_RAM_WR    = "ON";
parameter DISPLAY_ERR_RAM_RD    = "ON";
parameter ERR_RAM_WR_X  = "ON";

parameter DEPTH_R = (DEPTH_A >= DEPTH_B)? DEPTH_A : DEPTH_B;
parameter WIDTH_R = (WIDTH_A >= WIDTH_B)? WIDTH_A : WIDTH_B;

input                   clk0, clk1;
input [ADDRBIT_A-1:0]   a0;
input                   we0;
input [WIDTH_A-1:0]     di0;
input                   re0;
output [WIDTH_A-1:0]    do0;

input [ADDRBIT_B-1:0]   a1;
input                   we1;
input [WIDTH_B-1:0]     di1;
input                   re1;
output [WIDTH_B-1:0]    do1;

input                   mask;   // =1 -> re is disable
input                   test;   // rd and wr are disable

reg [WIDTH_R-1:0] ram [DEPTH_R-1:0];
reg [WIDTH_A-1:0] do0;
reg [WIDTH_B-1:0] do1;

integer i;
initial
    begin 
    for(i=0;i<DEPTH_R;i=i+1)
        ram[i] = {WIDTH_R{1'b0}};
    end

////////////////////////////////////////////////////////////////////////////////
// clk0
always @ (posedge clk0)
    begin

    //--write--
    if (we0 & (!test))
        begin
        //-------
        if ((a0 === a1) & we1)
            begin
            //do <= {WIDTH_R{1'bx}};  do not like altera model.

            `ifdef ERR_RAM_WR_X_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a0] <= {WIDTH_R{1'bx}};
            `endif

            
            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else           
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR0 and WR1 at the same address @clk0 at %h %t %m",a0,$time);
            `endif          


            end
        //-------
        else if ((a0 === a1) & re0)
            begin

            `ifdef ERR_RAM_WR_X_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a0] <= {WIDTH_R{1'bx}};
            `endif
            
            
            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR0 and RD0 at the same address @clk0 at %h %t %m",a0,$time);
            `endif              

            end
        //-------
        else if ((a0 === a1) & re1)
            begin

            `ifdef ERR_RAM_WR_X_WR_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a0] <= {WIDTH_R{1'bx}};
            `endif
            
            
            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR0 and RD1 at the same address @clk0 at %h %t %m",a0,$time);
            `endif              

            end
        //-------
        else    
            begin
            ram[a0] <= di0;
            end
        end

    //--read--
    if (test)   do0  <= {WIDTH_R{1'b0}};
    else if (re0 | mask)
        begin
        //-------
        if (we0 & (a0 === a1))
            begin


            `ifdef DISPLAY_ERR_RAM_RD_OFF
            `else
            if (DISPLAY_ERR_RAM_RD == "ON")
                $display ("ERR_RAM: RD0 and WR0 at the same time @clk0 at %h %t %m",a0,$time);
            `endif          


            do0 <= {WIDTH_R{1'bx}};
            end
        //-------
        else if (we1 & (a0 === a1))
            begin


            `ifdef DISPLAY_ERR_RAM_RD_OFF
            `else
            if (DISPLAY_ERR_RAM_RD == "ON")
                $display ("ERR_RAM: RD0 and WR1 at the same address @clk0 at %h %t %m",a0,$time);
            `endif          


            do0 <= {WIDTH_R{1'bx}};
            end
        //-------
        else    do0 <= ram[a0];
        end
    //-------
    else do0 <= {WIDTH_R{1'bx}};
    end


////////////////////////////////////////////////////////////////////////////////
// clk1
      
always @ (posedge clk1)
    begin
    //--write--
    if (we1 & (!test))
        begin
        //-------
        if ((a1 === a0) & we0)
            begin
            //do <= {WIDTH_R{1'bx}};  do not like altera model.

            `ifdef ERR_RAM_WR_X_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a1] <= {WIDTH_R{1'bx}};
            `endif          


            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR1 and WR0 at the same address @clk1 at %h %t %m",a1,$time);
            `endif          


            end
        //-------
        else if ((a1 === a0) & re1)
            begin

            `ifdef ERR_RAM_WR_X_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a1] <= {WIDTH_R{1'bx}};
            `endif
            
        
            `ifdef DISPLAY_ERR_RAM_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR1 and RD1 at the same address @clk1 at %h %t %m",a1,$time);
            `endif

            end
        //-------
        else if ((a1 == a0) & re0)
            begin

            `ifdef ERR_RAM_WR_X_OFF
            `else
            if (ERR_RAM_WR_X == "ON")
                ram[a1] <= {WIDTH_R{1'bx}};
            `endif
            
            
            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: WR1 and RD0 at the same address @clk1 at %h %t %m",a1,$time);
            `endif
            
            end
        //-------
        else
            begin
            ram[a1] <= di1;
            end
        end

    //--read--
    if (test)   do1  <= {WIDTH_R{1'b0}};
    else if (re1 | mask)
        begin
        //-------
        if (we1 & (a0 === a1))
            begin

            `ifdef DISPLAY_ERR_RAM_RD_OFF
            `else
            if (DISPLAY_ERR_RAM_RD == "ON")
                $display ("ERR_RAM: RD1 and WR0 at the same time @clk1 at %h %t %m",a1,$time);
            `endif          


            do1 <= {WIDTH_R{1'bx}};
            end
        //-------
        else if (we0 & (a0 === a1))
            begin


            `ifdef DISPLAY_ERR_RAM_RD_OFF
            `else
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display ("ERR_RAM: RD1 and WR0 at the same address @clk1 at %h %t %m",a1,$time);
            `endif          


            do1  <= {WIDTH_R{1'bx}};
            end
        //-------
        else    do1 <= ram[a1];
        end
    //-------
    else do1 <= {WIDTH_R{1'bx}};
    end

// for debug
wire    sameaddr_rw0;
wire    sameaddr_rw1;
wire    sameaddr_wr;
assign sameaddr_rw0     = (re0 | re1) & we0 & (a0 === a1);
assign sameaddr_rw1     = (re1 | re0) & we1 & (a0 === a1);
assign sameaddr_wr      = we0 & we1 & (a0 === a1);

endmodule

