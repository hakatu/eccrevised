/*******************************************************************************
Creator:        Phu Nguyen Truong Thanh

Additional Contributions by:
            1.  Name
            2.  Name

File Name:      e_mod_inv_control.v
Design Name:    e_mod_inv_control
Project Name:   Constant time montgomery Inversion
Description:    Controller for the modular inversion follow the BEEA method.

Changelog:      2022.11.28 - <short changelog>
                             <long changelog>

*******************************************************************************/

/*******************************************************************************

Copyright (c) 2022 Phu Nguyen Truong Thanh

*******************************************************************************/


// !! use spaces, not tabs, and one indent = 2 spaces
`timescale 1ns/10ps
module e_mod_inv_control #(
   parameter WIDTH = 256
) (
  // Global
  input                     clk,
  input                     reset,
  
  // Input
  input wire [WIDTH - 1:0]  u,
  input wire [WIDTH - 1:0]  v,
  input wire [WIDTH - 1:0]  r,
  input wire [WIDTH - 1:0]  s,
  input wire [WIDTH - 1:0]  nu1,

  input wire                sign_u,
  input wire                sign_v,
  input wire                sign_r,
  input wire                sign_s,
  input wire                start_inv,
  
  input wire                done_denta_uv,
  input wire                done_denta_rs,
  input wire                done_sigma,
  input wire                c_denta_rs,
  input wire                sign_denta_rs,

  input wire                lsb_denta_rs,
  // Output
  output reg [WIDTH - 1:0]  u_cal,
  output reg [WIDTH - 1:0]  v_cal,
  output reg [WIDTH - 1:0]  r_cal,
  output reg [WIDTH - 1:0]  s_cal,

  output reg                sign_u_cal,
  output reg                sign_v_cal,
  output reg                sign_r_cal,
  output reg                sign_s_cal,
  
  output reg [1:0]          sel_u,
  output reg [1:0]          sel_v,
  output reg [2:0]          sel_r,
  output reg [1:0]          sel_s,
  output reg [1:0]          sel_denta_uv,
  output reg [1:0]          sel_denta_rs,
  output reg [1:0]          sel_sigma,
  output reg                start_denta_uv,
  output reg                start_denta_rs,
  output reg                start_sigma,

  output reg                done_inv,
  output reg [WIDTH - 1:0]  inv_nu,
  output reg                overflow
);

  // local declarations

  parameter [14:0] IDLE        = 0;
  parameter [14:0] LOAD        = 14;
  parameter [14:0] CHECK       = 12;
  parameter [14:0] P1_CHECK    = 1;
  parameter [14:0] P2          = 2;
  parameter [14:0] P3          = 3;
  parameter [14:0] P4          = 4;
  parameter [14:0] P5          = 5;
  parameter [14:0] P6          = 6;
  parameter [14:0] P7          = 7;
  parameter [14:0] P8          = 8;
  parameter [14:0] STORE       = 9;
  parameter [14:0] CALSIGMA    = 10;
  parameter [14:0] CALRS       = 11;
  parameter [14:0] DONE        = 13;


  wire [WIDTH - 1:0] PRIME    = 256'd115792089237316195423570985008687907853269984665640564039457584007908834671663;
  wire [WIDTH - 1:0] ADJUST_M = 256'd4294968273; 
  reg [13:0] state;
  reg [13:0] n_state;
  reg [13:0] pre_state;

  reg [10:0]  pi0;

  reg         lsb_s;
  reg         lsb_r;
  // Instantiations

  // Conbinational Logic

  always @(*) begin
     case(state)
        IDLE: begin
           n_state = start_inv ? LOAD : IDLE;
        end
        LOAD: begin
           n_state = CHECK;
        end
        CHECK: begin
           n_state = pi0 < 'd512 ? P1_CHECK : DONE;
        end
        P1_CHECK: begin
           if(v > 256'd0) begin
              if(u[0] == 'b0) begin
                 n_state = P2;
              end
              else begin
                 if(v[0] == 'b0) begin
                    n_state = P3;
                 end
                 else begin
                    if(u > v) begin
                       n_state = P4;
                    end
                    else begin
                       n_state = P5;
                    end
                 end
              end
           end 
           else begin
              if(sign_r == 1'b1) begin
                 n_state = P6;
              end
              else begin
                 if(r > PRIME) begin
                    n_state = P7;
                 end
                 else begin
                    n_state = P8;
                 end
              end
           end
        end
        P2: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P2;
           end
        end
        P3: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P3;
           end
        end
        P4: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P4;
           end
        end
        P5: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P5;
           end
        end
        P6: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P6;
           end
        end
        P7: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P7;
           end
        end
        P8: begin
           if(done_denta_uv && done_denta_rs) begin
              n_state = CALSIGMA;
           end
           else begin
              n_state = P8;
           end
        end
        CALSIGMA: begin
           n_state = done_sigma ? CALRS : CALSIGMA;
        end
        CALRS: begin
           n_state = STORE;
        end
        STORE: begin
           n_state = CHECK;
        end
        DONE: begin
           n_state = IDLE;
        end
        default: begin
           n_state = IDLE;
        end
     endcase
  end

  // State Register

  always @(posedge clk) begin
     if(reset) begin
        state <= IDLE;
     end
     else begin
        state <= n_state;
     end
  end

  // Output Logic
  always @(posedge clk) begin
     if(reset) begin
        pi0            <= 'd0;
        sign_u_cal     <= 'd0;
        sign_v_cal     <= 'd0;
        sign_r_cal     <= 'd0;
        sign_s_cal     <= 'd0;
        u_cal          <= 'd0;
        v_cal          <= 'd0;
        r_cal          <= 'd0;
        s_cal          <= 'd0;
        sel_u          <= 'd0;
        sel_v          <= 'd0;
        sel_r          <= 'd0;
        sel_s          <= 'd0;
        start_denta_uv <= 'd0;
        start_denta_rs <= 'd0;
        start_sigma    <= 'd0;
        done_inv       <= 'd0;
        inv_nu         <= 'd0;
        pre_state      <= IDLE;
        lsb_s          <= 'd0;
        lsb_r          <= 'd0;
        overflow       <= 'b0;
     end
     else begin
        case(state)
           IDLE: begin
              pi0                <= 'd0;
              sign_u_cal         <= 'd0;
              sign_v_cal         <= 'd0;
              sign_r_cal         <= 'd0;
              sign_s_cal         <= 'd0;
              u_cal              <= 256'd0;
              v_cal              <= 256'd0;
              r_cal              <= 256'd0;
              s_cal              <= 256'd0;
              sel_u              <= 'd0;
              sel_v              <= 'd0;
              sel_r              <= 'd0;
              sel_s              <= 'd0;
              start_denta_uv     <= 'd0;
              start_denta_rs     <= 'd0;
              start_sigma        <= 'd0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 'd0;
              sel_denta_rs       <= 'd0;
              sel_sigma          <= 'd0;
              pre_state          <= IDLE;
              lsb_s              <= 'd0;
              lsb_r              <= 'd0;
              overflow           <= 'b0;
           end
           LOAD: begin
              pi0                <= pi0;
              {sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              {sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              {sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              {sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              sel_u              <= 'd0;
              sel_v              <= 'd0;
              sel_r              <= 'd0;  
              sel_s              <= 'd0;
              start_denta_uv     <= 'd0;
              start_denta_rs     <= 'd0;
              start_sigma        <= 'd0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 'd0;
              sel_denta_rs       <= 'd0;
              sel_sigma          <= 'd0;
              pre_state          <= pre_state;
              lsb_s              <= 'd0;
              lsb_r              <= 'd0;
              overflow           <= 'b0;
           end
           CHECK: begin
              pi0                <= pi0;
              //sign_u_cal       <= 'd0;
              //sign_v_cal       <= 'd0;
              //sign_r_cal       <= 'd0;
              //sign_s_cal       <= 'd0;
              //u_cal            <= 256'd0;
              //v_cal            <= 256'd0;
              //r_cal            <= 256'd0;
              //s_cal            <= 256'd0;
              {sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              {sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              {sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              {sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //{sign_v_cal,v_cal} <= {sign_v,v}; 
              //{sign_u_cal,u_cal} <= {sign_u,u};
              //{sign_r_cal,r_cal} <= {sign_r,r};
              //{sign_s_cal,s_cal} <= {sign_s,s};
              //sel_u              <= 'd0;
              //sel_v              <= 'd0;
              //sel_r              <= 'd0;  
              //sel_s              <= 'd0;
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'd0;
              start_denta_rs     <= 'd0;
              start_sigma        <= 'd0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 'd0;
              sel_denta_rs       <= 'd0;
              sel_sigma          <= 'd0;
              pre_state          <= pre_state;
              lsb_s              <= (pi0 == 'd0) ? ADJUST_M[0] : s[0];
              lsb_r              <= r[0];
              overflow           <= 'b0;
           end
           P1_CHECK: begin
              pi0                <= pi0;
              //sign_u_cal       <= sign_u_cal;
              //sign_v_cal       <= sign_v_cal;
              //sign_r_cal       <= sign_r_cal;
              //sign_s_cal       <= sign_s_cal; 
              //u_cal            <= u_cal;
              //v_cal            <= v_cal;
              //r_cal            <= r_cal;
              //s_cal            <= s_cal;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'd0;
              start_denta_rs     <= 'd0;
              start_sigma        <= 'd0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= sel_denta_uv;
              sel_denta_rs       <= sel_denta_rs;
              sel_sigma          <= 'd0;
              pre_state          <= pre_state;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P2: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //sel_u              <= 2'b01;   // u/2 
              //sel_v              <= 'd0;
              //sel_r              <= r[0] ? 3'b010 : 3'b001;          // r/2 or sigma/2
              //sel_s              <= 'd0;       // 0: u,v,s giu nguyen
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00;
              sel_denta_rs       <= 2'b00;
              sel_sigma          <= 2'b00;
              pre_state          <= P2;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P3: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //sel_u              <= 'd0;
              //sel_v              <= 2'b01;     //v/2
              //sel_r              <= 'd0;          
              //sel_s              <= s[0] ? 2'b10 : 2'b01;   // sigma/2 or s/2   
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;    
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00;
              sel_denta_rs       <= 2'b00;
              sel_sigma          <= 2'b01;   // s + p
              pre_state          <= P3;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P4: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //sel_u              <= 2'b10;   //dentauv/2
              //sel_v              <= 'd0;     //v/2
              //sel_r              <= (done_denta_rs && lsb_denta_rs) ? 'd2 : 'd3;           //sigma /2 or denta_rs /2
              //sel_s              <= 'd0;   // sigma/2 or s/2    
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};   
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00;
              sel_denta_rs       <= 2'b00;
              sel_sigma          <= 2'b10;   // dentars + p
              pre_state          <= P4;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P5: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //sel_u              <= 2'b10;   //dentauv/2
              //sel_v              <= 'd0;     //v/2
              //sel_r              <= (done_denta_rs && lsb_denta_rs) ? 'd2 : 'd3;           //sigma /2 or denta_rs /2
              //sel_s              <= 'd0;   // sigma/2 or s/2   
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;    
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b11;    // v-u . r- s
              sel_denta_rs       <= 2'b11;
              sel_sigma          <= 2'b10;   // dentars + p
              pre_state          <= P5;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P6: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              //sel_u              <= 2'b10;   //dentauv/2
              //sel_v              <= 'd0;     //v
              //sel_r              <= 'd4;    //sigma
              //sel_s              <= 'd1;   //` s/2    
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;   
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00;
              sel_denta_rs       <= 2'b11;
              sel_sigma          <= 2'b00;   //rp
              pre_state          <= P6;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P7: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              
              //sel_u              <= 2'b10;   //dentauv/2
              //sel_v              <= 'd0;     //v
              //sel_r              <= 'd5;    //denta_rs
              //sel_s              <= 'd1;   //` s/2       
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00; //uv
              sel_denta_rs       <= 2'b10; //rp
              sel_sigma          <= 2'b11;   //dentars s
              pre_state          <= P7;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           P8: begin
              pi0                <= pi0;
              //{sign_v_cal,v_cal} <= (pi0 == 'd0) ? {1'b0,nu1}      : {sign_v,v} ; // ban dau, input dc dua ra tinh
              //{sign_u_cal,u_cal} <= (pi0 == 'd0) ? {1'b0,PRIME}    : {sign_u,u};
              //{sign_r_cal,r_cal} <= (pi0 == 'd0) ? 257'd0          : {sign_r,r};
              //{sign_s_cal,s_cal} <= (pi0 == 'd0) ? {1'b0,ADJUST_M} : {sign_s,s};
              {sign_v_cal,v_cal} <= {sign_v_cal,v_cal}; 
              {sign_u_cal,u_cal} <= {sign_u_cal,u_cal};
              {sign_r_cal,r_cal} <= {sign_r_cal,r_cal};
              {sign_s_cal,s_cal} <= {sign_s_cal,s_cal};
              //sel_u              <= 2'b10;   //dentauv/2
              //sel_v              <= 'd0;     //v
              //sel_r              <= 'd5;    //denta_rs
              //sel_s              <= 'd1;   // s/2       
              sel_u              <= sel_u;
              sel_v              <= sel_v;
              sel_r              <= sel_r;
              sel_s              <= sel_s;
              start_denta_uv     <= 'b1;
              start_denta_rs     <= 'b1;
              start_sigma        <= (done_denta_uv && done_denta_rs) ? 1'b1 : 1'b0;
              done_inv           <= 'd0;
              inv_nu             <= 256'd0;
              sel_denta_uv       <= 2'b00; //uv
              sel_denta_rs       <= 2'b00; //rs
              sel_sigma          <= 2'b11;   //dentars s
              pre_state          <= P8;
              lsb_s              <= lsb_s;
              lsb_r              <= lsb_r;
              overflow           <= 'b0;
           end
           CALSIGMA: begin
              pi0              <= pi0;
              sign_u_cal       <= sign_u_cal;
              sign_v_cal       <= sign_v_cal;
              sign_r_cal       <= sign_r_cal;
              sign_s_cal       <= sign_s_cal;
              u_cal            <= u_cal;
              v_cal            <= v_cal;
              r_cal            <= r_cal;
              s_cal            <= s_cal;
              sel_u            <= sel_u;
              sel_v            <= sel_v;
              sel_r            <= sel_r;
              sel_s            <= sel_s;
              start_denta_uv   <= 'd0;
              start_denta_rs   <= 'd0;
              start_sigma      <= 'd1;
              done_inv         <= 'd0;
              inv_nu           <= 256'd0;
              sel_denta_uv     <= sel_denta_uv;
              sel_denta_rs     <= sel_denta_rs;
              sel_sigma        <= sel_sigma;
              pre_state        <= pre_state;
              lsb_s            <= lsb_s;
              lsb_r            <= lsb_r;
              if(pre_state == P5 ) begin
                 overflow <= c_denta_rs ^ sign_denta_rs; //denta_rs <0 and abs(denta_rs) < p
              end
              else begin
                 overflow <= 'd0;
              end
           end
           CALRS: begin
              pi0              <= pi0;
              sign_u_cal       <= sign_u_cal;
              sign_v_cal       <= sign_v_cal;
              sign_r_cal       <= sign_r_cal;
              sign_s_cal       <= sign_s_cal;
              u_cal            <= u_cal;
              v_cal            <= v_cal;
              r_cal            <= r_cal;
              s_cal            <= s_cal;
              //sel_u            <= sel_u;
              //sel_v            <= sel_v;
              //sel_r            <= sel_r;
              //sel_s            <= sel_s;
              case(pre_state)
                 P2: begin
                    sel_u              <= 2'b01;   // u/2 
                    sel_v              <= 'd0;
                    sel_r              <= lsb_r ? 3'b010 : 3'b001;          // r/2 or sigma/2
                    sel_s              <= 'd0;       // 0: u,v,s giu nguyen
                 end
                 P3: begin
                    sel_u              <= 'd0;
                    sel_v              <= 2'b01;     //v/2
                    sel_r              <= 'd0;          
                    sel_s              <= lsb_s ? 2'b10 : 2'b01;   // sigma/2 or s/2  
                 end
                 P4: begin
                    sel_u              <= 2'b10;   //dentauv/2
                    sel_v              <= 'd0;     //v/2
                    sel_r              <= lsb_denta_rs ? 'd2 : 'd3;           //sigma /2 or denta_rs /2
                    sel_s              <= 'd0;   // sigma/2 or s/2   
                 end
                 P5: begin
                    sel_v              <= 2'b10;   //dentauv/2
                    sel_u              <= 'd0;     //u
                    sel_s              <= lsb_denta_rs ? 'd2 : 'd3;           //sigma /2 or denta_rs /2
                    sel_r              <= 'd0;   // sigma/2 or s/2   
                 end
                 P6: begin
                    sel_u              <= 2'b10;   //dentauv/2
                    sel_v              <= 'd0;     //v
                    sel_r              <= 'd4;    //sigma
                    sel_s              <= 'd1;   //` s/2   
                 end
                 P7: begin
                    sel_u              <= 2'b10;   //dentauv/2
                    sel_v              <= 'd0;     //v
                    sel_r              <= 'd5;    //denta_rs
                    sel_s              <= 'd1;   //` s/2   
                 end
                 P8: begin
                    sel_u              <= 2'b10;   //dentauv/2
                    sel_v              <= 'd0;     //v
                    sel_r              <= 'd5;    //denta_rs
                    sel_s              <= 'd1;   // s/2  
                 end
                 default: begin
                    //sel_u              <= 'd0;
                    //sel_v              <= 'd0;
                    //sel_r              <= 'd0;
                    //sel_s              <= 'd0;
                    sel_u              <= sel_u;
                    sel_v              <= sel_v;
                    sel_r              <= sel_r;
                    sel_s              <= sel_s;
                    
                 end
              endcase
              start_denta_uv   <= 'd0;
              start_denta_rs   <= 'd0;
              start_sigma      <= 'd0;
              done_inv         <= 'd0;
              inv_nu           <= 256'd0;
              sel_denta_uv     <= sel_denta_uv;
              sel_denta_rs     <= sel_denta_rs;
              sel_sigma        <= sel_sigma;
              pre_state        <= pre_state;
              lsb_s            <= lsb_s;
              lsb_r            <= lsb_r;
              overflow         <= overflow;
           end
           STORE: begin
              pi0              <= pi0 + 'd1;
              sign_u_cal       <= sign_u_cal;
              sign_v_cal       <= sign_v_cal;
              sign_r_cal       <= sign_r_cal;
              sign_s_cal       <= sign_s_cal;
              u_cal            <= u_cal;
              v_cal            <= v_cal;
              r_cal            <= r_cal;
              s_cal            <= s_cal;
              sel_u            <= sel_u;
              sel_v            <= sel_v;
              sel_r            <= sel_r;
              sel_s            <= sel_s;
              
              start_denta_uv   <= 'd0;
              start_denta_rs   <= 'd0;
              start_sigma      <= 'd0;
              done_inv         <= 'd0;
              inv_nu           <= 256'd0;
              sel_denta_uv     <= sel_denta_uv;
              sel_denta_rs     <= sel_denta_rs;
              sel_sigma        <= sel_sigma;
              pre_state        <= IDLE;
              lsb_s            <= lsb_s;
              lsb_r            <= lsb_r;
              overflow         <= overflow;
           end
           DONE: begin
              pi0              <= 'd0;
              sign_u_cal       <= sign_u_cal;
              sign_v_cal       <= sign_v_cal;
              sign_r_cal       <= sign_r_cal;
              sign_s_cal       <= sign_s_cal;
              u_cal            <= u_cal;
              v_cal            <= v_cal;
              r_cal            <= r_cal;
              s_cal            <= s_cal;
              sel_u            <= sel_u;
              sel_v            <= sel_v;
              sel_r            <= sel_r;
              sel_s            <= sel_s;
              start_denta_uv   <= 'd0;
              start_denta_rs   <= 'd0;
              start_sigma      <= 'd0;
              done_inv         <= 'd1;
              inv_nu           <= r;
              sel_denta_uv     <= sel_denta_uv;
              sel_denta_rs     <= sel_denta_rs;
              sel_sigma        <= sel_sigma;
              pre_state        <= IDLE;
              lsb_s            <= lsb_s;
              lsb_r            <= lsb_r;
              overflow         <= overflow;
           end
           default: begin
              pi0              <= 'd0;
              sign_u_cal       <= 'd0;
              sign_v_cal       <= 'd0;
              sign_r_cal       <= 'd0;
              sign_s_cal       <= 'd0;
              u_cal            <= 256'd0;
              v_cal            <= 256'd0;
              r_cal            <= 256'd0;
              s_cal            <= 256'd0;
              sel_u            <= 'd0;
              sel_v            <= 'd0;
              sel_r            <= 'd0;
              sel_s            <= 'd0;
              start_denta_uv   <= 'd0;
              start_denta_rs   <= 'd0;
              start_sigma      <= 'd0;
              done_inv         <= 'd0;
              inv_nu           <= 256'd0;
              sel_denta_uv     <= 'd0;
              sel_denta_rs     <= 'd0;
              sel_sigma        <= 'd0;
              pre_state        <= IDLE;
              lsb_s            <= lsb_s;
              lsb_r            <= lsb_r;
              overflow         <= overflow;
           end
        endcase
     end
  end
endmodule
