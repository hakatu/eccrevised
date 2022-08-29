////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_dist_sdp_1clk.v
// Description  : Editing from Xilinx's code
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon May 18 01:15:41 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_dist_sdp_1clk
    (
     clk,
     rst,
     wen,
     wad,
     wda,
     ren,
     rad,
     rda
     
     );

parameter ADR = 11;
parameter DAT = 9;
parameter DEP = 2048;
parameter DEL = 1  ;
parameter INIT_FILE = "";

input [ADR-1:0]     wad;
input [ADR-1:0]     rad;
input [DAT-1:0]     wda;
input               clk;
input               wen;
input               ren;
input               rst;
output [DAT-1:0]    rda;

`ifndef USE_XILINX_RAM

wire            regceb = 1'b1;

(* ram_style="distributed" *)
reg [DAT-1:0]   ram_name [DEP-1:0];
reg [DAT-1:0]   ram_data = {DAT{1'b0}};

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

always @(posedge clk) 
    begin
    if (wen)
        ram_name[wad] <= wda;
    end

always @(posedge clk) 
    begin
    if (ren)
        ram_data <= ram_name[rad];
    end

reg [DAT-1:0] rda_reg = {DAT{1'b0}};
always @(posedge clk)
    if (rst)            rda_reg <= {DAT{1'b0}};
    else if (regceb)    rda_reg <= ram_data;
    
generate
if (DEL == 2)
    begin: output_register
    assign rda = rda_reg;
    end
    
else if (DEL == 1)
    begin: no_output_register
    assign rda = ram_data;
    end
else
    begin: no_clk
    assign rda = ram_name[rad];
    end

endgenerate
                        
`else
generate
    if(DEL==1)
        begin : sel_1clk
        
xil_dist_sdp_111x_1clk
    #(.ADR(ADR),
      .DAT(DAT)
      )             xil_dist_sdp_111x_1clk
    (
     .clk    (clk),
     .rst_   (rst),
     //
     .wen    (wen),
     .wad    (wad),
     .wda    (wda),
     
     .ren    (ren),
     .rad    (rad),
     .rda    (rda)
     
     );
        end
    else
        begin : sel_2clk
        xil_dist_sdp_112x_1clk
    #(.ADR(ADR),
      .DAT(DAT)
      )             xil_dist_sdp_112x_1clk
    (
     .clk    (clk),
     .rst_   (rst),
     //
     .wen    (wen),
     .wad    (wad),
     .wda    (wda),
     
     .ren    (ren),
     .rad    (rad),
     .rda    (rda)
     
     );
        end
endgenerate

`endif



endmodule 
