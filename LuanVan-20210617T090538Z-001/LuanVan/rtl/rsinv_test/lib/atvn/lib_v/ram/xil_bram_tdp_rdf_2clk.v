////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : xil_bram_tdp_rdf_2clk.v
// Description  : Editing from Xilinx's code
//
// Author       : cuongbht@HW-BHTCUONG
// Author Slogan: try not to become a man of success,
//              : but rather, try to become a man of value
// Created On   : Mon May 18 02:13:26 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module xil_bram_tdp_rdf_2clk
    (
     clka,
     rsta,
     adra,
     wena,
     wdaa,
     rena,
     rdaa,
     
     clkb,
     rstb,
     adrb,
     wenb,
     wdab,
     renb,
     rdab
     
     );

parameter ADR = 8;
parameter DAT = 9;
parameter DEP = 256;
parameter DEL = 1  ;
parameter INIT_FILE = "";

input [ADR-1:0]     adra;
input [ADR-1:0]     adrb;
input [DAT-1:0]     wdaa;
input [DAT-1:0]     wdab;
input               clka;
input               clkb;
input               wena;
input               wenb;
input               rena;
input               renb;
input               rsta;
input               rstb;
output [DAT-1:0]    rdaa;
output [DAT-1:0]    rdab;


wire                regcea = 1'b1;
wire                regceb = 1'b1;

(* ram_style="block" *) 
reg [DAT-1:0]       ram_name [DEP-1:0];
reg [DAT-1:0]       ram_data_a = {DAT{1'b0}};
reg [DAT-1:0]       ram_data_b = {DAT{1'b0}};

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

always @(posedge clka)
    if (rena) 
        begin
        if (wena)
            ram_name[adra] <= wdaa;
        ram_data_a <= ram_name[adra];
        end

always @(posedge clkb)
    if (renb) 
        begin
        if (wenb)
            ram_name[adrb] <= wdab;
        ram_data_b <= ram_name[adrb];
        end

generate
if (DEL == 1)
    begin: no_output_register
    assign rdaa = ram_data_a;
    assign rdab = ram_data_b;
    end 
else
    begin: output_register
    reg [DAT-1:0] douta_reg = {DAT{1'b0}};
    reg [DAT-1:0] doutb_reg = {DAT{1'b0}};
    
    always @(posedge clka)
        if (rsta)
            douta_reg <= {DAT{1'b0}};
        else if (regcea)
            douta_reg <= ram_data_a;

    always @(posedge clkb)
        if (rstb)
            doutb_reg <= {DAT{1'b0}};
        else if (regceb)
            doutb_reg <= ram_data_b;
    
    assign        rdaa = douta_reg;
    assign        rdab = doutb_reg;
    end
endgenerate


        
endmodule 
