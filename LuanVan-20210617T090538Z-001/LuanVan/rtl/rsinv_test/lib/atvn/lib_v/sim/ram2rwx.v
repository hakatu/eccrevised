//////////////////////////////////////////////////////////////////////////////////
//
//  Arrive Technologies
//
// Filename        : ram2rwx.v
// Description     : a library of true dual port RAM model
//
// Author          : nlgiang@HW-NLGIANG
// Created On      : Sat Oct 09 08:17:21 2004
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
//
////////////////////////////////////////////////////////////////////////////////// 

module ram2rwx (clk0,a0,we0,di0,do0,clk1,a1,we1,di1,do1);

parameter ADDRBIT_A = 11;
parameter DEPTH_A = 1536;
parameter WIDTH_A = 32;

parameter ADDRBIT_B = 11;
parameter DEPTH_B = 1536;
parameter WIDTH_B = 32;

parameter TYPE = "AUTO";
parameter MAXDEPTH = 0;

parameter DEPTH_R = (DEPTH_A >= DEPTH_B)? DEPTH_A : DEPTH_B;
parameter WIDTH_R = (WIDTH_A >= WIDTH_B)? WIDTH_A : WIDTH_B;

input                   clk0, clk1;
input [ADDRBIT_A-1:0]   a0;
input                   we0;
input [WIDTH_A-1:0]     di0;
output [WIDTH_A-1:0]    do0;

input [ADDRBIT_B-1:0]   a1;
input                   we1;
input [WIDTH_B-1:0]     di1;
output [WIDTH_B-1:0]    do1;

reg [WIDTH_R-1:0] ram [DEPTH_R-1:0];
reg [WIDTH_A-1:0] do0;
reg [WIDTH_B-1:0] do1;

integer i;
initial
    begin 
    for(i=0;i<DEPTH_R;i=i+1)
        ram[i] = {WIDTH_R{1'b0}};
    end

always @ (posedge clk0)
    begin
    if (we0)
        begin
        if ((a0 == a1) & we1)
            begin
            //do <= {WIDTH{1'bx}};  do not like altera model.           
            $display ("<<ERROR>> Port A write and Port B write at the same address @clk0 at %h",a0);
            end
        else
            begin
            ram[a0] <= di0;
            end
        end
    else do0 <= ram[a0];
/* -----\/----- EXCLUDED -----\/-----
    
        begin
        if ((a0 == a1) & we1)
            begin
            $display ("<<ERROR>> Port A read and Port B write at the same address @clk0 at %h",a0);            
            end
        else    do0 <= ram[a0];
        end
 -----/\----- EXCLUDED -----/\----- */
    end

always @ (posedge clk1)
    begin
    if (we1)
        begin
        if ((a1 == a0) & we0)
            begin
            //do <= {WIDTH{1'bx}};  do not like altera model.           
            $display ("<<ERROR>> Port A write and Port B write at the same address @clk1 at %h",a1);
            end
        else
            begin
            ram[a1] <= di1;
            end
        end
    else    do1 <= ram[a1];
/* -----\/----- EXCLUDED -----\/-----
    
        begin
        if ((a1 == a0) & we0)
            begin
            $display ("<<ERROR>> Port A write and Port B read at the same address @clk1 at %h",a1);            
            end
        else    do1 <= ram[a1];
        end
 -----/\----- EXCLUDED -----/\----- */
    end

endmodule

