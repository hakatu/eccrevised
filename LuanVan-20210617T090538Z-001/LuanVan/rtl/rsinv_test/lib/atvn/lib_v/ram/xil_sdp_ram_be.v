// apply for URAM only

module  xil_sdp_ram_be
    (
     clka   ,
     adra   ,
     wena   ,
     wdaa   ,
     bwea   ,
     clkb   ,
     adrb   ,
     renb   ,
     rdab
     );

parameter   ADRA= 11;
parameter   WIDA=  9;
parameter   DEPA= 18432;
parameter   ADRB= 11;
parameter   WIDB=  9;
parameter   DEPB= 18432;
parameter   TYPE= "ultra";//"auto", "distributed", "block" or "ultra"
parameter   INIT= "none";//"none" or "<filename>.mem"
parameter   MCLK= "common_clock";//"common_clock", "independent_clock"
parameter   MRWA= "read_first";//"write_first", "read_first", "no_change" 
parameter   MRWB= "read_first";//"write_first", "read_first", "no_change" 
parameter   NCLK= 2;//non-negative integer

`include "xil_xpm_param.vh"

input               clka;
input [ADRA-1:0]    adra;
input               wena;
input [WIDA-1:0]    wdaa;
input [WIDA/8-1:0]  bwea;

input               clkb;
input [ADRB-1:0]    adrb;
input               renb;
output [WIDB-1:0]   rdab;

// URAM288_BASE: 288K-bit High-Density Base Memory Building Block
// UltraScale
// Xilinx HDL Libraries Guide, version 2017.2
URAM288_BASE #(
               .AUTO_SLEEP_LATENCY(8), // Latency requirement to enter sleep mode
               .AVG_CONS_INACTIVE_CYCLES(10), // Average concecutive inactive cycles when is SLEEP mode for power
               // estimation    
               .BWE_MODE_A("PARITY_INDEPENDENT"), // Port A Byte write control
               .BWE_MODE_B("PARITY_INDEPENDENT"), // Port B Byte write control
               .EN_AUTO_SLEEP_MODE("FALSE"), // Enable to automatically enter sleep mode
               .EN_ECC_RD_A("FALSE"), // Port A ECC encoder
               .EN_ECC_RD_B("FALSE"), // Port B ECC encoder
               .EN_ECC_WR_A("FALSE"), // Port A ECC decoder
               .EN_ECC_WR_B("FALSE"), // Port B ECC decoder
               .IREG_PRE_A("FALSE"), // Optional Port A input pipeline registers
               .IREG_PRE_B("FALSE"), // Optional Port B input pipeline registers
               .IS_CLK_INVERTED(1'b0), // Optional inverter for CLK
               .IS_EN_A_INVERTED(1'b0), // Optional inverter for Port A enable
               .IS_EN_B_INVERTED(1'b0), // Optional inverter for Port B enable
               .IS_RDB_WR_A_INVERTED(1'b0), // Optional inverter for Port A read/write select
               .IS_RDB_WR_B_INVERTED(1'b0), // Optional inverter for Port B read/write select
               .IS_RST_A_INVERTED(1'b0), // Optional inverter for Port A reset
               .IS_RST_B_INVERTED(1'b0), // Optional inverter for Port B reset
               //.MATRIX_ID("NONE"),
               //.NUM_UNIQUE_SELF_ADDR_A(1),
               //.NUM_UNIQUE_SELF_ADDR_B(1),
               //.NUM_URAM_IN_MATRIX(1),
               .OREG_A("TRUE"), // Optional Port A output pipeline registers
               .OREG_B("TRUE"), // Optional Port B output pipeline registers
               .OREG_ECC_A("FALSE"), // Port A ECC decoder output
               .OREG_ECC_B("FALSE"), // Port B output ECC decoder
               .RST_MODE_A("SYNC"), // Port A reset mode
               .RST_MODE_B("SYNC"), // Port B reset mode
               .USE_EXT_CE_A("FALSE"), // Enable Port A external CE inputs for output registers
               .USE_EXT_CE_B("FALSE") // Enable Port B external CE inputs for output registers
               )
URAM288_BASE_inst (
                   .DBITERR_A(), // 1-bit output: Port A double-bit error flag status
                   .DBITERR_B(), // 1-bit output: Port B double-bit error flag status
                   .DOUT_A(), // 72-bit output: Port A read data output
                   .DOUT_B(rdab), // 72-bit output: Port B read data output
                   .SBITERR_A(SBITERR_A), // 1-bit output: Port A single-bit error flag status
                   .SBITERR_B(SBITERR_B), // 1-bit output: Port B single-bit error flag status
                   .ADDR_A(adra), // 23-bit input: Port A address
                   .ADDR_B(adrb), // 23-bit input: Port B address
                   .BWE_A(bwea), // 9-bit input: Port A Byte-write enable
                   .BWE_B(0), // 9-bit input: Port B Byte-write enable
                   .CLK(clka), // 1-bit input: Clock source
                   .DIN_A(wdaa), // 72-bit input: Port A write data input
                   .DIN_B(0), // 72-bit input: Port B write data input
                   .EN_A(wena), // 1-bit input: Port A enable
                   .EN_B(1), // 1-bit input: Port B enable
                   .INJECT_DBITERR_A(0), // 1-bit input: Port A double-bit error injection
                   .INJECT_DBITERR_B(0), // 1-bit input: Port B double-bit error injection
                   .INJECT_SBITERR_A(0), // 1-bit input: Port A single-bit error injection
                   .INJECT_SBITERR_B(0), // 1-bit input: Port B single-bit error injection
                   .OREG_CE_A(1), // 1-bit input: Port A output register clock enable
                   .OREG_CE_B(1), // 1-bit input: Port B output register clock enable
                   .OREG_ECC_CE_A(1), // 1-bit input: Port A ECC decoder output register clock enable
                   .OREG_ECC_CE_B(1), // 1-bit input: Port B ECC decoder output register clock enable
                   .RDB_WR_A(1), // 1-bit input: Port A read/write select
                   .RDB_WR_B(0), // 1-bit input: Port B read/write select
                   .RST_A(0), // 1-bit input: Port A asynchronous or synchronous reset for output
                   // registers
                   .RST_B(0), // 1-bit input: Port B asynchronous or synchronous reset for output
                   // registers
                   .SLEEP(0) // 1-bit input: Dynamic power gating control
                   );
// End of URAM288_BASE_inst instantiation
                
endmodule
