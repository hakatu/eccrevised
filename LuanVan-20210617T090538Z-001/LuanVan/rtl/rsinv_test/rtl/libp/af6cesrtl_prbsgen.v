////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : prbs15gen8bit.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Tue Jul 09 11:00:34 2013
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af6cesrtl_prbsgen
    (clk,
     rst,
     
     ivld,
     iid,
     idat,
     iinf,
     
     ovld5,
     oid5,
     odat5,
     oinf5,
     oprbs5,//PRBS enable

     // CPU interface
     upen,
     upa,       
     upws,      
     uprs,      
     updi,
     updo,
     uprdy                               
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       ID  = 8;
parameter       INF = 32;

parameter       HI = 15;
parameter       LO = 14;

parameter       RESET_PAT = 15'h7FFF;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               ivld;
input [ID-1:0]      iid;
input [7:0]         idat;
input [INF-1:0]     iinf;

output              ovld5;
output [ID-1:0]     oid5;
output [7:0]        odat5;
output [INF-1:0]    oinf5;
output              oprbs5;

     // CPU interface
input               upen;
input [ID-1:0]      upa;
input               upws,      
                    uprs;
input [31:0]        updi;
output [31:0]       updo;
output              uprdy;          

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// pipeline input
wire                ivld1,ivld2,ivld3,ivld4;
fflopx #(1) ppivld (clk,rst,ivld,ivld1);
fflopx #(1) ppivld1 (clk,rst,ivld1,ivld2);
fflopx #(1) ppivld2 (clk,rst,ivld2,ivld3);
fflopx #(1) ppivld3 (clk,rst,ivld3,ivld4);
fflopx #(1) ppivld4 (clk,rst,ivld4,ovld5);

wire [ID-1:0]       iid1,iid2,iid3,iid4;
fflopx #(ID) ppiid (clk,rst,iid,iid1);
fflopx #(ID) ppiid1 (clk,rst,iid1,iid2);
fflopx #(ID) ppiid2 (clk,rst,iid2,iid3);
fflopx #(ID) ppiid3 (clk,rst,iid3,iid4);
fflopx #(ID) ppiid4 (clk,rst,iid4,oid5);

wire [INF-1:0]      iinf1,iinf2,iinf3,iinf4;
fflopx #(INF) ppiinf (clk,rst,iinf,iinf1);
fflopx #(INF) ppiinf1 (clk,rst,iinf1,iinf2);
fflopx #(INF) ppiinf2 (clk,rst,iinf2,iinf3);
fflopx #(INF) ppiinf3 (clk,rst,iinf3,iinf4);
fflopx #(INF) ppiinf4 (clk,rst,iinf4,oinf5);

wire [7:0]          idat1,idat2,idat3,idat4;
fflopx #(8) ppidat (clk,rst,idat,idat1);
fflopx #(8) ppidat1 (clk,rst,idat1,idat2);
fflopx #(8) ppidat2 (clk,rst,idat2,idat3);
fflopx #(8) ppidat3 (clk,rst,idat3,idat4);

wire                upws1,uprs1;
fflopx #(2) ppupwrs (clk,rst,{upws,uprs},{upws1,uprs1});

wire [ID-1:0]       upa1;
wire [1:0]          updi1;
wire                upen1;
fflopx #(ID) ppupa (clk,rst,upa,upa1);
fflopx #(2) ppupdi (clk,rst,updi[1:0],updi1);
fflopx #(1) ppupen (clk,rst,upen,upen1);
    
// Process
wire                cpu_rnw,cpu_rws;
assign              cpu_rws = upen1 & (upws1 | uprs1);
fflopxe #(1) icpu_rnw (clk,rst,cpu_rws,uprs1,cpu_rnw);

reg                 cpu_rd;
wire                cpu_re1,cpu_re2,cpu_re3,cpu_re4;
assign              cpu_re1 = !ivld1 & cpu_rd;
fflopx #(1) ppcpu_re1 (clk,rst,cpu_re1,cpu_re2);
fflopx #(1) ppcpu_re2 (clk,rst,cpu_re2,cpu_re3);
fflopx #(1) ppcpu_re3 (clk,rst,cpu_re3,cpu_re4);

always @ (posedge clk)
    begin
    if (rst)            cpu_rd <= 1'b0;
    else if (cpu_rws)   cpu_rd <= 1'b1;
    else if (cpu_re1)   cpu_rd <= 1'b0;
    end

wire                ram_re1;
wire [ID-1:0]       ram_ra1;
assign              ram_re1 = cpu_rd | ivld1;
assign              ram_ra1 = ivld1 ? iid1 : upa1[ID-1:0];

// status out
wire                cfgprbsen4;
wire                cfgprbsmd4; // 0/1 ~ prbs15/seq
wire [14:0]         oprbs4,prbs,prbs1,prbs2,prbs3,prbs4,prbs5,prbs6,prbs7,prbs8;
assign              prbs = |oprbs4 ? oprbs4 : RESET_PAT;
assign              prbs1 = {prbs[HI-2:0],(prbs[HI-1]^prbs[LO-1])};
assign              prbs2 = {prbs1[HI-2:0],(prbs1[HI-1]^prbs1[LO-1])};
assign              prbs3 = {prbs2[HI-2:0],(prbs2[HI-1]^prbs2[LO-1])};
assign              prbs4 = {prbs3[HI-2:0],(prbs3[HI-1]^prbs3[LO-1])};
assign              prbs5 = {prbs4[HI-2:0],(prbs4[HI-1]^prbs4[LO-1])};
assign              prbs6 = {prbs5[HI-2:0],(prbs5[HI-1]^prbs5[LO-1])};
assign              prbs7 = {prbs6[HI-2:0],(prbs6[HI-1]^prbs6[LO-1])};
assign              prbs8 = {prbs7[HI-2:0],(prbs7[HI-1]^prbs7[LO-1])};

wire [7:0]          iseq4 = oprbs4[7:0] + 1'b1;
wire [14:0]         iprbs4,iprbs5;
assign              iprbs4 = !ivld4 ? oprbs4 : cfgprbsmd4 ? iseq4 : prbs8;
wire [1:0]          icfgprbs4,icfgprbs5;
assign              icfgprbs4 = cpu_re4 & !cpu_rnw ? updi1[1:0] : {cfgprbsmd4,cfgprbsen4};

fflopx #(17) ppiprbs4 (clk,rst,{iprbs4,icfgprbs4},{iprbs5,icfgprbs5});
fflopx #(8) dat5 (clk,rst,(cfgprbsen4 ? oprbs4[7:0] : idat4),odat5);
fflopx #(1) prbsen5 (clk,rst,(ivld4 & cfgprbsen4),oprbs5);
 
wire [31:0]         updo;
wire [16:0]         nupdo = cpu_re4 ? {oprbs4,cfgprbsmd4,cfgprbsen4} : upen1 ? updo[16:0] : 17'd0;
assign              updo[31:17] = 15'd0;
fflopx #(17) iupdo (clk,rst,nupdo,updo[16:0]);
fflopx #(1) iuprdy (clk,rst,cpu_re4,uprdy);
 
wire                status_we;
wire [ID-1:0]       status_wa;
wire [16:0]         status_wrd;
wire                status_re;
wire [ID-1:0]       status_ra;
wire [16:0]         status_rdd;

rtlconflict113x #(ID,17) status_ctrl 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(ram_re1),
     .eng_ra(ram_ra1),
     .eng_rdd3({oprbs4[14:0],cfgprbsmd4,cfgprbsen4}),
     .eng_wrd4({iprbs5[14:0],icfgprbs5[1:0]}),
     
     // RAM or Register File Interface
     .memwe(status_we),
     .memre(status_re),
     .memwa(status_wa),
     .memwrd(status_wrd),
     .memra(status_ra),
     .memrdd(status_rdd)
     );

iarray113x #(ID,{1'b1,{ID{1'b0}}},17) memstatus
    (
     .wrst(rst),
     .wclk(clk),
     .wa(status_wa),
     .we(status_we),
     .di(status_wrd),
     .rclk(clk),
     .rrst(rst),
     .ra(status_ra),
     .re(status_re),
     .do(status_rdd),
     .mask(1'b0),
     .test(1'b0)
     );
      
endmodule 
