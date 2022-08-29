////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : af6zn13rtlmpeg_dbpld.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Wed Jul 04 08:21:25 2012
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af6cesrtl_prbsmon
    (clk,
     rst,

     // Data in
     ivld,
     idat,
     inob,
     ilid,
     icep,      // 1: check B3/V5
     icepmod,   // 0/1/2/3 ~ VC12/VC3/VC4/VC4-4C 
     icepj1v5,
     
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
parameter   LID = 7;
parameter   LNUM = {1'b1,{LID{1'b0}}};
    
////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;

input               ivld;
input [1:0]         inob;
input [31:0]        idat;
input [LID-1:0]     ilid;
input               icep;
input [1:0]         icepmod;
input               icepj1v5;

     // CPU interface
input               upen;
input [LID-1:0]     upa;
input               upws,      
                    uprs;
input [31:0]        updi;
output [31:0]       updo;
output              uprdy;          
        
        
////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// Pipeline input
wire                ivld1,ivld2,ivld3,ivld4;
fflopx #(1) ppivld (clk,rst,ivld,ivld1);
fflopx #(1) ppivld1 (clk,rst,ivld1,ivld2);
fflopx #(1) ppivld2 (clk,rst,ivld2,ivld3);
fflopx #(1) ppivld3 (clk,rst,ivld3,ivld4);

wire [1:0]          inob1,inob2,inob3,inob4;
fflopx #(2) ppinob (clk,rst,inob,inob1);
fflopx #(2) ppinob1 (clk,rst,inob1,inob2);
fflopx #(2) ppinob2 (clk,rst,inob2,inob3);
fflopx #(2) ppinob3 (clk,rst,inob3,inob4);

wire [31:0]         idat1,idat2,idat3,idat4;
fflopx #(32) ppidat (clk,rst,idat,idat1);
fflopx #(32) ppidat1 (clk,rst,idat1,idat2);
fflopx #(32) ppidat2 (clk,rst,idat2,idat3);
fflopx #(32) ppidat3 (clk,rst,idat3,idat4);

wire [LID-1:0]      ilid1;
fflopx #(LID) ppilid (clk,rst,ilid,ilid1);

wire                icep1,icep2,icep3,icep4;
fflopx #(1) ppicep (clk,rst,icep,icep1);
fflopx #(1) ppicep1 (clk,rst,icep1,icep2);
fflopx #(1) ppicep2 (clk,rst,icep2,icep3);
fflopx #(1) ppicep3 (clk,rst,icep3,icep4);

wire [1:0]          icepmod1,icepmod2,icepmod3,icepmod4;
fflopx #(2) ppicepmod (clk,rst,icepmod,icepmod1);
fflopx #(2) ppicepmod1 (clk,rst,icepmod1,icepmod2);
fflopx #(2) ppicepmod2 (clk,rst,icepmod2,icepmod3);
fflopx #(2) ppicepmod3 (clk,rst,icepmod3,icepmod4);

wire                icepj1v51,icepj1v52,icepj1v53,icepj1v54;
fflopx #(1) ppicepj1v5 (clk,rst,icepj1v5,icepj1v51);
fflopx #(1) ppicepj1v51 (clk,rst,icepj1v51,icepj1v52);
fflopx #(1) ppicepj1v52 (clk,rst,icepj1v52,icepj1v53);
fflopx #(1) ppicepj1v53 (clk,rst,icepj1v53,icepj1v54);

wire                upws1,uprs1;
fflopx #(2) ppupwrs (clk,rst,{upws,uprs},{upws1,uprs1});

wire [LID-1:0]       upa1;
wire [1:0]          updi1;
wire                upen1;
fflopx #(LID) ppupa (clk,rst,upa,upa1);
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
wire [LID-1:0]      ram_ra1;
assign              ram_re1 = cpu_rd | ivld1;
assign              ram_ra1 = ivld1 ? ilid1 : upa1[LID-1:0];

