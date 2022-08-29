`timescale 1ns/1ps
module tb_aluwrap;

reg clk;
reg t_rst;

always begin
clk = 0;
#1 clk=1;
#1;
end
//input reg/output wire
reg [255:0] k;
reg [7:0]   t;

wire        kt;

test itest
    (
     .clk(clk),
     .k(k),
     .t(t),
     .kt(kt)
     );

//operation
always@(posedge clk)
    begin
    if(t_rst)
        t <= 0;
    else
        t <= t+1;
    end

initial begin
k = 256'd5;
#3 t_rst = 1'b1;
#2 t_rst = 1'b0;
#100;
$finish;
end

initial begin
$display ("==========OUTPUT==========");
end

initial begin
$monitor ("k_t = %d",kt);
end


//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_aluwrap,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
