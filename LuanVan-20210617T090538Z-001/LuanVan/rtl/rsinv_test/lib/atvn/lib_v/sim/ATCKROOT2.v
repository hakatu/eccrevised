module ATCKROOT2
    (
     A,
     Y
     );
input A;
output Y;

reg    Y;
always @(A)
    begin
    Y = A;
    end

endmodule
