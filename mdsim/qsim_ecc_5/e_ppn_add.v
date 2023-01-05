`timescale 1ns/10ps

module e_ppn_add (
   input wire          clk,
   input wire          reset,
   input wire  [255:0] a_i,
   input wire  [255:0] b_i,
   input wire          c_i,
   output reg          c_o,
   output reg  [255:0] s_o
   );

   wire    [255:0] pre_p;
   wire    [255:0] pre_g;
   wire    [255:0] p_s1;
   wire    [255:0] g_s1;
   wire    [255:0] p_s2;
   wire    [255:0] g_s2;
   wire    [255:0] p_s3;
   wire    [255:0] g_s3;
   wire    [255:0] p_s4;
   wire    [255:0] g_s4;
   wire    [255:0] p_s5;
   wire    [255:0] g_s5;
   wire    [255:0] p_s6;
   wire    [255:0] g_s6;
   wire    [255:0] p_s7;
   wire    [255:0] g_s7;
   wire    [255:0] p_s8;
   wire    [255:0] g_s8;
//   wire            non;
   wire    [255:0] cn;
   
   reg    [255:0] p_s1_r;
   reg    [255:0] g_s1_r;
   reg    [255:0] p_s2_r;
   reg    [255:0] g_s2_r;
   reg    [255:0] p_s3_r;
   reg    [255:0] g_s3_r;
   reg    [255:0] p_s4_r;
   reg    [255:0] g_s4_r;
   reg    [255:0] p_s5_r;
   reg    [255:0] g_s5_r;
   reg    [255:0] p_s6_r;
   reg    [255:0] g_s6_r;
   reg    [255:0] p_s7_r;
   reg    [255:0] g_s7_r;

   genvar i;

//******PREPROCESSING*****//
   assign pre_p = a_i ^ b_i;
   assign pre_g = a_i & b_i;
   
//*****STAGE 1*****//
   generate 
      for (i = 1; i <256; i = i+1) begin : block1
         e_ppn_add_cell phun_ppn_cell_s1_i (
	    .p      (pre_p[i]),
	    .g      (pre_g[i]),
	    .prev_p (pre_p[i-1]),
	    .prev_g (pre_g[i-1]),
	    .p_now  (p_s1[i]),
	    .g_now  (g_s1[i])
	  ); 
      end
   endgenerate

   assign p_s1[0] = pre_p[0];
   assign g_s1[0] = pre_g[0];

//****STAGE 2******//
   always @(posedge clk) begin
      if(reset) begin
         p_s1_r <= 256'd0;
         g_s1_r <= 256'd0;
      end
      else begin
         p_s1_r <= p_s1;
         g_s1_r <= g_s1;
      end
   end

   generate
      for (i = 2; i<256; i = i+1) begin : block2
         e_ppn_add_cell phun_ppn_cell_s2_i (
	    .p      (p_s1_r[i]),
	    .g      (g_s1_r[i]),
	    .prev_p (p_s1_r[i-2]),
	    .prev_g (g_s1_r[i-2]),
	    .p_now  (p_s2[i]),
	    .g_now  (g_s2[i])
	  ); 
      end
   endgenerate

   assign p_s2[1:0] = p_s1_r[1:0];
   assign g_s2[1:0] = g_s1_r[1:0];

//****STAGE 3******//

  always @(posedge clk) begin
     if(reset) begin
         p_s2_r <= 256'd0;
         g_s2_r <= 256'd0;
      end
      else begin
         p_s2_r <= p_s2;
         g_s2_r <= g_s2;
      end
   end
   generate
     for (i = 4; i<256; i = i+1) begin : block3
        e_ppn_add_cell phun_ppn_cell_s3_i (
           .p      (p_s2_r[i]),
           .g      (g_s2_r[i]),
           .prev_p (p_s2_r[i-4]),
           .prev_g (g_s2_r[i-4]),
           .p_now  (p_s3[i]),
           .g_now  (g_s3[i])
         ); 
      end
   endgenerate

  assign p_s3[3:0] = p_s2_r[3:0];
  assign g_s3[3:0] = g_s2_r[3:0];

//****STAGE 4******//
  always @(posedge clk) begin
     if(reset) begin
         p_s3_r <= 256'd0;
         g_s3_r <= 256'd0;
      end
      else begin
         p_s3_r <= p_s3;
         g_s3_r <= g_s3;
      end
   end
   generate
     for (i = 8; i<256; i = i+1) begin : block4
        e_ppn_add_cell phun_ppn_cell_s4_i (
           .p      (p_s3_r[i]),
           .g      (g_s3_r[i]),
           .prev_p (p_s3_r[i-8]),
           .prev_g (g_s3_r[i-8]),
           .p_now  (p_s4[i]),
           .g_now  (g_s4[i])
         ); 
      end
   endgenerate

  assign p_s4[7:0] = p_s3_r[7:0];
  assign g_s4[7:0] = g_s3_r[7:0];

//****STAGE 5******//

  always @(posedge clk) begin
     if(reset) begin
         p_s4_r <= 256'd0;
         g_s4_r <= 256'd0;
      end
      else begin
         p_s4_r <= p_s4;
         g_s4_r <= g_s4;
      end
   end
   generate
     for (i = 16; i<256; i = i+1) begin : block5
        e_ppn_add_cell phun_ppn_cell_s5_i (
           .p      (p_s4_r[i]),
           .g      (g_s4_r[i]),
           .prev_p (p_s4_r[i-16]),
           .prev_g (g_s4_r[i-16]),
           .p_now  (p_s5[i]),
           .g_now  (g_s5[i])
         ); 
      end
   endgenerate

  assign p_s5[15:0] = p_s4_r[15:0];
  assign g_s5[15:0] = g_s4_r[15:0];

//****STAGE 6******//

  always @(posedge clk) begin
     if(reset) begin
         p_s5_r <= 256'd0;
         g_s5_r <= 256'd0;
      end
      else begin
         p_s5_r <= p_s5;
         g_s5_r <= g_s5;
      end
   end
   generate
     for (i = 32; i<256; i = i+1) begin : block6
        e_ppn_add_cell phun_ppn_cell_s6_i (
           .p      (p_s5_r[i]),
           .g      (g_s5_r[i]),
           .prev_p (p_s5_r[i-32]),
           .prev_g (g_s5_r[i-32]),
           .p_now  (p_s6[i]),
           .g_now  (g_s6[i])
         ); 
      end
   endgenerate

  assign p_s6[31:0] = p_s5_r[31:0];
  assign g_s6[31:0] = g_s5_r[31:0];

//****STAGE 7******//

  always @(posedge clk) begin
     if(reset) begin
         p_s6_r <= 256'd0;
         g_s6_r <= 256'd0;
      end
      else begin
         p_s6_r <= p_s6;
         g_s6_r <= g_s6;
      end
   end
   generate
     for (i = 64; i<256; i = i+1) begin : block7
        e_ppn_add_cell phun_ppn_cell_s7_i (
           .p      (p_s6_r[i]),
           .g      (g_s6_r[i]),
           .prev_p (p_s6_r[i-64]),
           .prev_g (g_s6_r[i-64]),
           .p_now  (p_s7[i]),
           .g_now  (g_s7[i])
         ); 
      end
   endgenerate

  assign p_s7[63:0] = p_s6_r[63:0];
  assign g_s7[63:0] = g_s6_r[63:0];

//****STAGE 8******//

  always @(posedge clk) begin
     if(reset) begin
         p_s7_r <= 256'd0;
         g_s7_r <= 256'd0;
      end
      else begin
         p_s7_r <= p_s7;
         g_s7_r <= g_s7;
      end
   end
   generate
     for (i = 128; i<256; i = i+1) begin: block8
         e_ppn_add_cell phun_ppn_cell_s8 (
           .p      (p_s7_r[i]),
           .g      (g_s7_r[i]),
           .prev_p (p_s7_r[i-128]),
           .prev_g (g_s7_r[i-128]),
           .p_now  (p_s8[i]),
           .g_now  (g_s8[i])
         ); 
        //assign g_s8[i] = p_s7_r[i] & g_s7_r[i-128] | g_s7_r[i];
      end
   endgenerate

   assign p_s8[127:0] = p_s7_r[127:0];
   assign g_s8[127:0] = g_s7_r[127:0];
   //assign non         = (|p_s7_r[127:0]) | 1;
//FINAL CALCULATION//
   assign cn = (!c_i)? g_s8 : (g_s8 | p_s8);

  always @(posedge clk) begin
     if(reset) begin
        c_o <= 'd0;
        s_o <= 256'd0;
     end
     else begin
      // c_o <= g_s8[255];
      // s_o <= pre_p ^ ({g_s8[254:0],1'b0});
         c_o <= cn[255];
         s_o <= pre_p ^ ({cn[254:0],c_i});
     end
  end

endmodule

