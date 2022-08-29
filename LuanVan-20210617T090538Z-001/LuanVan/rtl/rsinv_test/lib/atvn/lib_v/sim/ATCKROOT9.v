module ATCKROOT9
    (
     A,
     Y
     );
input A;
output Y;
//assign O = I;
reg    Y;
always @(A)
    begin
//    #0.5;
    Y = A;
    end

endmodule
