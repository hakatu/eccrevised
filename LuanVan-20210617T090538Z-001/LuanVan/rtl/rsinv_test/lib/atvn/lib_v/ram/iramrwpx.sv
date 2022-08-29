//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : iramrwpx.sv
// Description     : a library of read write port RAM model with dual clocks
//                 : for simulation
// Author          : dienlc@atvn.com.vn
// Created On      : Tue May-19,2015
// History (Date, Changed By)
//      Tue May-19,2015: dienlc: first init
//////////////////////////////////////////////////////////////////////////////////
module iramrwpx
    (
     wclk,
     wa,
     we,
     wdi,
     
     rclk,
     ra,
     re,
     rdo,
     
     test,
     mask
     );

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

input               wclk;
input bit [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   wdi;
input               rclk;
input bit [ADDRBIT-1:0] ra;
input               re;
output logic [WIDTH-1:0]  rdo;
input               mask;   // =1 -> re is disable
input               test;   // wr and rd are disable
//-----------------------------------------------------------------------------------
bit [WIDTH-1:0] ram [int]; //2 state: Do not need to init

bit  DISPLAY_ERR_RAM;
initial begin
   if($test$plusargs("DISPLAY_ERR_RAM_OFF"))  DISPLAY_ERR_RAM=1'b0;
	 else DISPLAY_ERR_RAM=1'b1;
end
always @ (posedge wclk) begin
   if (we & (!test)) begin
      if (re & (wa === ra)) begin
         ram[wa] = wdi;
         if (DISPLAY_ERR_RAM) $display("%m ERR_RAM: WR and RD at the same address @wclk at %h %t",ra,$time);
      end else begin
         ram[wa] = wdi;
      end
   end
end

always @ (posedge rclk) 
	begin
   	if (test)   rdo <= {WIDTH{1'b0}};
   	else if (re | mask) 
		begin
      	if (we & (wa === ra)) 
	      	begin
          	rdo <= {WIDTH{1'bx}};
          	if (DISPLAY_ERR_RAM) $display("%m ERR_RAM: RD and WR at the same address @rclk at %h %t",ra,$time);
          	end 
	  	else 
	     	begin
         	rdo  <= ram[ra];
         	end
	  	end 
	else 
		begin
        rdo  <= {WIDTH{1'b0}};
	    end
    end

// for debug            
wire   sameaddr;
assign sameaddr = re & we & (wa === ra);

endmodule

