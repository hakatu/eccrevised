`timescale 1ns / 1ps
`define TEST
module tb_rsinv;

parameter WID = 256;
parameter AWID = 5;
parameter PERIOD = 10; //whatever period you want, it will be based on your timescale

reg clk=0;
reg rst=0;

always #PERIOD clk=~clk; //now you create your cyclic clock

wire [AWID-1:0] ramra;
wire [WID-1:0]  ramwd;
wire [AWID-1:0] ramwa;
wire            ramwe;

reg             acen_i;
reg             acen_r;
reg             acen_s;
wire            rsidone;

wire            aen;
wire [1:0]      aop;
reg [WID-1:0]   adi;
reg             adivld;

rsinv irsinv
    (
     .clk(clk),
     .rst(rst),

     .ramra(ramra), //to RAM to get a b to alu
     .ramwd(ramwd),//to write new value to ram
     .ramwa(ramwa),
     .ramwe(ramwe),
     
     //start operation //to ALU ctrl
     .acen_i(acen_i),//pulse
     .acen_r(acen_r),//pulse
     .acen_s(acen_s),//pulse
     .rsidone(rsidone), //pulse

     .aen(aen),//to ALU
     .aop(aop),//2 bit FA MUL INV
     .adi(adi),
     .adivld(adivld)
     );

initial begin
acen_i = 0;
acen_r = 0;
acen_s = 0;
adivld = 0;
adi = 0;
clk = 0;
rst = 0;
#10 rst = 1;
#20 rst = 0;
acen_i = 1;
#20 acen_i = 0;
#100.1 adivld = 1;
adi = 256'd3251231251234;
#20 adivld = 0;
adi = 256'd1;
#20 acen_s = 1;
#20 acen_s = 0;
#100.1 adivld = 1;
adi = 256'd3;
#20 adivld = 0;
#100.1 adivld = 1;
adi = 256'd4;
#20 adivld = 0;
#100.1 adivld = 1;
adi = 256'd6;
#20 adivld = 0;
#20 acen_r = 1;
#20 acen_r = 0;
#100.1 adivld = 1;
adi = 256'd7;
#20 adivld = 0;
#10000;
$finish;
end

initial begin
$shm_open ("my_waves");
$shm_probe (tb_rsinv,"AC");
$recordfile("testsample.trn");
$recordvars();
end

endmodule