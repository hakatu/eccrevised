////////////////////////////////////////////////////////////////////////////////
//                                                                              
// Arrive Technologies                                                          
//------------------------------------------------------------------------------
// Filename     : ipsmacge_txframing.v                                                
// Description  : -> interface with 1 port triple speech 10/100/1000 Mps        
//              : -> from phys to mac interface                                 
//              :                                                               
//                                                                              
// Author       : nduytuqn@yahoo.com                                            
// Created On   : Mon Jun 09 12:42:14 2008
// History      :(Date, Changed By)                                             
//                                                                              
////////////////////////////////////////////////////////////////////////////////
module ipsmacge_txframing
    (
     txrst_,
     txclk,
     // from speed cotrol
     spdstable,
     // to phy common mode
     ogdat,
     ogen,
     oger,
     ogval,
     // input from txfifoconv2clk (Mac Process)
     ma_idat,
     ma_ieop,  
     ma_ierr,
     ma_inew,
     
     ma_oreq,
     ma_paudis,
     // input from pause frame gen
     pa_ien,
     pa_off,
     pa_idi,
     
     pa_oval,

     isouradd,
     oquanta,
     // cpu interface
     up_txen,
     up_datstt,
     up_act,
     up_paddis,
     up_fcsins,
     up_paudis,
     up_forcetxer,
     up_mspd,
     up_mprm,
     thsh_igap
     );

///////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;
parameter DAT_EW = 3;
parameter CNT_DW = 6;
parameter MSP_DW = 2; // mode speed operation
parameter DAT_PRM = 8'h55,
          DAT_SFD = 8'hD5;

// state machine
parameter STT_DW = 4;

// state machine
parameter STT_IGAP = 4'd0,
          STT_IRDY = 4'd1,
          STT_IPRM = 4'd2,
          STT_IPAY = 4'd3,
          STT_IFCS = 4'd4,
          STT_IFCE = 4'd5,
          STT_IPAU = 4'd6,
          STT_IPAD = 4'd7,
          STT_IDIS = 4'd8;

parameter MRESERVE = 2'b11, // reserve
          M1000    = 2'b10, // speed 1000 Mbps, clk 125Mhz
          M100     = 2'b01, // speed 100 Mbps , clk 25Mhz, 
          M10      = 2'b00; // speed 10 Mbps  , clk 2.5Mhz

parameter THSH_GAP = 5;
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
// Help
// {mgmii,mspd}
// {1,00} -> MII   speed 10   Mbps, clk 2.5Mhz
// {1,01} -> MII   speed 100  Mbps, clk 25Mhz
// {1,1x} -> GMII  speed 1000 Mbps, clk 125Mhz
// {0,00} -> RGMII speed 10   Mbps, clk 2.5Mhz
// {0,01} -> RGMII speed 100  Mbps, clk 25Mhz
// {0,1x} -> RGMII speed 1000 Mbps, clk 125Mhz



// PAUSE
parameter PAU_QW = 16; // quanta width
parameter PAU_AW = 48; // source address width
parameter PAU_DA = 48'h01_80_C2_00_00_01;
parameter PAU_TYPE = 16'h88_08;
parameter PAU_OPCODE = 16'h00_01;

parameter BYTE_DA1 = 6'd0,
          BYTE_DA2 = 6'd1,
          BYTE_DA3 = 6'd2,
          BYTE_DA4 = 6'd3,
          BYTE_DA5 = 6'd4,
          BYTE_DA6 = 6'd5,
          //
          BYTE_SA1 = 6'd6,
          BYTE_SA2 = 6'd7,
          BYTE_SA3 = 6'd8,
          BYTE_SA4 = 6'd9,
          BYTE_SA5 = 6'd10,
          BYTE_SA6 = 6'd11,
          // type
          BYTE_TY1 = 6'd12,
          BYTE_TY2 = 6'd13,
          // opcode
          BYTE_OP1 = 6'd14,
          BYTE_OP2 = 6'd15,
          // quanta
          BYTE_QU1 = 6'd16,
          BYTE_QU2 = 6'd17,
          BYTE_END = 6'd59;
////////////////////////////////////////////////////////////////////////////////
// input declarations
input               txrst_;
input               txclk;
// from speed control
input               spdstable;
// gmii
output [DAT_DW-1:0] ogdat;
output              ogen;
output              oger;
output              ogval;
// input from txfifoconv2clk
input  [DAT_DW-1:0] ma_idat;
input               ma_ieop;

input [DAT_EW-1:0]  ma_ierr; // ma_ierr [2] Force FCS ERROR
                             // ma_ierr [1] INSERT TXER to PHYs
                             // ma_ierr [0] 1: Transparent (no insert FCS, PAD)
                             //             0: Normal (Insert FCS, PAD)

input               ma_inew;

output              ma_oreq;

output              ma_paudis;

// input from pause gen
output              pa_oval;

input               pa_ien; // engine request
input               pa_off; // Gen Pause off, quata = 0
input               pa_idi; // Pause terminate stop transmit

input [47:0]        isouradd;
input [15:0]        oquanta;
// cpu interface
input               up_act;
input               up_txen;

