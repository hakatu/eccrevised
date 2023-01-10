`timescale 1ns/10ps

module e_mod_inv #(parameter WIDTH = 256)
   (
   input wire               clk,
   input wire               reset_n,
   input wire               start_inv,
   input wire [WIDTH - 1:0] nu_1,

   output wire               done_inv,
//   output reg               inv_err,
   output wire [WIDTH - 1:0] inv_nu
   );

   ////////////////////////////
   //INTERNAL WIRES DECLARATION
   
   reg [WIDTH - 1:0] nu_in;
   reg               start;

   reg [WIDTH - 1:0] u;
   reg [WIDTH - 1:0] v;
   reg [WIDTH - 1:0] r;
   reg [WIDTH - 1:0] s;
   
   wire [WIDTH - 1:0] u_cal;
   wire [WIDTH - 1:0] v_cal;
   wire [WIDTH - 1:0] r_cal;
   wire [WIDTH - 1:0] s_cal;
   
   reg                sign_u;
   reg                sign_v;
   reg                sign_r;
   reg                sign_s;

   wire               done_denta_uv;
   wire               done_denta_rs;
   wire               done_sigma;
   wire               lsb_denta_rs;

   wire               sign_u_cal;
   wire               sign_v_cal;
   wire               sign_r_cal;
   wire               sign_s_cal;

   wire [1:0]         sel_u;
   wire [1:0]         sel_v;
   wire [2:0]         sel_r;
   wire [1:0]         sel_s;
   wire [1:0]         sel_denta_uv;
   wire [1:0]         sel_denta_rs;
   wire [1:0]         sel_sigma;

   wire               start_denta_uv;
   wire               start_denta_rs;
   wire               start_sigma;

   reg  [WIDTH - 1:0] nu1_denta_uv;
   reg  [WIDTH - 1:0] nu2_denta_uv;
   wire [WIDTH - 1:0] denta_uv;
   reg                sign_nu1_denta_uv;
   reg                sign_nu2_denta_uv;
   wire               c_denta_uv;
   wire               sign_denta_uv;
   
   reg  [WIDTH - 1:0] nu1_denta_rs;
   reg  [WIDTH - 1:0] nu2_denta_rs;
   wire [WIDTH - 1:0] denta_rs;
   reg                sign_nu1_denta_rs;
   reg                sign_nu2_denta_rs;
   wire               c_denta_rs;
   wire               sign_denta_rs;
   
   
   reg  [WIDTH - 1:0] nu1_sigma;
   reg  [WIDTH - 1:0] nu2_sigma;
   wire [WIDTH - 1:0] sigma;
   reg                sign_nu1_sigma;
   reg                sign_nu2_sigma;
   wire               c_sigma;
   wire               sign_sigma;

   wire               overflow;
   wire [WIDTH - 1:0] PRIME    = 256'd115792089237316195423570985008687907853269984665640564039457584007908834671663;

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
         start  <= 'b0;
         nu_in  <= 'd0;
      end
      else begin
         start  <= start_inv;
         nu_in  <= nu_1;
      end
   end

   e_mod_inv_control inv_ctrl (
      .clk             (clk),
      .reset_n         (reset_n),
      .u               (u),
      .v               (v),
      .r               (r),
      .s               (s),
      .nu1             (nu_in),
      .sign_u          (sign_u),
      .sign_v          (sign_v),
      .sign_r          (sign_r),
      .sign_s          (sign_s),
      .start_inv       (start),
      .done_denta_uv   (done_denta_uv),
      .done_denta_rs   (done_denta_rs),
      .done_sigma      (done_sigma),
      
      .u_cal           (u_cal),
      .v_cal           (v_cal),
      .r_cal           (r_cal),
      .s_cal           (s_cal),
      .sign_u_cal      (sign_u_cal),
      .sign_v_cal      (sign_v_cal),
      .sign_r_cal      (sign_r_cal),
      .sign_s_cal      (sign_s_cal),
      
      .sel_u           (sel_u),
      .sel_v           (sel_v),
      .sel_r           (sel_r),
      .sel_s           (sel_s),
      .sel_denta_uv    (sel_denta_uv),
      .sel_denta_rs    (sel_denta_rs),
      .sel_sigma       (sel_sigma),
      .lsb_denta_rs    (lsb_denta_rs),
      .start_denta_uv  (start_denta_uv),
      .start_denta_rs  (start_denta_rs),
      .start_sigma     (start_sigma),
      
      .done_inv        (done_inv),
      .inv_nu          (inv_nu),

      .sign_denta_rs   (sign_denta_rs),
      .c_denta_rs      (c_denta_rs),
      .overflow        (overflow)
   );
   
   assign lsb_denta_rs = denta_rs[0];

   always @(posedge clk or negedge reset_n) begin   // choose u
      if(!reset_n) begin
         {sign_u,u} <= 'd0;
      end
      else begin
         case (sel_u)
            'd0: begin
               {sign_u,u} <= {sign_u_cal,u_cal};
            end
            'd1: begin
               {sign_u,u} <= {sign_u_cal,{1'b0,u_cal[255:1]}};
            end
            'd2: begin
               {sign_u,u} <= {sign_denta_uv,{c_denta_uv,denta_uv[255:1]}};
            end
            default: begin
               {sign_u,u} <= {sign_u,u};
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin   // choose v
      if(!reset_n) begin
        {sign_v,v} <= 'd0;
      end
      else begin
         case (sel_v)
            'd0: begin
               {sign_v,v} <= {sign_v_cal,v_cal};
            end
            'd1: begin
               {sign_v,v} <= {sign_v_cal,{1'b0,v_cal[255:1]}};
            end
            'd2: begin
               {sign_v,v} <= {sign_denta_uv,{c_denta_uv,denta_uv[255:1]}};
            end
            default: begin
               {sign_v,v} <= {sign_v,v};
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin   // choose r
      if(!reset_n) begin
         {sign_r,r} <= 'd0;
      end
      else begin
         case (sel_r)
            'd0: begin
               {sign_r,r} <= {sign_r_cal,r_cal};
            end
            'd1: begin
               {sign_r,r} <= {sign_r_cal,{1'b0,r_cal[255:1]}};
            end
            'd2: begin
               {sign_r,r} <= {sign_sigma,{c_sigma,sigma[255:1]}};
            end
            'd3: begin
               {sign_r,r} <= {sign_denta_rs,{c_denta_rs,denta_rs[255:1]}};
            end
            'd4: begin
               {sign_r,r} <= {sign_sigma,sigma};
            end
            'd5: begin
               {sign_r,r} <= {sign_denta_rs,denta_rs};
            end
            default: begin
               {sign_r,r} <= {sign_r,r};
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin   // choose s
      if(!reset_n) begin
         {sign_s,s} <= 'd0;
      end
      else begin
         case (sel_s)
            'd0: begin
               {sign_s,s} <= {sign_s_cal,s_cal};
            end
            'd1: begin
               {sign_s,s} <= {sign_s_cal,{sign_s_cal,s_cal[255:1]}};
            end
            'd2: begin
               {sign_s,s} <= {sign_sigma,{c_sigma,sigma[255:1]}};
            end
            'd3: begin
               {sign_s,s} <= {sign_denta_rs,{c_denta_rs,denta_rs[255:1]}};
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin                            //sel denta_uv
         {sign_nu1_denta_uv,nu1_denta_uv} <= 'd0;
         {sign_nu2_denta_uv,nu2_denta_uv} <= 'd0;
      end
      else begin
         case (sel_denta_uv)
            'd0: begin
                {sign_nu1_denta_uv,nu1_denta_uv} <= {sign_u_cal,u_cal};
                {sign_nu2_denta_uv,nu2_denta_uv} <= {sign_v_cal,v_cal};
            end
            'd3: begin
                {sign_nu1_denta_uv,nu1_denta_uv} <= {sign_v_cal,v_cal};
                {sign_nu2_denta_uv,nu2_denta_uv} <= {sign_u_cal,u_cal};
            end
            default: begin
                {sign_nu1_denta_uv,nu1_denta_uv} <= {sign_nu1_denta_uv,nu1_denta_uv} ;
                {sign_nu2_denta_uv,nu2_denta_uv} <= {sign_nu2_denta_uv,nu2_denta_uv} ;
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin                                //sel_denta_rs
         {sign_nu1_denta_rs,nu1_denta_rs} <= 'd0;
         {sign_nu2_denta_rs,nu2_denta_rs} <= 'd0;
      end
      else begin
         case (sel_denta_rs)
            'd0: begin
                {sign_nu1_denta_rs,nu1_denta_rs} <= {sign_r_cal,r_cal};
                {sign_nu2_denta_rs,nu2_denta_rs} <= {sign_s_cal,s_cal};
            end
            'd2: begin
                {sign_nu1_denta_rs,nu1_denta_rs} <= {sign_r_cal,r_cal};
                {sign_nu2_denta_rs,nu2_denta_rs} <= {1'b0,PRIME};
            end
            'd3: begin
                {sign_nu1_denta_rs,nu1_denta_rs} <= {sign_s_cal,s_cal};
                {sign_nu2_denta_rs,nu2_denta_rs} <= {sign_r_cal,r_cal};
            end
            default: begin
                {sign_nu1_denta_rs,nu1_denta_rs} <= {sign_nu1_denta_rs,nu1_denta_rs};
                {sign_nu2_denta_rs,nu2_denta_rs} <= {sign_nu2_denta_rs,nu2_denta_rs};
            end
         endcase
      end
   end

   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin                            //sel_sigma
         {sign_nu1_sigma,nu1_sigma} <= 'd0;
         {sign_nu2_sigma,nu2_sigma} <= 'd0;
      end
      else begin
         case (sel_sigma)
            'd0: begin
                {sign_nu2_sigma,nu2_sigma} <= {sign_r_cal,r_cal};
                {sign_nu1_sigma,nu1_sigma} <= {1'b0,PRIME};
            end
            'd1: begin
                {sign_nu2_sigma,nu2_sigma} <= {sign_s_cal,s_cal};
                {sign_nu1_sigma,nu1_sigma} <= {1'b0,PRIME};
            end
            'd2: begin
                {sign_nu2_sigma,nu2_sigma} <= {sign_denta_rs,denta_rs};
                {sign_nu1_sigma,nu1_sigma} <= {1'b0,PRIME};
            end
            'd3: begin
                {sign_nu2_sigma,nu2_sigma} <= {sign_denta_rs,denta_rs};
                {sign_nu1_sigma,nu1_sigma} <= {sign_s_cal,s_cal};
            end
         endcase
      end
   end

   e_ppn_wrap_add_sub u_denta_uv (
      .clk            (clk),
      .reset_n        (reset_n),
      .start_cal      (start_denta_uv),
      .sel            (1'b1),
      .a_i            (nu1_denta_uv),
      .b_i            (nu2_denta_uv),
      .sign_a         (sign_nu1_denta_uv),
      .sign_b         (sign_nu2_denta_uv),
      .data_o         (denta_uv),
      .c_o            (c_denta_uv),
      .sign_o         (sign_denta_uv),
      .done_o         (done_denta_uv),

      .overflow       (1'b0)
   );
   
   e_ppn_wrap_add_sub u_denta_rs(
      .clk            (clk),
      .reset_n        (reset_n),
      .start_cal      (start_denta_rs),
      .sel            (1'b1),
      .a_i            (nu1_denta_rs),
      .b_i            (nu2_denta_rs),
      .sign_a         (sign_nu1_denta_rs),
      .sign_b         (sign_nu2_denta_rs),
      .data_o         (denta_rs),
      .c_o            (c_denta_rs),
      .sign_o         (sign_denta_rs),
      .done_o         (done_denta_rs),

      .overflow       (1'b0)
   );

   e_ppn_wrap_add_sub u_sigma(
      .clk            (clk),
      .reset_n        (reset_n),
      .start_cal      (start_sigma),
      .sel            (1'b0),
      .a_i            (nu1_sigma),
      .b_i            (nu2_sigma),
      .sign_a         (sign_nu1_sigma),
      .sign_b         (sign_nu2_sigma),
      .data_o         (sigma),
      .c_o            (c_sigma),
      .sign_o         (sign_sigma),
      .done_o         (done_sigma),
      .overflow       (overflow)
   );

endmodule


