/*******************************************************************************
Creator:        Phu Nguyen Truong Thanh

Additional Contributions by:
            1.  Name
            2.  Name

File Name:      e_ppn_wrap_add_sub.v
Design Name:    e_ppn_wrap_add_sub
Project Name:   ecdsa
Description:    KSA add sub, 256bit, no modular
                <long description>

Changelog:      2022.12.03- <short changelog>
                             <long changelog>

*******************************************************************************/

/*******************************************************************************

Copyright (c) 2022 Phu Nguyen Truong Thanh

*******************************************************************************/


// !! use spaces, not tabs, and one indent = 2 spaces
`timescale 1ns/10ps
module e_ppn_wrap_add_sub #(
   parameter WIDTH = 256
) (
  // Global
  input wire               clk,
  input wire               reset_n,
  input wire               start_cal,
  input wire               sel,
  input wire [WIDTH - 1:0] a_i,
  input wire [WIDTH - 1:0] b_i,
  input wire               sign_a,
  input wire               sign_b,
  input wire               overflow,

  output reg [WIDTH - 1:0] data_o,
  output reg               c_o,
  output reg               done_o,
  output reg               sign_o
);

//////////////////////////////
//PARAMETER DECLARATIONS

  parameter [1:0] IDLE = 0;
  parameter [1:0] CAL  = 1;
  parameter [1:0] DONE = 2;

/////////////////////////////
//INTERNAL WIRES

  reg [1:0] state;
  reg [1:0] n_state;

  reg [WIDTH - 1:0] nu1;
  reg [WIDTH - 1:0] nu2;
  reg [WIDTH - 1:0] in_a;
  reg [WIDTH - 1:0] in_b;
  reg               sl;
  reg               tmp;
  reg               tmp1;
  wire              start;
  reg [3:0]         count;
  wire              c_1;
  wire              comp;
  wire[WIDTH - 1:0] data;
  wire[WIDTH - 1:0] nu2_in_add_sub;

  always @(posedge clk or negedge reset_n) begin
     if(!reset_n) begin
        nu1   <= 'd0;
        nu2   <= 'd0;
        sl    <= 'd0;
        tmp   <= 'd0;
     end
     else begin
        //if(state == CAL) begin
        //   nu1   <= a_i;
        //   nu2   <= b_i;
        //   sl    <= sel;
        //   start <= start_cal;
        //end
        //else begin
        //   nu1   <= 'd0;
        //   nu2   <= 'd0;
        //   sl    <= 'd0;
        //   start <= 'd0;
        //end
        nu1   <= a_i;
        nu2   <= b_i;
        sl    <= sel;
        tmp   <= start_cal;
     end
  end
   always @(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
         tmp1 <= 'd0;
      end
      else begin
         tmp1 <= tmp;
      end
   end

  assign start = tmp & ~tmp1;
  assign nu2_in_add_sub = sl ? ~nu2 : nu2;
  
///////////////////////
//INSTANTIATIONS
  
  e_ppn_add p_ksa_add_sub (
     .clk      (clk),
     .reset_n  (reset_n),
     .a_i      (in_a),
     .b_i      (in_b),
     .c_i      (sl),
     .s_o      (data),
     .c_o      (c_1)
  );

  always @(*) begin
     case(state)
        IDLE: begin
           n_state = start ? CAL : IDLE;
        end
        CAL: begin
           n_state = (count == 'd9) ? DONE : CAL;
        end
        DONE: begin
           n_state = IDLE;
        end
        default: begin
           n_state = IDLE;
        end
     endcase
  end

  always @(posedge clk or negedge reset_n) begin
     if(!reset_n) begin
        state <= IDLE;
     end
     else begin
        state <= n_state;
     end
  end
  
  always @(posedge clk or negedge reset_n) begin
     if(!reset_n) begin
        done_o <= 'd0;
        data_o <= 'd0;
        in_a   <= 'd0;
        in_b   <= 'd0;
        c_o    <= 'd0;
        count  <= 'd0;
     end
     else begin
        case(state) 
           IDLE: begin
              done_o <= 'd0;
              data_o <= data_o;
              //in_a   <= nu1;
              //in_b   <= nu2_in_add_sub;
              in_a   <= 256'd0;
              in_b   <= 256'd0;
              c_o    <= c_o;
              count  <= 'd0;
           end
           CAL: begin
              count  <= count + 'd1;
              //in_a   <= in_a;
              //in_b   <= in_b;
              in_a   <= nu1;
              in_b   <= nu2_in_add_sub;
              data_o <= (count == 'd9) ? data : 'd0;
              //c_o    <= (count == 'd9) ? ((sl ^ c_1) & ~(sign_a ^ sign_b)) : 'd0; // add, c_o = 1 => overflow; sub, c_o = 1 => < 0;
              done_o <= (count == 'd9) ? 1'b1 : 1'b0;
              if(count == 'd9) begin
                  case ({sign_a,sign_b})
                     2'b00: begin
                        c_o <= sl ? ~c_1 : c_1;
                     end
                     2'b01: begin
                        if(sl) begin
                           c_o <= (!in_b[255]) ? c_1 : ~c_1;
                        end
                        else begin
                           c_o <= overflow;                     //overflow => denta_rs > p in (abs) => c_o = 1
                        end
                     end
                     2'b10: begin
                        c_o <= sl ? c_1 : 1'b0;                 //
                     end
                     default: begin
                         c_o <= sl ? ~c_1 : c_1;
                     end
                  endcase
              end
              else begin
                  c_o <= 'd0;
              end
           end
           DONE: begin
              done_o <= 'd0;
              data_o <= data_o;
              in_a   <= 'd0;
              in_b   <= 'd0;
              c_o    <= c_o;
              count  <= 'd0;
           end
           default: begin
              done_o <= 'd0;
              data_o <= 'd0;
              in_a   <= 'd0;
              in_b   <= 'd0;
              c_o    <= 'd0;
              count  <= 'd0;
           end
        endcase
     end
  end

//  assign c_o = sl ? ~c_1 : c_1;
  assign comp = (in_a > in_b) ? 1'b1 : 1'b0;

  always @(posedge clk or negedge reset_n) begin
     if(!reset_n) begin
        sign_o <= 'd0;
     end
     else begin
        if(state == DONE) begin
           if(sl) begin
              if({sign_a,sign_b} == 2'b00) begin     // 00: sign_o = bit 256
                 sign_o <= c_o;
              end
              else begin
                 sign_o <= sign_a;                   // 01: sign_o = 0 , 10: sign_o = 1, ko co trg hop 11
              end
           end
           else begin
              //sign_o <= (sign_a && sign_b) ? 1'b1 : sign_o;                      // add: sig = 0
               if({sign_a,sign_b} == 2'b00 || {sign_a,sign_b} == 2'b11) begin
                  sign_o <= sign_a;
               end
               else begin
                  if(overflow) begin
                     sign_o <= sign_b;    // b > a
                  end
                  else begin
                     //sign_o <= comp ? 1'b0 : 1'b1; // a > b =>0 else => 1 
                     sign_o <= 'b0;
                  end
               end
           end
        end
        else begin
           sign_o <= sign_o;
        end
     end
  end

endmodule