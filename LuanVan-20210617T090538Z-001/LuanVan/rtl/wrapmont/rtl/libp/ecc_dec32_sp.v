////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ecc_dec16.v
// Description  : Decode 16 bits data using Hamming SECDED code
//
// Author       : pmduc@HW-PMDUC
// Created On   : Mon Jun 05 15:00:15 2006
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ecc_dec32_sp
    (
     idat,
     odat,
     alarm,
     dis
     );
input   [37:0]  idat;
output [31:0]   odat;
output          alarm;
input           dis;

wire            p1,p2,p4,p8,p16,p32;
wire            d3,d5,d6,d7,d9,d10,d11,d12,d13,d14,d15,d17,d18,d19,d20,d21,
                d22,d23,d24,d25,d26,d27,d28,d29,d30,d31,d33,d34,d35,d36,d37,
                d38;

wire            c1,c2,c4,c8,c16,c32;

assign          {d38,d37,d36,d35,d34,d33,p32,d31,d30,d29,d28,d27,
                 d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,p16,d15,d14,d13,d12,
                 d11,d10,d9,p8,d7,d6,d5,p4,d3,p2,p1} = idat;

assign          c1 = d3 ^ d5 ^ d7 ^ d9 ^ d11 ^ d13 ^ d15 ^ d17 ^ d19 ^ d21 
                      ^ d23 ^ d25 ^ d27 ^ d29 ^ d31 ^ d33 ^ d35 ^ d37;

assign          c2 = d3 ^ d6 ^ d7 ^ d10 ^ d11 ^ d14 ^ d15 ^ d18 ^ d19 ^ d22 ^ 
                    d23 ^ d26 ^ d27 ^ d30 ^ d31 ^ d34 ^ d35 ^ d38;

assign          c4 = d5 ^ d6 ^ d7 ^ d12^ d13 ^ d14 ^ d15 ^ d20 ^ d21 ^ d22 ^ d23 ^
                    d28 ^ d29 ^ d30 ^ d31 ^ d36 ^ d37 ^ d38;

assign          c8 = d9 ^ d10^ d11^ d12^ d13 ^ d14 ^ d15 ^ d24 ^ d25 ^ d26 ^ d27 ^ 
                    d28 ^ d29 ^ d30 ^ d31;
assign          c16= d17 ^ d18 ^ d19 ^ d20 ^ d21 ^ d22 ^ d23 ^ d24 ^ d25 ^ d26 ^ d27 ^ d28 ^
                     d29 ^ d30 ^ d31;
assign          c32 = d33 ^ d34 ^ d35 ^ d36 ^ d37 ^ d38;

wire [5:0]      check;
assign          check = dis ? 6'b0 : ({p32,p16,p8,p4,p2,p1} ^ {c32,c16,c8,c4,c2,c1});

wire            o3,o5,o6,o7,o9,o10,o11,o12,o13,o14,o15,o17,o18,o19,o20,o21,
                o22,o23,o24,o25,o26,o27,o28,o29,o30,o31,o33,o34,o35,o36,o37,
                o38;


assign          o3 = (check  == 6'd3) ? (!d3) : d3;
assign          o5 = (check  == 6'd5) ? (!d5) : d5;
assign          o6 = (check  == 6'd6) ? (!d6) : d6;
assign          o7 = (check  == 6'd7) ? (!d7) : d7;
assign          o9 = (check  == 6'd9) ? (!d9) : d9;
assign          o10= (check  == 6'd10) ? (!d10): d10;
assign          o11= (check  == 6'd11) ? (!d11): d11;
assign          o12= (check  == 6'd12) ? (!d12): d12;
assign          o13 = (check == 6'd13) ? (!d13): d13;
assign          o14 = (check == 6'd14) ? (!d14): d14;
assign          o15 = (check == 6'd15) ? (!d15): d15;
assign          o17 = (check == 6'd17) ? (!d17): d17;
assign          o18 = (check == 6'd18) ? (!d18): d18;
assign          o19 = (check == 6'd19) ? (!d19): d19;
assign          o20= (check  == 6'd20) ? (!d20): d20;
assign          o21= (check  == 6'd21) ? (!d21): d21;
assign          o22= (check  == 6'd22) ? (!d22): d22;
assign          o23= (check  == 6'd23) ? (!d23): d23;
assign          o24= (check  == 6'd24) ? (!d24): d24;
assign          o25= (check  == 6'd25) ? (!d25): d25;
assign          o26= (check  == 6'd26) ? (!d26): d26;
assign          o27= (check  == 6'd27) ? (!d27): d27;
assign          o28= (check  == 6'd28) ? (!d28): d28;
assign          o29= (check  == 6'd29) ? (!d29): d29;
assign          o30= (check  == 6'd30) ? (!d30): d30;
assign          o31= (check  == 6'd31) ? (!d31): d31;
assign          o33= (check  == 6'd33) ? (!d33): d33;
assign          o34= (check  == 6'd34) ? (!d34): d34;
assign          o35= (check  == 6'd35) ? (!d35): d35;
assign          o36= (check  == 6'd36) ? (!d36): d36;
assign          o37= (check  == 6'd37) ? (!d37): d37;
assign          o38= (check  == 6'd38) ? (!d38): d38;

assign          odat = {o38,o37,o36,o35,o34,o33,o31,o30,o29,o28,o27,o26,o25,o24,
                        o23,o22,o21,o20,o19,o18,o17,o15,o14,o13,o12,o11,o10,o9,o7,
                        o6,o5,o3};
wire            alarm;
assign          alarm = | check;

endmodule 
