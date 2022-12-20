`timescale 1ns/10ps
module e_ppn_add_cell (
   input wire  p,
   input wire  g,
   input wire  prev_p,
   input wire  prev_g,
   output wire p_now,
   output wire g_now
   );

   assign g_now = (p & prev_g) | g;
   assign p_now = p & prev_p;
endmodule
