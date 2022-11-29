module wrap_mod_add (
   input wire          clk,
   input wire          reset_n,
   input wire  [1:0]   sel,
   input wire          start_add,
   input wire        nu_1,
   input wire        nu_2,
   output wire          add_nu,
   output wire         done_add
   );

   parameter WIDTH = 256;

  //always@(posedge clk or negedge reset_n) begin 
  //   if(!reset_n) begin
  //      nu_2 <= 256'd0;
  //   end
  //   else begin
  //      nu_2 <= nu_i;
  //   end   
  // end
 
   //assign nu_1 = nu_i;

   wire [WIDTH-1:0] nu_1rg,nu_2rg,add_nurg;

   rtldbgsipo1//add1
    #(WIDTH,1)
    irtldbgsipo1
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(nu_1),
         .odat(nu_1rg)
         );

   rtldbgsipo1//add2
    #(WIDTH,1)
    irtldbgsipo2
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(nu_2),
         .odat(nu_2rg)
         );

   rtldbgsipo1//test_num
    #(1,WIDTH)
    irtldbgsipo3
        (
         .clk(clk),
         .rst(rst),
         .iena(1'b1),
         .idat(add_nurg),
         .odat(add_nu)
         );

   e_mod_add  ie_mod_add (
      .clk       (clk),
      .reset_n   (reset_n),
      .sel       (sel),
      .start_add (start_add),
      .nu_1      (nu_1rg),
      .nu_2      (nu_2rg),
      .add_nu    (add_nurg),
      .done_add  (done_add)
   );

endmodule
