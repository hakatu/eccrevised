module ATBUF
    (
     A,
     Y
     );
input A;
output Y;
reg    Y;
always @(A)
    begin
//    #1.5;
    Y = A;
    end
endmodule
