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

wire [1:0] t_status;

reg [255:0] a;
reg [255:0] b;
reg         c;

reg         en;
reg [3:0]   opcode;

wire [255:0] r;
wire [255:0] rswap;
wire         vld;

reg          swapop;
//instant


aluwrap ialuwrap
    (
     .clk(clk),
     .rst(t_rst),

     .status(t_status),//00 01 10 11 idle computing done error

     .a(a),//INV only input
     .b(b),
     .c(c), //cin for FA
     .en(en),//start ops
     .swapop(swapop), //priority for swapoperation
     .swapvl(1'b1), //swap value
     .opcode(opcode), //00 01 10 fa mul inv (opted 11 to inv too)

     .r(r),//result
     .rswap(rswap),
     .vld(vld)
     );

//operation

initial begin
opcode[3] = 0;
opcode[2] = 0;
t_rst = 1'b0;
a = 256'd11;
b = 256'd1;
c = 1'b1;//sub
en = 1'b0;
opcode[1:0] = 2'b00;//fa
#3 t_rst = 1'b1;
#2 t_rst = 1'b0;
en = 1'b1;
#2;
en = 1'b0;
#100;
a = 256'd11;
b = 256'd12;
c = 1'b0;
opcode[1:0] = 2'b01;//mul
en = 1'b1;
#2 en = 1'b0;
wait(vld);
#200;
opcode[1:0] = 2'b10; //inv
a = 256'd4568979;
en = 1'b1;
#10 en = 1'b0;
#1000;
opcode[2] = 1;//X255
a = 256'd103;
b = 256'd141;
c = 1'b0;
opcode[1:0] = 2'b11;//exp
//en = 1'b1;
#2;
en = 1'b0;
//wait(vld);
#1000;
a = 256'd1045645;
b = 256'd1412;
swapop = 1;//swap
en = 1'b1;
#2 en = 1'b0;
wait(vld);
#1000;
a = 256'd11;
b = 256'd1;
c = 1'b1;//sub
en = 1'b0;
opcode[1:0] = 2'b00;//fa
swapop = 1'b0;
en = 1'b1;
#2;
en = 1'b0;
#100;
c = 1'b0;
a = 256'h55df5d5850f47bad82149139979369fe498a9022a412b5e0bedd2cfc21c3ed91;
b = 256'h6B17D1F2E12C4247F8BCE6E563A440F277037D812DEB33A0F4A13945D898C296;
c = 1'b0;
opcode[1:0] = 2'b01;//mul
en = 1'b1;
#2 en = 1'b0;
wait(vld);
#200;
#100;
$finish;
end

initial begin
$display ("==========OUTPUT==========");
end

initial begin
$monitor ("exp cnt = %d",ialuwrap.imontexp.cnt);
end

always@(posedge clk) begin
if(vld)
    begin
    $display ("Output : %d ", r);
    $display ("Output : %d ", rswap);
    end
end

//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_aluwrap,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule
