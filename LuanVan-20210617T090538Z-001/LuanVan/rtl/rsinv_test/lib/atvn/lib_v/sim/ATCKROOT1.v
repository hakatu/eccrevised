module ATCKROOT1
    (
     A,
     Y
     );
input A;
output Y;
//assign Y = A;
reg    Y;
always @(A)
    begin
//    #0.5;
    Y = A;
    end

endmodule
