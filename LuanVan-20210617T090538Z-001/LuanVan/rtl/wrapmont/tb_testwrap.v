`timescale 1ns/1ps
module tb_testwrap;
`define TESTWRAPMONT
localparam          IDLE    = 2'b00;
localparam          INIT    = 2'b01;//init first xz
localparam          COMP    = 2'b10;//compute for
localparam          FINAL   = 2'b11;//final rslt calculation
reg clk;
reg t_rst;

always begin
clk = 0;
#1 clk=1;
#1;
end
//input reg/output wire
wire done;
reg  en;

testwrap itestwrap
    (
     .clk(clk),
     .rst(t_rst),
     .en(en),
     .done(done)
     );

//operation

initial begin
t_rst = 1'b0;
en = 1'b0;
#3 t_rst = 1'b1;
#2 t_rst = 1'b0;
en = 1'b1;
#2;
en = 1'b0;
#100;
wait(done);
#100;
$finish;
end
initial begin
$display ("==========OUTPUT==========");
end

initial begin
$monitor ("main status = %d",itestwrap.iauc_mmul.main);
$monitor ("comp cnt = %d at time = %t",itestwrap.iauc_mmul.iauc_mmul_comp.cnt,$time);
end

always@(posedge clk)
    begin
    if(itestwrap.iauc_mmul.mmul_we)
        begin
        $display ("==========write enable ==========");  
        $display ("at main state = %d",itestwrap.iauc_mmul.main);
        if(itestwrap.iauc_mmul.main == INIT)
            $display ("at init state = %d",  itestwrap.iauc_mmul.iauc_mmul_init.init_state);
        if(itestwrap.iauc_mmul.iauc_mmul_comp.comp_en)
            $display ("k after init = %h",itestwrap.ialram113x.ialram112x.mem[11]);
        else if(itestwrap.iauc_mmul.main == COMP)
            begin
            $display ("==========cnt %d ==========",itestwrap.iauc_mmul.iauc_mmul_comp.cnt);
            $display ("at comp state = %d",  itestwrap.iauc_mmul.iauc_mmul_comp.comp_state);
            end
        else if(itestwrap.iauc_mmul.main == FINAL)
            $display ("at final state = %d",itestwrap.iauc_mmul.iauc_mmul_final.final_state);
        $display ("write data is = %d",itestwrap.iauc_mmul.mmul_wd);
        $display ("write address is = %d",  itestwrap.iauc_mmul.mmul_wa);
        end
    
    end


always@(posedge clk) begin
if(done)
    begin
    $display ("done");
    $display ("final_result = %h",itestwrap.ialram113x.ialram112x.mem[15]);
    end
end

//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_testwrap,"ACM");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
