////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : db_b3check8.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Thu Nov 17 11:30:48 2011
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module db_b3check8  
    (clk,
     rst,

     cfgcep,
     cfgvc3,    // 1/0 ~ STS/VT mode
     cfgb3,
     
     ivld,
     idat,
     ij1,
     
     ob3prbserr,
     oprbssyn
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input           clk,
                rst;

input           cfgcep;
input           cfgvc3;
input [12:0]    cfgb3;
    
input           ivld;
input [7:0]     idat;
input           ij1;

output          ob3prbserr;
output          oprbssyn;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       PKMOD = 0;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// Position: J1,byte,byte,...,endcol,B3
// VC3 cnt : 1, 2,   3, ...  ,87,    88,...783
// VC4 cnt : 1, 2,   3, ...  ,261,   262,...2349

//wire [11:0]     b3max = cfgvc3 ? 12'd783 : 12'd2349;
//wire [13:0]     b3max = cfgvc3 ? 13'd783 : 13'd9396;
//wire [13:0]     b3max = 14'd9396;

(* keep = "true" *) reg [15:0]  b3max = 16'd783;
always @ (posedge clk)
    begin
    b3max <= (cfgb3 == 13'd86) ? 16'd765 :
             (cfgb3 == 13'd88) ? 16'd783 :
             (cfgb3 == 13'd262) ? 16'd2349 : 
             (cfgb3 == 13'd1045) ? 16'd9396 : 16'd37584;
    end

wire [15:0]     ob3cnt,b3cnt;
assign          ob3cnt = ivld & ij1 ? 16'd2 : // reset by external J1
                         //ivld & (b3cnt >= b3max) ? 12'd1 :
                         ivld & (b3cnt >= b3max) ? 16'd1 :
                         ivld                    ? b3cnt + 1'b1 : b3cnt;
fflopx #(16) ib3cnt (clk,rst,ob3cnt,b3cnt);
//wire [13:0]     b3poscnt = (ivld & ij1) ? 14'd1 : b3cnt;

wire            j1pos,v5pos;
assign          j1pos = ij1 | ((b3cnt == 16'd1) & (PKMOD == 1));
assign          v5pos = j1pos;

wire            cfgv5mod = !cfgvc3;
wire            cfgb3mod = cfgvc3;

wire [7:0]      ob3sum,b3sum;
assign          ob3sum = ivld & cfgb3mod ? (j1pos ? idat : b3sum^idat) : 
                         ivld & cfgv5mod ? (v5pos ? 2'b00 : b3sum[1:0])^idat[7:6]^idat[5:4]^idat[3:2]^idat[1:0] :  
                                           b3sum;
fflopx #(8) ib3sum (clk,rst,ob3sum,b3sum);

wire [7:0]      ob3pre,b3pre;
assign          ob3pre = ivld & j1pos ? b3sum : b3pre;
fflopx #(8) ib3pre (clk,rst,ob3pre,b3pre);

wire            b3pos;
//assign          b3pos = ivld & (cfgvc3 ? (b3cnt == 12'd88) : (b3cnt == 12'd262));
assign          b3pos = ivld & (b3cnt == cfgb3);
//assign          b3pos = ivld & (b3poscnt == cfgb3);

wire            ob3err;
assign          ob3err = cfgb3mod ? b3pos & (|(b3pre^idat)) : ivld & v5pos & (b3sum[1:0]!=idat[7:6]);

// Check PRBS
wire [14:0]     iprbs;
reg [14:0]      oprbs;
always @ (posedge clk or posedge rst)
    begin
    if (rst)        oprbs <= 15'h7FFF;
    else if (ivld)  oprbs <= iprbs;
    end
wire            prbserr,prbssyn;
af6ces48rtl_prbscheck prbs15mon (.ivld(ivld),.idat(idat),.iprbs(oprbs),.oprbs(iprbs),.oerr(prbserr),.osyn(prbssyn));

// Report error
fflopx #(1) b3prbserr (clk,rst,(cfgcep ? ob3err : ivld & prbserr),ob3prbserr);
fflopx #(1) ppprbssyn (clk,rst,(cfgcep ? ij1 & ivld : ivld & prbssyn),oprbssyn);

endmodule 
