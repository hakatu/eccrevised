`timescale 1ns/1ns
module tb_ex_sim;

//================================================

parameter           WIDTH   = 256;
parameter           ADDR    = 5;
parameter           WINDOW  = 4;
parameter           CBIT    = 8;
parameter           DEPTH   = 1<<ADDR;

//================================================

reg               clk;
reg               rst;

// IP core
reg [3*WIDTH-1:0] din;
reg [2:0]         mode; 
reg               start;
wire [WIDTH-1:0]  dout;
wire [1:0]        status;

reg [WIDTH-1:0]   test_num;

ecc_core
    #(
      .WIDTH(WIDTH),
      .ADDR(ADDR),
      .WINDOW(WINDOW),
      .CBIT(CBIT),
      .DEPTH(DEPTH)
      ) iecc_core
    (
     .clk(clk),
     .rst(rst),
     // IP core
     .din(din),       //3*WID
     .mode(mode),
     .start(start),
     .dout(dout),
     .status(status),
     // Simulation random number
     .test_num(test_num)
     );

wire              vld;
assign            vld = status[1] == 1'b1;


always begin
clk = 0;
#50 clk =1;
#50;
end

initial begin
/*
rst = 1'b0;
din[WIDTH-1:0] = 256'hA41A41A12A799548211C410C65D8133AFDE34D28BDD542E4B680CF2899C8A8C4;
din[2*WIDTH-1: WIDTH] = 256'hC477F9F65C22CCE20657FAA5B2D1D8122336F851A508A1ED04E479C34985BF96;
din[3*WIDTH-1: 2*WIDTH] = 0;
mode = 3'b000;  // ECDHE GEN
start = 1'b0;
test_num = 256'h7A1A7E52797FC8CAAA435D2A4DACE39158504BF204FBE19F14DBB427FAEE50AD;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 16;

#100 rst = 1'b1;
din[WIDTH-1:0] = 256'hA41A41A12A799548211C410C65D8133AFDE34D28BDD542E4B680CF2899C8A8C4;
din[2*WIDTH-1: WIDTH] = 256'hC477F9F65C22CCE20657FAA5B2D1D8122336F851A508A1ED04E479C34985BF96;
din[3*WIDTH-1: 2*WIDTH] = 0;
mode = 3'b000;  // ECDHE GEN
start = 1'b0;
test_num = 256'h7A1A7E52797FC8CAAA435D2A4DACE39158504BF204FBE19F14DBB427FAEE50AD;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 16;

#1000 rst = 1'b0;
din[WIDTH-1:0] = 256'hA41A41A12A799548211C410C65D8133AFDE34D28BDD542E4B680CF2899C8A8C4;
din[2*WIDTH-1: WIDTH] = 256'hC477F9F65C22CCE20657FAA5B2D1D8122336F851A508A1ED04E479C34985BF96;
din[3*WIDTH-1:2*WIDTH] = 0;
mode = 3'b1;  // ECDHE GEN
start = 1'b1;
test_num = 256'h7A1A7E52797FC8CAAA435D2A4DACE39158504BF204FBE19F14DBB427FAEE50AD;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 16;

#100 rst = 1'b0;
din[WIDTH-1:0] = 256'hA41A41A12A799548211C410C65D8133AFDE34D28BDD542E4B680CF2899C8A8C4;
din[2*WIDTH-1: WIDTH] = 256'hC477F9F65C22CCE20657FAA5B2D1D8122336F851A508A1ED04E479C34985BF96;
din[3*WIDTH-1:2*WIDTH] = 0;
mode = 3'b000;  // ECDHE GEN
start = 1'b0;
test_num = 256'h7A1A7E52797FC8CAAA435D2A4DACE39158504BF204FBE19F14DBB427FAEE50AD;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 16;

 */

//======================X25519===================================

rst = 1'b1;
din[WIDTH-1:0] = 256'he6db6867583030db3594c1a424b15f7c726624ec26b3353b10a903a6d0ab1c4c; // u cordinate
din[2*WIDTH-1: WIDTH] = 256'ha546e36bf0527c9d3b16154b82465edd62144c0ac1fc5a18506a2244ba449ac4; //scalar k
din[3*WIDTH-1: 2*WIDTH] = 0;
mode = 3'b110;  // ECDHE GEN
start = 1'b0;
test_num = 0;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 2;

#100 rst = 1'b0;
din[WIDTH-1:0] = 256'he6db6867583030db3594c1a424b15f7c726624ec26b3353b10a903a6d0ab1c4c;
din[2*WIDTH-1: WIDTH] = 256'ha546e36bf0527c9d3b16154b82465edd62144c0ac1fc5a18506a2244ba449ac4;
din[3*WIDTH-1: 2*WIDTH] = 0;
mode = 3'b110;  // ECDHE GEN
start = 1'b1;
test_num = 0;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 2;

#1000 rst = 1'b0;
din[WIDTH-1:0] = 256'h0900000000000000000000000000000000000000000000000000000000000000;
din[2*WIDTH-1: WIDTH] = 256'h0900000000000000000000000000000000000000000000000000000000000000;
din[3*WIDTH-1:2*WIDTH] = 0;
mode = 3'b101;  // ECDHE GEN
start = 1'b0;
test_num = 256'h0900000000000000000000000000000000000000000000000000000000000000 - 256'd1;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 2;

#100 rst = 1'b0;
din[WIDTH-1:0] = 256'h0900000000000000000000000000000000000000000000000000000000000000;
din[2*WIDTH-1: WIDTH] = 256'h0900000000000000000000000000000000000000000000000000000000000000;
din[3*WIDTH-1:2*WIDTH] = 0;
mode = 3'b101;  // ECDHE GEN
start = 1'b0;
test_num = 256'h0900000000000000000000000000000000000000000000000000000000000000 - 256'd1;
//test_num = 256'd28948025760307534517734791687894775804466072615242963443097661355606862201086;
//test_num = 2;


wait(vld);

#50000;
$finish;
end

initial begin
//$monitor ("wmul_main_state = %d", iecc_core.iauc_wrap.iauc_wmul.iauc_wmul_main.main_step);
$monitor ("mmul_cnt_state = %d", iecc_core.iauc_wrap.iauc_mmul.iauc_mmul_comp.cnt);
end
          
always @(posedge clk)
    begin
    if (status == 2'b10)
        $display (" Output: %h", dout);
    end


//dump wave
initial begin
$shm_open ("my_waves");
$shm_probe (tb_ex_sim,"ACM");
$recordfile("testsample.trn");
$recordvars();
end


endmodule
