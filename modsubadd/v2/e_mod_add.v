`timescale 1ns/10ps
module e_mod_add #(
   parameter WIDTH = 256
   )(
   input wire               clk,
   input wire               reset_n,
   input wire               start_add,
   input wire [1:0]         sel,                // 00: add, p = prime x25519, 01: add p = n order x25519 10:
   input wire [WIDTH -1 :0] nu_1,
   input wire [WIDTH -1 :0] nu_2,
   output reg [WIDTH -1 :0] add_nu,
   output reg               done_add
   );

   reg  [WIDTH -1:0] r1;
   reg  [WIDTH -1:0] r2;
   reg  [1:0]        sl;
   reg               sll;
   reg  [4:0]        count;
 
   wire [ WIDTH -1:0] e_add_nu_s1_2;
   wire [ WIDTH -1:0] result_1;
   wire [ WIDTH -1:0] result_2;
   wire [ WIDTH -1:0] r;
   wire               c1;
   wire               c2;
   reg  [ WIDTH -1:0] mux_nu_2;

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
          r1 <= 256'd0;
          r2 <= 256'd0;
          sl <= 'd0;
      end
      else begin
          if (start_add) begin
             r1 <= nu_1;
             r2 <= nu_2;
             sl <= sel;
          end
          else begin
             r1 <= r1;
             r2 <= r2;
             sl <= sl;
          end
      end
   end
   
   assign e_add_nu_s1_2 = sl[1]? ~r2 : r2;
   
   always @(*) begin
      case (sl)
         2'b00: begin
            mux_nu_2 = 256'd57896044618658097711785492504343953926634992332820282019728792003956564819987;   // add, 2^n -p
         end
         2'b01: begin
            mux_nu_2 = 256'd108555083659983933209597798445644913612412868306260656433455633069627675388947; // add, 2^n -n
         end
         2'b10: begin
            mux_nu_2 = 256'd57896044618658097711785492504343953926634992332820282019728792003956564819949; // sub, p
         end
         2'b11: begin
            mux_nu_2 = 256'd7237005577332262213973186563042994240857116359379907606001950938285454250989; // sub, order
         end
      endcase
   end
   
   e_ppn_add p_e_ppn_add_1 (
      .clk     (clk),
      .reset_n (reset_n),
      .a_i     (r1),
      .b_i     (e_add_nu_s1_2),
      .c_o     (c1),
      .s_o     (result_1)
      );
   
   e_ppn_add p_e_ppn_add_2 (
      .clk     (clk),
      .reset_n (reset_n),
      .a_i     (result_1),
      .b_i     (mux_nu_2),
      .c_o     (c2),
      .s_o     (result_2)
      );

   always @(*) begin
      if (sl[1]) begin
         sll = !c1;
      end
      else begin
         sll = c1 || c2;
      end
   end
   
   assign r = sll ? result_2 : result_1;
   
   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
         add_nu   <= 256'd0;
         done_add <= 'd0;
      end
      else begin
         if (count == 'd17) begin
            add_nu   <= r;
            done_add <= 1'b1;
         end
         else begin
            add_nu   <= add_nu;
            done_add <= 1'b0;
         end
      end
   end

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
         count <= 'd0;
      end
      else begin
         count <= start_add? count + 'd1: 'd0;
      end
   end

endmodule
