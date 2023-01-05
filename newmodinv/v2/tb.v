`timescale 1ns/10ps

`define TC2 1

module tb();
  reg          clk;
  reg          reset_n;
  reg          start_inv;
  reg [255:0]  nu_1;
  wire         done_inv;
  wire [255:0] inv_nu;
  
  reg [255:0]  in1    [0:99];
  reg [255:0]  in2    [0:99];
  reg [255:0]  outadd [0:99];
  reg [255:0]  outsub [0:99];
  reg [255:0]  result1 [0:99];
  
  integer i;
  e_mod_inv u1 (
    .clk      (clk),
    .reset_n  (reset_n),
    .start_inv(start_inv),
    .nu_1     (nu_1),
    .inv_nu   (inv_nu),
    .done_inv (done_inv)
  );
  
   initial begin
     #0 clk = 0;
     forever #5 clk = ~clk;
   end

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end 
  
//   initial begin
//      $readmemh("./testcase/in1.txt",in1);
//      $readmemh("./testcase/in2.txt",in2);
//      $readmemh("./testcase/out_add.txt",outadd);
//      $readmemh("./testcase/out_sub.txt",outsub);
//   end

`ifdef TC1   
  always @(*) begin
    if(done_inv)
	    result1[i] = add_nu;
      if (result1[i] != outsub[i]) begin
        $display("expect: %d result: %d   WRONG ", outsub, add_nu);
	      $display("\n");
      end
  end 

  initial begin
    #0
    reset_n = 0;
    start_inv = 0;
    #5
    reset_n = 1;
    #10
    sel = 2'b10;
    for (i = 0;i<100 ;i=i+1 ) begin
      start_inv = 1;
      nu_1 = in1[i];
      nu_2 = in2[i];
      #200
      start_inv = 0;
      #10;
    end
    $writememh("C:/Users/admin/Desktop/src/testcase/result_sub.txt",result1);
    $finish;
  end
`elsif TC2
   
    initial begin
    #0
    reset_n = 0;
    start_inv = 0;
    #5
    reset_n = 1;
    #10
      start_inv = 1;
      nu_1 = 256'd629412624769526213110496182826568357633;
      //nu_1 = 256'd62941262476952621311049618282709840972312778529470478506507476;
      nu_1 = 256'd32916636844272;
    end

    always @(*) begin
       if(done_inv) begin
          $display("final_value = %d",inv_nu);
          $finish;
       end
       else begin
          #50;
       end
    end
`else
    always @(*) begin
    if(done_inv)
	    result1[i] = add_nu;
      if (result1[i] != outadd[i]) begin
        $display("%d WRONG ", i);
	     $display("\n");
      end    
    end 
    initial begin
    #0
    reset_n = 0;
    start_inv = 0;
    #5
    reset_n = 1;
    #10
    sel = 2'b00;
    for (i = 0;i<100 ;i=i+1 ) begin
      start_inv = 1;
      nu_1 = in1[i];
      nu_2 = in2[i];
      #200
      start_inv = 0;
      #10;
    end
    $writememh("./testcase/result_add.txt",result1);
    $finish;
  end
`endif
endmodule


