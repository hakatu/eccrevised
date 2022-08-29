////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : array111_regpx.v
// Description  : a library of a register array model with
//                  1 read ports and 1 write port.
//
// Author       : ddduc@HW-DDDUC
// Created On   : Tue Oct 21 20:49:10 2003
// History (Date, Changed By)
//  Thu Nov 13 09:36:19 2003, ddduc, Added rst_ pin 
//  Mon Jul 27 14:40:33 2009, ndtu@HW-NDTU
//      add parameter MAXDEPTH for better resource usage
//  Fri Aug 23 09:21:00 2013, tund@HW-NDTU
//      add parameter MEM_RESET to off clear MEMORY
////////////////////////////////////////////////////////////////////////////////

module array111_regpx (rst_,wclk,wa,we,di,rclk,ra,do,par_ctrl,par_err);

parameter ADDRBIT = 9;
parameter DEPTH = 512;
parameter WIDTH = 32;
parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;
parameter MEM_RESET = "OFF";
parameter RSTVAL = {WIDTH{1'b0}};

input               rst_;
input               wclk;
input [ADDRBIT-1:0] wa;
input               we;
input [WIDTH-1:0]   di;
input               rclk;
input [ADDRBIT-1:0] ra;
output [WIDTH-1:0]  do;
input [1:0]         par_ctrl;//[0]: parity error clear - [1]: Disable parity calculation for testing
output              par_err; // Parity Error Sticky Out

////////////////////////////////////////////////////////////////////////////////
reg [WIDTH-1:0]     do;
reg [WIDTH-1:0]     reg_array [DEPTH-1:0];
wire [WIDTH-1:0]     dout;
assign dout = reg_array [ra];
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

always @ (posedge rclk or negedge rst_)
    begin
    if (~rst_)
        begin
        do <= {WIDTH{1'b0}};
        end
    else
        begin
        do <= dout;
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

// read
reg    parclr_rd;
always @ (posedge rclk or negedge rst_)
    begin
    if (~rst_) parclr_rd <= 1'b0;
    else    parclr_rd <= parclr;
    end
        
wire   ra_ok;
assign ra_ok   = (ra < DEPTH);

reg    ra_ok1,parity1;
always @ (posedge rclk or negedge rst_)
    if (~rst_)
        begin
        ra_ok1  <= 1'b0;
        parity1 <= 1'b0;
        end
    else
        begin
        ra_ok1  <= ra_ok & (~parclr_rd);
        parity1 <= mmmparity[ra];
        end

reg             xxxparerrstk;
always @ (posedge rclk or negedge rst_) 
    if (~rst_) xxxparerrstk <= 1'b0;
    else
        begin
        if (parclr_rd) xxxparerrstk <= 1'b0;
        else xxxparerrstk <= xxxparerrstk | (ra_ok1 & (parity1 ^ (^do)));
        end

wire par_err;
assign par_err = xxxparerrstk;


endmodule