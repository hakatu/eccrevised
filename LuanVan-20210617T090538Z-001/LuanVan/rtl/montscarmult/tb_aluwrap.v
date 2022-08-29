`timescale 1ns/1ps
module tb_aluwrap;

reg clk;
reg t_rst;

always begin
clk = 0;
#1 clk=1;
#1;
end

parameter OPWID = 4;
parameter WID = 256;
parameter AWID = 5;

//input reg/output wire
// wire
reg     mmul_en;//controller

//from ALU
wire [WID-1:0] mmul_audat;
wire           mmul_auvld;

// Output
wire          mmul_done;//done

//to ALU
wire [OPWID-1:0] mmul_opcode;
wire             mmul_auen;
wire             mmul_carry;//for sub
wire             mmul_swapop;
wire             mmul_swapvl;

// RAM control
wire [AWID-1:0]  mmul_ra;
wire [AWID-1:0]  mmul_wa;
wire             mmul_we;
wire [WID-1:0]   mmul_wd;

//
auc_mmul iauc_mmul
    (
     .clk(clk),
     .rst(rst),
     
     // Wire
     .mmul_en(mmul_en),//controller

     //from ALU
     .mmul_auvld(mmul_auvld),
     .mmul_audat(mmul_audat),
     .mmul_aurswap(mmul_aurswap),
     // Output
     .mmul_done(mmul_done),//done

     //to ALU
     .mmul_opcode(mmul_opcode),
     .mmul_auen(mmul_auen),
     .mmul_carry(mmul_carry),
     .mmul_swapvl(mmul_swapvl),
     .mmul_swapop(mmul_swapop),
     
     // RAM control
     .mmul_ra(mmul_ra),
     .mmul_wa(mmul_wa),
     .mmul_we(mmul_we),
     .mmul_wd(mmul_wd)
     );


initial begin
#3 t_rst = 1'b1;
#2 t_rst = 1'b0;
mmul_en = 1'b0;
#10000 mmul_en = 1'b1;
#10000;
#100;
$finish;
end

initial begin
$display ("==========OUTPUT==========");
end



//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_aluwrap,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
