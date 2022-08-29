////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_sdp_2clk.v
// Description  : Editing from Xilinx's code
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon May 18 01:42:59 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_sdp_2clk
    (
     wclk,
     wen ,
     wad ,
     wda ,
     rclk,
     rrst,
     ren ,
     rad ,
     rda 
     );

parameter ADR = 8;
parameter DAT = 9;
parameter DEP = 256;
parameter DEL = 1  ;
parameter INIT_FILE = "";

input [ADR-1:0]     wad ;
input [ADR-1:0]     rad ;
input [DAT-1:0]     wda ;
input               wclk;
input               rclk;
input               wen ;
input               ren ;
input               rrst;
output [DAT-1:0]    rda ;


wire                regceb = 1'b1;

(* ram_style="block" *) 
reg [DAT-1:0]       ram_name [DEP-1:0];
reg [DAT-1:0]       ram_data = {DAT{1'b0}};

generate
if (INIT_FILE != "")
    begin: use_init_file
    initial
        $readmemh(INIT_FILE, ram_name, 0, DEP-1);
    end 
else
    begin: init_bram_to_zero
    integer ram_index;
    initial
        for (ram_index = 0; ram_index < DEP; ram_index = ram_index + 1)
            ram_name[ram_index] = {DAT{1'b0}};
    end
endgenerate

always @(posedge wclk)
    if (wen)    ram_name[wad] <= wda; 

always @(posedge rclk)
    begin
    if (ren)    ram_data <= ram_name[rad];
    end

generate
if (DEL == 1) 
    begin: no_output_register
    assign rda = ram_data;
    end 
else
    begin: output_register
    reg [DAT-1:0] rda_reg = {DAT{1'b0}};
    always @(posedge rclk)
        if (rrst)           rda_reg <= {DAT{1'b0}};
        else if (regceb)    rda_reg <= ram_data;
    assign                  rda = rda_reg;
    end
endgenerate


endmodule 
