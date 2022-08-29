module ATCKINV1
    (
     A,
     Y
     );
input A;
output Y;
assign Y = ~A;
/*
reg    O;
always @(I)
    begin
    #0.13;
    O = I;
    end
*/    
endmodule
