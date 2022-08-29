module ATDFF2_SET
    (
     D,
     CK,
     SET_,
     Q
     );
input   D,CK,SET_;
output  Q;
//SDN_FDPSBQ_2 ATDFFi (.D(D),.CK(CK),.SB(SET_),.Q(Q) );
//fflopx #(1) ATDFFi(~CK,SET_,D,Q);
reg     Q;
always @(posedge CK or negedge SET_)
    begin
    if (!SET_) Q <= 1'b1;
    else Q <= D;
    end
endmodule
