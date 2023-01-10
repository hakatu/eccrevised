module wrap_mod_inv (
   input wire          clk,
   input wire          reset_n,
   input wire          start_inv,
   input wire          serial_nu1,
   output wire [255:0] inv_nu,
   output wire         done_inv
   );

   wire [255:0] nu_1;
	
	rtldbgsipo1  #(.ODAT_B(256)) sipo1  
					  (
		.clk		  (clk),
 		.rst		  (reset_n),
		.idat		  (serial_nu1),
		.odat		  (nu_1),
		.iena		  (1'b1)
					  );


   e_mod_inv  u1 (
      .clk       (clk),
      .reset_n   (reset_n),
      .start_inv (start_inv),
      .nu_1      (nu_1),
      .inv_nu    (inv_nu),
      .done_inv  (done_inv)
				     );

endmodule