`timescale 1ns/10ps

`define TC1

module tb();
  reg clk;
  reg reset_n;
  reg [1:0] sel;
  reg       start_add;
  reg [255:0] nu_1;
  reg [255:0] nu_2;
  wire done_add;
  wire [255:0] add_nu;
  
  reg [255:0] in1    [0:99];
  reg [255:0] in2    [0:99];
  reg [255:0] outadd [0:99];
  reg [255:0] outsub [0:99];
  reg [255:0] result1 [0:99];
  
  integer i;
  e_mod_add u1 (
    .clk(clk),
    .reset_n(reset_n),
    .sel(sel),
    .start_add(start_add),
    .nu_1(nu_1),
    .nu_2(nu_2),
    .add_nu(add_nu),
    .done_add(done_add)
  );
  
   initial begin
     #0 clk = 0;
     forever #5 clk = ~clk;
   end

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end 
  
   initial begin
      $readmemh("D:/Paper/ECC Revised/modsubadd/v2/in1.txt",in1);
      $readmemh("D:/Paper/ECC Revised/modsubadd/v2/in2.txt",in2);
      $readmemh("D:/Paper/ECC Revised/modsubadd/v2/out_add.txt",outadd);
      $readmemh("D:/Paper/ECC Revised/modsubadd/v2/out_sub.txt",outsub);
   end

`ifdef TC1   
  always @(*) begin
    if(done_add)
	    result1[i] = add_nu;
      if (result1[i] != outsub[i]) begin
        $display("expect: %p result: %p   WRONG ", outsub, add_nu);
	      $display("\n");
      end
  end 

  initial begin
    #0
    reset_n = 0;
    start_add = 0;
    #5
    reset_n = 1;
    #10
    sel = 2'b10;
    for (i = 0;i<100 ;i=i+1 ) begin
      start_add = 1;
      nu_1 = in1[i];
      nu_2 = in2[i];
      #200
      start_add = 0;
      #10;
    end
    $writememh("D:/Paper/ECC Revised/modsubadd/v2/result_sub.txt",result1);
    $display("Da ghi file ket qua phep tru\n");
    $finish;
  end
  
`else
    always @(*) begin
    if(done_add)
	    result1[i] = add_nu;
      if (result1[i] != outadd[i]) begin
        $display("expect: %p result: %p   WRONG ", outadd, add_nu);
	      $display("\n");
      end
    
    end 
    initial begin
    #0
    reset_n = 0;
    start_add = 0;
    #5
    reset_n = 1;
    #10
    sel = 2'b00;
    for (i = 0;i<100 ;i=i+1 ) begin
      start_add = 1;
      nu_1 = in1[i];
      nu_2 = in2[i];
      #200
      start_add = 0;
      #10;
    end
    $writememh("D:/Paper/ECC Revised/modsubadd/v2/result_add.txt",result1);
    $display("Da ghi file ket qua phep cong\n");
    $finish;
  end
`endif
endmodule


