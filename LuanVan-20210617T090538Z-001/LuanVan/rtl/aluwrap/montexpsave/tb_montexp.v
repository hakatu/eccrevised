`timescale 1ns/1ps
module tb_montexp;

parameter WID = 256;

reg clk;
reg t_rst;
`define X255
`ifdef X255
parameter EXPK  = 256'd38;
parameter EXP2K = 256'd1444;
parameter MECC = 256'd57896044618658097711785492504343953926634992332820282019728792003956564819949;
`endif
always begin
clk = 0;
#50 clk=1;
#50;
end
//input reg/output wire

reg [WID-1:0] a;
reg [WID-1:0] b;
reg         en;

wire [WID-1:0] r;
wire           vld;

wire [WID-1:0] mpa1;
wire [WID-1:0] mpb1;
wire [WID-1:0] mpr1;

wire           mpstart1;
wire           mpvld1;

wire [WID-1:0] mpa2;
wire [WID-1:0] mpb2;
wire [WID-1:0] mpr2;

wire           mpstart2;
wire           mpvld2;
//instant

montexp imontexp
    (
     .clk(clk),
     .rst(t_rst),
     
     .a(a),//input a
     .b(b),//input b
     .expk(EXPK),//exp 
     .exp2k(EXP2K),//exp
     .r(r),//output result
     
     .start(en), //enable
     .vld(vld),

     //interface to montprowrap 1
     .mpa1(mpa1),//input a
     .mpb1(mpb1),//input b
     .mpr1(mpr1),//output result
     
     .mpstart1(mpstart1), //enable
     .mpvld1(mpvld1),

     //interface to montprowrap 2
     .mpa2(mpa2),//input a
     .mpb2(mpb2),//input b
     .mpr2(mpr2),//output result
     
     .mpstart2(mpstart2), //enable
     .mpvld2(mpvld2)
     );

montprowrap imontprowrap1
    (
     .clk(clk),
     .rst(t_rst),
     
     .a(mpa1),//input a
     .b(mpb1),//input b
     .m(MECC),//input m
     .r(mpr1),//output result
     
     .start(mpstart1), //enable
     .vld(mpvld1)
     );

montprowrap imontprowrap2
    (
     .clk(clk),
     .rst(t_rst),
     
     .a(mpa2),//input a
     .b(mpb2),//input b
     .m(MECC),//input m
     .r(mpr2),//output result
     
     .start(mpstart2), //enable
     .vld(mpvld2)
     );

//operation

initial begin
t_rst = 1'b0;
a = 256'd103;
b = 256'd141;
en = 1'b0;
#10000;
#150 t_rst = 1'b1;
#100 t_rst = 1'b0;
#10000;
en = 1'b1;
#100;
en = 1'b0;
wait(vld);
#70000;
$finish;
end

initial begin
$display ("==========OUTPUT==========");
end

always@(posedge clk) begin
if(vld)
    begin
    $display ("Output : %d ", r);
    end
end

initial begin
$monitor("cnt = %d", imontexp.cnt);
end


//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_montexp,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