input               up_paddis;
input               up_fcsins;
input               up_paudis;

input               up_forcetxer;
input [DAT_DW-1:0]  up_datstt;

input [3:0]         up_mprm;
input [MSP_DW-1:0]  up_mspd;
input [CNT_DW-2:0]  thsh_igap;

////////////////////////////////////////////////////////////////////////////////
// signal declarations0
wire                 req_val;
reg                  eng_val;
wire                 eng_val1;
wire                 eng_ival;
//
wire [STT_DW-1:0]    stt_mach;
wire                 rdy_en;
wire                 prm_en;
wire                 sop_en;
wire                 eop_en;
wire                 eof_en;
wire                 sfd_en;
wire                 pad_en;
wire                 fcs_en;
wire                 fcs_er;

// cnt_byte
reg [CNT_DW-1:0]     cnt_byte;
// fcs
reg [31:0]           fcs_dat;
wire [31:0]          crc_dat;
wire                 crc_val;
// gmii
wire [DAT_DW-1:0]    ogdat;
wire                 ogval;
wire                 ogen;
wire                 oger;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// Pau pro
wire                 opauen;
wire                 opaudi;
//---------------------------------------------
//  Input mux between pau and mac
//---------------------------------------------
assign pa_oval = req_val;
//---------------------------------------------
//  Mode speed control
//---------------------------------------------
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        eng_val <= 1'b0;
    else if (~up_act)   eng_val <= 1'b0;
    else                eng_val <= (up_mspd [1:0] == 2'b11) ? 1'b0 :
                                   up_mspd [1] ? 1'b1 : ~eng_val;
    end

fflopx #(1) ffreqval1 (txclk, txrst_, eng_val, eng_val1);
assign req_val  = up_mspd [1] ? eng_val : eng_val1;
assign eng_ival = eng_val;
//---------------------------------------------
//  State machine operations
//---------------------------------------------

assign fcs_en = (~ma_ierr [0]) & ma_ieop;
assign fcs_er = ( ma_ierr [2]);

wire   sttmiipg;
wire   sttmirdy;
wire   sttmiprm;
wire   sttmipay;
wire   sttmipau;
wire   sttmipad;
wire   sttmifcs;
wire   sttmifce;
wire   sttmidis;

assign sttmiipg = (stt_mach == STT_IGAP);
assign sttmirdy = (stt_mach == STT_IRDY);
assign sttmiprm = (stt_mach == STT_IPRM);
assign sttmipay = (stt_mach == STT_IPAY);
assign sttmipau = (stt_mach == STT_IPAU);
assign sttmipad = (stt_mach == STT_IPAD);
assign sttmifcs = (stt_mach == STT_IFCS);
assign sttmifce = (stt_mach == STT_IFCE);
assign sttmidis = (stt_mach == STT_IDIS);

assign rdy_en = sttmiipg & (cnt_byte >= (thsh_igap - 2'd2));

wire   eop_ar;// eop pad
assign eop_ar = (~ma_ierr [0]) & ma_ieop;

assign eof_en = ((ma_ierr [0] & ma_ieop)                    |
                 (eop_ar & (~up_fcsins))                    |
                 ((sttmifcs | sttmifce) & (cnt_byte >= 6'd3))
                  );

assign prm_en = ((opauen | (ma_inew & (~opaudi)))
                  ) & sttmirdy;

assign pad_en = (sttmipay & (cnt_byte <= 6'd58)) & (eop_ar & (~up_paddis));
          
assign eop_en = ((sttmipad & (cnt_byte >= 6'd59))                               |
                 (sttmipau & (cnt_byte >= 6'd59))                               |
                 (sttmipay & (cnt_byte <= 6'd58) & eop_ar & up_paddis)          |
                 (sttmipay & (cnt_byte >= 6'd59) & eop_ar)
                 );

assign sfd_en = (((cnt_byte >= {2'b0, up_mprm [3:0]}))
                  ) & sttmiprm & eng_ival;

assign sop_en = sfd_en;

ipsmacge_txstatem itxstatem
    (
     .txrst_    (txrst_),
     .txclk     (txclk),
     // Request
     .reqvld    (eng_ival), 
     // Info
     .rdy_en    (rdy_en),
     .prm_en    (prm_en),
     .sop_en    (sop_en),
     .pad_en    (pad_en),
     .eop_en    (eop_en),
     .eof_en    (eof_en),

     .pau_en    (opauen),
     .pau_di    (opaudi),
     
     .fcs_en    (fcs_en),
     .fcs_er    (fcs_er),
     // Stable
     .istable   (1'b1),
     // output
     .stt_mach  (stt_mach),
     .stt_mach1 (stt_mach),
     // config
     .up_en     (up_act & up_txen)
     );


ipsmacge_paupro ipaupro
    (
     .txrst_    (txrst_),
     .txclk     (txclk),
     .ipauen    (pa_ien),
     .ipaudi    (pa_idi),
     .possfd    (sfd_en),
     //
     .opauen    (opauen),
     .opaudi    (opaudi),
     //
     .ppaudis   (up_paudis)
     );

reg    ma_paudis;
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)    ma_paudis <= 1'b0;
    else            ma_paudis <= 1'b1;
//    else            ma_paudis <= (sttmidis | opaudi) ? 1'b1 : 1'b0;
    end
//---------------------------------------------
//  Out put reqest data
//---------------------------------------------
assign ma_oreq = req_val & (((~opauen) & sfd_en & up_mspd [1]) | (sttmipay & (~ma_ieop)));
//---------------------------------------------
//  Counter bytes
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)         cnt_byte <= {THSH_GAP{1'b0}};
    else if (~up_act)    cnt_byte <= {THSH_GAP{1'b0}};
    else if (eng_ival)
        begin
        if (rdy_en)      cnt_byte <= {THSH_GAP{1'b1}};
        else if (prm_en) cnt_byte <= {THSH_GAP{1'b0}};
        else if (sfd_en) cnt_byte <= {THSH_GAP{1'b0}};    
        else if (eop_en) cnt_byte <= {THSH_GAP{1'b0}};
        else if (eof_en) cnt_byte <= {THSH_GAP{1'b0}};
        else             cnt_byte <= &cnt_byte ? cnt_byte : cnt_byte + 1'b1;
        end
    end                            
                          
//--------------------------------------------- 
//  PAU and PAD insert
 
wire        pau_off;
assign      pau_off = pa_off;

reg [7:0] ins_dat;
always @(stt_mach or cnt_byte or pau_off or ma_idat or isouradd or oquanta)
    begin
    case (stt_mach)
        STT_IPAD:           ins_dat = {DAT_DW{1'b0}};
        STT_IPAY:           ins_dat = ma_idat;
        STT_IPAU:
            begin
            case (cnt_byte)
                BYTE_DA1:   ins_dat = PAU_DA [47:40];
                BYTE_DA2:   ins_dat = PAU_DA [39:32];
                BYTE_DA3:   ins_dat = PAU_DA [31:24];
                BYTE_DA4:   ins_dat = PAU_DA [23:16];
                BYTE_DA5:   ins_dat = PAU_DA [15:8];
                BYTE_DA6:   ins_dat = PAU_DA [7:0];
                //
                BYTE_SA1:   ins_dat = isouradd [47:40];
                BYTE_SA2:   ins_dat = isouradd [39:32];
                BYTE_SA3:   ins_dat = isouradd [31:24];
                BYTE_SA4:   ins_dat = isouradd [23:16];
                BYTE_SA5:   ins_dat = isouradd [15:8];
                BYTE_SA6:   ins_dat = isouradd [7:0];
                // ethernet type
                BYTE_TY1:   ins_dat = PAU_TYPE [15:8];    
                BYTE_TY2:   ins_dat = PAU_TYPE [7:0];
                // opcode   
                BYTE_OP1:   ins_dat = PAU_OPCODE [15:8];
                BYTE_OP2:   ins_dat = PAU_OPCODE [7:0];
                // quanta
                BYTE_QU1:   ins_dat = pau_off ? {DAT_DW{1'b0}} : oquanta [15:8];
                BYTE_QU2:   ins_dat = pau_off ? {DAT_DW{1'b0}} : oquanta [7:0];
                default:    ins_dat = {DAT_DW{1'b0}};
            endcase
            end
        default:            ins_dat = {DAT_DW{1'b0}};
    endcase
    end


//---------------------------------------------
//  Insert Preamble and CRC
//---------------------------------------------
assign crc_val = eng_ival & (sttmipad |
                             sttmipau |
                             sttmipay
                             );

// crc caculator
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)      fcs_dat <= {32{1'b1}};
    else if (prm_en)  fcs_dat <= {32{1'b1}};
    else if (crc_val) fcs_dat <= crc_dat;
//    else            fcs_dat <= crc_pr;
    end
// crc 32
ippcrc_crc32_8b icrc32_8b
    (
     .ci    (fcs_dat),
     .di    (ins_dat),
     
     .co    (crc_dat)
     );
/*
ipsmacge_crc32_1oct #(DAT_DW) ipsmacge_crc32_1oct 
    (
     .din    (eng_idat),
     .lsb    (1'b1),
     .crcin  (fcs_dat),
     .crcout (crc_dat)
     );
*/
////////////////////////////
// process insert

ipsmacge_txinsert itxinsert
    (
     .txrst_    (txrst_),
     .txclk     (txclk),
     .pena      (eng_ival),
     // status
     .idat_stt  (up_datstt),
     .isfd      (sfd_en),
     .isttm     (stt_mach),
     .icnt      (cnt_byte [5:0]),
     .icrc      (fcs_dat),
     // input
     .ierr      (ma_ierr [1] | up_forcetxer),
     .idat      (ins_dat),
     // config
     .uptxen    (up_txen),
     .spdstable (spdstable),
     // output
     .oer       (oger),
     .oen       (ogen),
     .odat      (ogdat)
     );

fflopx #(1) ffengval1 (txclk, txrst_, eng_ival, ogval);

endmodule