// status out
wire            b0ivld4,b1ivld4,b2ivld4,b3ivld4;
assign          b0ivld4 = ivld4;
assign          b1ivld4 = ivld4 & (inob4 >= 2'd1);
assign          b2ivld4 = ivld4 & (inob4 >= 2'd2);
assign          b3ivld4 = ivld4 & (inob4 >= 2'd3);

wire [14:0]     oprbs4,iprbs4,b0prbs4,b1prbs4,b2prbs4,b3prbs4;
wire [3:0]      err4,syn4,errseq4;
wire            oerr4,curerr4,ierr4;
wire            osyn4,isyn4;
wire            cfgseq4,icfgseq4;

assign          iprbs4 = b3ivld4 ? (cfgseq4 ? idat4[7:0] : b3prbs4) : 
                         b2ivld4 ? (cfgseq4 ? idat4[15:8] : b2prbs4) : 
                         b1ivld4 ? (cfgseq4 ? idat4[23:16] : b1prbs4) : 
                         b0ivld4 ? (cfgseq4 ? idat4[31:24] : b0prbs4) : oprbs4;

assign          errseq4[0] = b0ivld4 & (idat4[31:24] != oprbs4[7:0] + 8'd1);
assign          errseq4[1] = b1ivld4 & (idat4[23:16] != oprbs4[7:0] + 8'd2);
assign          errseq4[2] = b2ivld4 & (idat4[15:8] != oprbs4[7:0] + 8'd3);
assign          errseq4[3] = b3ivld4 & (idat4[7:0] != oprbs4[7:0] + 8'd4);

assign          curerr4 = (cfgseq4 ? |errseq4 : |err4);
assign          icfgseq4 = cpu_re4 & !cpu_rnw ? updi1[0] : cfgseq4;

af6ces48rtl_prbscheck b0mon (.ivld(b0ivld4),.idat(idat4[31:24]),.iprbs(oprbs4),.oprbs(b0prbs4),.oerr(err4[0]),.osyn(syn4[0]));
af6ces48rtl_prbscheck b1mon (.ivld(b1ivld4),.idat(idat4[23:16]),.iprbs(b0prbs4),.oprbs(b1prbs4),.oerr(err4[1]),.osyn(syn4[1]));
af6ces48rtl_prbscheck b2mon (.ivld(b2ivld4),.idat(idat4[15:8]),.iprbs(b1prbs4),.oprbs(b2prbs4),.oerr(err4[2]),.osyn(syn4[2]));
af6ces48rtl_prbscheck b3mon (.ivld(b3ivld4),.idat(idat4[7:0]),.iprbs(b2prbs4),.oprbs(b3prbs4),.oerr(err4[3]),.osyn(syn4[3]));

// CEP monitor B3/V5 in case 8-bit mode only
wire [13:0]     ob3cnt4,ib3cnt4;
assign          ob3cnt4 = oprbs4[13:0];
assign          ib3cnt4 = ivld4 & icepj1v54 ? 9'd2 : // reset by external J1
                          ivld4             ? ob3cnt4 + 1'b1 : ob3cnt4;

wire            cfgb3mod4 = (|icepmod4);
wire            cfgv5mod4 = !cfgb3mod4;

wire [7:0]      cepdat4 = idat4[31:24];
wire [7:0]      ob3sum4,ib3sum4;
assign          ib3sum4 = ivld4 & cfgb3mod4 ? (icepj1v54 ? cepdat4 : ob3sum4^cepdat4) : 
                          ivld4 & cfgv5mod4 ? (icepj1v54 ? 2'b00 : ob3sum4[1:0])^cepdat4[7:6]^cepdat4[5:4]^cepdat4[3:2]^cepdat4[1:0] :  
                                            ob3sum4;

wire [7:0]      ob3pre4,ib3pre4;
assign          ib3pre4 = ivld4 & icepj1v54 ? ob3sum4 : ob3pre4;

wire [13:0]     b3poscnt4 = (ivld4 & icepj1v54) ? 14'd1 : ob3cnt4;
//wire [13:0]     cfgb3pos4 = (icepmod4 == 2'd1) ? 14'd88 : (icepmod4 == 2'd2) ? 14'd262 : 14'd1045;
wire [13:0]     cfgb3pos4 = (icepmod4 == 2'd1) ? 14'd86 : (icepmod4 == 2'd2) ? 14'd262 : 14'd1045;// fixed for mode TU3 basic
wire            b3pos4   = ivld4 & (b3poscnt4 == cfgb3pos4);
wire            b3v5err4 = cfgb3mod4 ? b3pos4 & (|(ob3pre4^cepdat4)) : ivld4 & icepj1v54 & (ob3sum4[1:0] != cepdat4[7:6]);

// Mux status
assign          ierr4 = ivld4 ? oerr4 | (icep4 ? b3v5err4 : curerr4) : !cpu_rnw;
assign          isyn4 = ivld4 ? (|syn4) | cfgseq4 | icep4 : osyn4;

wire [14:0]     iprbsb3cnt4 = ivld4 ? (icep4 ? ib3cnt4 : iprbs4) : oprbs4;


wire            status_we;
wire [LID-1:0]  status_wa;
wire [33:0]     status_wrd;
wire            status_re;
wire [LID-1:0]  status_ra;
wire [33:0]     status_rdd;

wire [31:0]     updo;
assign          updo[31:18] = 14'd0;
wire [17:0]     nupdo = cpu_re4 ? {oerr4,osyn4,ob3sum4[0],oprbs4[13:0],cfgseq4} : upen1 ? updo[16:0] : 17'd0;
fflopx #(18) iupdo (clk,rst,nupdo,updo[17:0]);
fflopx #(1) iuprdy (clk,rst,cpu_re4,uprdy);

wire [33:0]     istatus5;
fflopx #(34) status5 (clk,rst,{ib3sum4[7:0],ib3pre4[7:0],ierr4,isyn4,iprbsb3cnt4[14:0],icfgseq4},istatus5);

rtlconflict113x #(LID,34) status_ctrl 
    (.clk(clk),
     .rst(rst),

      // Engine Read/write interface
     .eng_re(ram_re1),
     .eng_ra(ram_ra1),
     .eng_rdd3({ob3sum4[7:0],ob3pre4[7:0],oerr4,osyn4,oprbs4[14:0],cfgseq4}),
     .eng_wrd4(istatus5),

     // RAM or Register File Interface
     .memwe(status_we),
     .memre(status_re),
     .memwa(status_wa),
     .memwrd(status_wrd),
     .memra(status_ra),
     .memrdd(status_rdd)
     );

iarray113x #(LID,{1'b1,{LID{1'b0}}},34,"AUTO",0,"ON") memstatus
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

////////////////////////////////////////////////////////////////////////////////
// Debug
`ifdef  RTL_PRBSMON_DISPLAY
wire [LID-1:0]      ilid2,ilid3,ilid4;
fflopx #(LID) ppilid1 (clk,rst,ilid1,ilid2);
fflopx #(LID) ppilid2 (clk,rst,ilid2,ilid3);
fflopx #(LID) ppilid3 (clk,rst,ilid3,ilid4);

always @ (posedge clk)
    begin
    if (ivld4 & (icep4 ? b3v5err4 : curerr4))   $fdisplay(tbmon,"%m pw%h errdat %h @time %t",ilid4,idat4,$time);   
    end
`endif
endmodule 
