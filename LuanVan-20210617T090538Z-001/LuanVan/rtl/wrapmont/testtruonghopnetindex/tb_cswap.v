`timescale 1ns/1ps
module tb_cswap;

parameter WID = 256;

reg clk;
reg rst;

always begin
clk = 0;
#50 clk=1;
#50;
end
//input reg/output wire
reg [WID-1:0] swap;
reg [WID-1:0] a;
reg [WID-1:0] b;
reg           en;

wire [WID-1:0] aswap;
wire [WID-1:0] bswap;
wire           vld;

//instant


cswap icswap
    (
     .clk(clk),
     .rst(rst),

     .swap(swap),
     .a(a),
     .b(b),
     .en(en),

     .aswap(aswap),
     .bswap(bswap),
     .vld(vld)
     );

//operation

initial begin
rst = 1'b0;
a = 256'd11;
b = 256'd11579;
swap = 256'd500;
en = 1'b0;
#150 rst = 1'b1;
#100 rst = 1'b0;
#0.1 en = 1'b1;
#100;
en = 1'b0;
#5000;
a = 256'd11;
b = 256'd12;
en = 1'b1;
#100 en = 1'b0;
#70000;
a = 256'd115792089210356248762697446949407573530086143415290314195533631308867097853950;
en = 1'b1;
#100 en = 1'b0;
#70000
$finish;
end

initial begin
$display ("==========OUTPUT==========");
end

always@(posedge clk) begin
if(vld)
    begin
    $display ("Output : %d ", aswap);
    $display ("Output : %d ", bswap);
    end
end

//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_cswap,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
