//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : iramrwpx.v
// Description     : a library of read write port RAM model with dual clocks
//
// Author          : ducdd@atvn.com.vn
// Created On      : Wed Jun 18 16:38:23 2002
// History (Date, Changed By)
//      Tue Jun 25 14:37:55 2002
//      Wed Sep 07 15:31:33 2005, ddduc
//          modified from ramrwpx
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
// +turn off write X and write real value to RAM when collision at write side
//      ERR_RAM_WR_X_OFF_AND_WR_REAL = "ON" 


module iramrwpx
    (
     wclk,
     wa,
     we,
     di,
     
     rclk,
     ra,
     re,
     do,
     
     test,
     mask
     );

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter DISPLAY_ERR_RAM_WR = "ON";
parameter DISPLAY_ERR_RAM_RD = "ON";
parameter ERR_RAM_WR_X  = "ON";
parameter ERR_RAM_RD_X  = "ON";
parameter ERR_RAM_WR_REAL = "OFF";

input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
input               re;
output [WIDTH-1:0]  do;
input               mask;   // =1 -> re is disable
input               test;   // wr and rd are disable

reg [WIDTH-1:0] ram [DEPTH-1:0];
reg [WIDTH-1:0] do;

integer i;
initial begin for(i=0;i<DEPTH;i=i+1) ram[i] = {WIDTH{1'b0}}; end

always @ (posedge wclk)
    begin
    if (we & (!test))
        begin
        if (re & (wa === ra))
            begin

            `ifdef ERR_RAM_WR_X_OFF
            `else
            // FPGA can write a value to RAM during same address of write and read
            // added by Duc Do, Sat Apr 23 10:28:48 2011
            if (ERR_RAM_WR_REAL == "ON")
                ram[wa] <= di;
            // end of modification
            
            else if (ERR_RAM_WR_X == "ON")
                ram[wa] <= {WIDTH{1'bx}};
            
            `endif          

            
            `ifdef DISPLAY_ERR_RAM_WR_OFF
            `else           
            if (DISPLAY_ERR_RAM_WR == "ON")
                $display("ERR_RAM: WR and RD at the same address @wclk at %h %t %m",ra,$time);
            `endif      
            
            end
        else
            begin
            ram[wa] <= di;
            end
        end
         
    end

always @ (posedge rclk)
    begin
    if (test)   do <= {WIDTH{1'b0}};
    else if (re | mask)
        begin
        if (we & (wa === ra))
            begin

            `ifdef ERR_RAM_RD_X_OFF
            do <= {WIDTH{1'b0}};
            `else
            if (ERR_RAM_RD_X == "ON")
                do <= {WIDTH{1'bx}};
            else
                do <= {WIDTH{1'b0}};
            `endif          

            
            `ifdef DISPLAY_ERR_RAM_RD_OFF
            `else
            if (DISPLAY_ERR_RAM_RD == "ON")
                $display("ERR_RAM: RD and WR at the same address @rclk at %h %t %m",ra,$time);
            `endif      

            
            end
        else
            begin
            do  <= ram[ra];
            end
        end
    else    do  <= {WIDTH{1'bx}};
    end

// for debug            
wire    sameaddr;
assign sameaddr = re & we & (wa === ra);

endmodule

