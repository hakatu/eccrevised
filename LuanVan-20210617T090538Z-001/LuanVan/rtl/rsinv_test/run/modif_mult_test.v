`timescale 1ns / 1ps
`define TEST
module modif_mult_test;
//para
`ifdef TEST
parameter WID = 4;
`else
parameter WID = 256;
`endif
    // Inputs
    reg [WID-1:0] x, y;
    reg clk, reset, start;
    wire [WID-1:0] z;
    wire done;
    // Instantiate the Unit Under Test (UUT)

montprowrap imontprowrap
    (
     .clk(clk),
     .rst(reset),
     
     .a(x),//input a
     .b(y),//input b
     
     .r(z),//output result
     
     .start(start), //status report
     .done(done)
     );

    always
        #50 clk = ~clk;

    initial begin
        // Initialize Inputs
        x = 0;
        y = 0;      
        clk = 1;
        // Wait 100 ns for global reset to finish
        #100;
          
        x = 4'd10;
        y = 4'd5;
        reset = 1;
    start = 0;
    #100
        reset = 0;
    #100
        start = 1;
    #100
        start = 0;
    #500
        x = 4'd7;
        y = 4'd5;
    start = 1;
    #100
        start = 0;
    #500
        x = 4'd5;
        y = 4'd7;
    start = 1;
    #100
        start = 0;
        #500
        x = 4'd11;
        y = 4'd2;
    start = 1;
    #100
        start = 0;
        #500
        x = 4'd2;
        y = 4'd11;
    start = 1;
    #100
        start = 0;
        #500
        x = 4'd5;
        y = 4'd10;
    start = 1;
    #100
        start = 0;
            #500
        x = 4'd5;
        y = 4'd12;
    start = 1;
    #100
        start = 0;
            #500
        x = 4'd4;
        y = 4'd1;
    start = 1;
    #100
        start = 0;
            #500
        x = 4'd4;
        y = 4'd4;
    start = 1;
    #100
        start = 0;
        #100
        start = 0;
            #500
        x = 4'd15;
        y = 4'd15;
    start = 1;
    #100
        start = 0;
                #500
        x = 4'd15;
        y = 4'd14;
    start = 1;
    #100
        start = 0;
                #500
        x = 4'd14;
        y = 4'd14;
    start = 1;
    #100
        start = 0;
                    #500
        x = 4'd13;
        y = 4'd13;
    start = 1;
    #100
        start = 0;
                    #500
        x = 4'd13;
        y = 4'd14;
    start = 1;
    #100
        start = 0;
        #3000;
    end
    
    initial 
        #100000 $finish;

initial begin
$shm_open ("my_waves");
$shm_probe (modif_mult_test,"AC");
$recordfile("testsample.trn");
$recordvars();
end


      
endmodule

