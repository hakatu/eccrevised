////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array131_regpx.v
// Description  : .
//
// Author       : ddduc@HW-DDDUC
// Created On   : Wed Jan 17 14:49:56 2007
// History (Date, Changed By)
//  Wed Apr 18 13:51:25 2007, ctmtu, Added parity check 
//  - Note: Parity check is used for 1 clock domain operation (wclk,rclk1,rclk2,rclk3) only
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
////////////////////////////////////////////////////////////////////////////////

module array131_regpx (rst_,wclk,wa,we,di,
                      rclk1,ra1,do1,
                      rclk2,ra2,do2,
                      rclk3,ra3,do3,
                      par_ctrl,par_err);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk1;
input [ADDRBIT-1:0] ra1;
output [WIDTH-1:0]  do1;
input               rclk2;
input [ADDRBIT-1:0] ra2;
output [WIDTH-1:0]  do2;
input               rclk3;
input [ADDRBIT-1:0] ra3;
output [WIDTH-1:0]  do3;

input [1:0]         par_ctrl;//[0]: parity error clear - [1]: Disable parity calculation for testing
output              par_err; // Parity Error Sticky Out

////////////////////////////////////////////////////////////////////////////////
reg [WIDTH-1:0]     do1, do2, do3;
reg [WIDTH-1:0]     reg_array [DEPTH-1:0];

wire [WIDTH-1:0]    dout1;
assign              dout1    = reg_array [ra1];

wire [WIDTH-1:0]    dout2;
assign              dout2    = reg_array [ra2];

wire [WIDTH-1:0]    dout3;
assign              dout3    = reg_array [ra3];

integer i;

always @ (posedge wclk or negedge rst_)
    begin
    if (~rst_)
        begin
        for (i = 0; i < DEPTH; i = i + 1)
            begin
            reg_array[i] <= {WIDTH{1'b0}};
            end
        end
    else if (we)
        begin
        reg_array[wa] <= di;
        end
    end

always @ (posedge rclk1 or negedge rst_)
    begin
    if (~rst_)
        begin
        do1 <= {WIDTH{1'b0}};
        end
    else
        begin
        do1 <= dout1;
        end
    end

always @ (posedge rclk2 or negedge rst_)
    begin
    if (~rst_)
        begin
        do2 <= {WIDTH{1'b0}};
        end
    else
        begin
        do2 <= dout2;
        end
    end

always @ (posedge rclk3 or negedge rst_)
    begin
    if (~rst_)
        begin
        do3 <= {WIDTH{1'b0}};
        end
    else
        begin
        do3 <= dout3;
        end
    end

//-----------------parity control -----------------------
// write
wire par_enb;
assign par_enb = !par_ctrl[1];

reg [DEPTH-1:0] mmmparity;
always @ (posedge wclk or negedge rst_)
    begin
    if (~rst_)
        begin
        mmmparity <= {DEPTH{1'b0}};
        end
    else if (we & par_enb) mmmparity[wa] <= ^di;
    end

reg    we1,we2,we3,parclr;
always @ (posedge wclk or negedge rst_)
    if (~rst_)
        begin
        we1 <= 1'b0;
        we2 <= 1'b0;
        we3 <= 1'b0;
        parclr <= 1'b0;        
        end
    else
        begin
        we1 <= we;
        we2 <= we1;
        we3 <= we2;
        parclr <= we|we1|we2|we3|par_ctrl[0];
        end

// read 1
reg    parclr_rd1;
always @ (posedge rclk1 or negedge rst_)
    begin
    if (~rst_) parclr_rd1 <= 1'b0;
    else    parclr_rd1 <= parclr;
    end

wire   ra1_ok;
assign ra1_ok   = (ra1 < DEPTH);

reg    ra1_ok1,parra1_p1;
always @ (posedge rclk1 or negedge rst_) 
    if (~rst_)
        begin
        ra1_ok1 <= 1'b0;
        parra1_p1 <= 1'b0;
        end
    else
        begin
        ra1_ok1 <= ra1_ok & (~parclr_rd1);
        parra1_p1 <= mmmparity[ra1];
        end

reg             xxxparerrstk1;
always @ (posedge rclk1 or negedge rst_) 
    if (~rst_) xxxparerrstk1 <= 1'b0;
    else
        begin
        if (parclr_rd1) xxxparerrstk1 <= 1'b0;
        else xxxparerrstk1 <= xxxparerrstk1 | (ra1_ok1 & (parra1_p1 ^ (^do1)));     
        end

// read 2
reg    parclr_rd2;
always @ (posedge rclk2 or negedge rst_)
    begin
    if (~rst_) parclr_rd2 <= 1'b0;
    else    parclr_rd2 <= parclr;
    end

wire   ra2_ok;
assign ra2_ok   = (ra2 < DEPTH);

reg    ra2_ok1,parra2_p1;
always @ (posedge rclk2 or negedge rst_) 
    if (~rst_)
        begin
        ra2_ok1 <= 1'b0;
        parra2_p1 <= 1'b0;
        end
    else
        begin
        ra2_ok1 <= ra2_ok & (~parclr_rd2);
        parra2_p1 <= mmmparity[ra2];
        end

reg             xxxparerrstk2;
always @ (posedge rclk2 or negedge rst_) 
    if (~rst_) xxxparerrstk2 <= 1'b0;
    else
        begin
        if (parclr_rd2) xxxparerrstk2 <= 1'b0;
        else xxxparerrstk2 <= xxxparerrstk2 | (ra2_ok1 & (parra2_p1 ^ (^do2)));     
        end


// read 3
reg    parclr_rd3;
always @ (posedge rclk3 or negedge rst_)
    begin
    if (~rst_) parclr_rd3 <= 1'b0;
    else    parclr_rd3 <= parclr;
    end

wire   ra3_ok;
assign ra3_ok   = (ra3 < DEPTH);

reg    ra3_ok1,parra3_p1;
always @ (posedge rclk3 or negedge rst_) 
    if (~rst_)
        begin
        ra3_ok1 <= 1'b0;
        parra3_p1 <= 1'b0;
        end
    else
        begin
        ra3_ok1 <= ra3_ok & (~parclr_rd3);
        parra3_p1 <= mmmparity[ra3];
        end

reg             xxxparerrstk3;
always @ (posedge rclk3 or negedge rst_) 
    if (~rst_) xxxparerrstk3 <= 1'b0;
    else
        begin
        if (parclr_rd3) xxxparerrstk3 <= 1'b0;
        else xxxparerrstk3 <= xxxparerrstk3 | (ra3_ok1 & (parra3_p1 ^ (^do3)));     
        end

wire par_err;
assign par_err = xxxparerrstk1 | xxxparerrstk2 | xxxparerrstk3;

endmodule