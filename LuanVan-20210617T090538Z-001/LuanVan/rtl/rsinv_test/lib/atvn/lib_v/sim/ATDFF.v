module ATDFF
    (
     D,
     CK,
     RST_,
     Q
     );
input D;
input CK;
input RST_;
output Q;

wire   Out;
fflopx #(1) FF(CK,RST_,D,Out);

reg    Q;
always @(Out)
    begin
//  #0.56;
    Q = Out;
    end

endmodule
