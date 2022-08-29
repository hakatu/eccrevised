module ATCKMUX2
    (
     SEL,
     CKIN0,
     CKIN1,
     CKOUT
     );
input SEL;
input CKIN0;
input CKIN1;
output CKOUT;
//assign O = SEL ? I1 : I0;
reg    CKOUT;
always @(CKIN0 or CKIN1 or SEL)
    begin
//    #0.3;
    CKOUT = SEL ? CKIN1 : CKIN0;
    end
endmodule
