////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_txstatem.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Mon Apr 13 16:22:14 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_txstatem
    (
     txrst_,
     txclk,
     //
     reqvld,
     // 
     rdy_en,
     prm_en,
     sop_en,
     pad_en,
     eop_en,
     eof_en,

     pau_en,
     pau_di,
     
     fcs_en,
     fcs_er,
     // Stable
     istable,
     // output
     stt_mach,
     stt_mach1,
     // config
     up_en
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter STT_DW   = 4;

parameter STT_IGAP = 4'd0,
          STT_IRDY = 4'd1,
          STT_IPRM = 4'd2,
          STT_IPAY = 4'd3,
          STT_IFCS = 4'd4,
          STT_IFCE = 4'd5,
          STT_IPAU = 4'd6,
          STT_IPAD = 4'd7,
          STT_IDIS = 4'd8;

////////////////////////////////////////////////////////////////////////////////
// input declarations
input               txrst_;
input               txclk;

input               reqvld;

input               rdy_en;
input               prm_en;
input               sop_en;
input               pad_en;
input               eop_en;
input               eof_en;

input               pau_en;
input               pau_di;

input               fcs_en;
input               fcs_er;
     // Output
input  [STT_DW-1:0] stt_mach;
output [STT_DW-1:0] stt_mach1;
     // Stable
input               istable;
     // config
input               up_en;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
reg [STT_DW-1:0]    stt_mach1;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        stt_mach1  <= STT_IGAP;
    else if (~up_en)    stt_mach1  <= STT_IGAP;
    else if (~istable)  stt_mach1  <= STT_IGAP;
    else if (reqvld)
        begin
        case (stt_mach)
            STT_IGAP:   stt_mach1 <=  rdy_en    ? STT_IRDY : STT_IGAP;
            STT_IRDY:   stt_mach1 <=  pau_en    ? STT_IPRM :
                                      pau_di    ? STT_IDIS : 
                                      prm_en    ? STT_IPRM : STT_IRDY;
                                      
            STT_IPRM:   stt_mach1 <=  eof_en    ? STT_IGAP :
                                      sop_en    ? (pau_en  ? STT_IPAU : STT_IPAY) : STT_IPRM;
            STT_IPAU:   stt_mach1 <=  eop_en    ? STT_IFCS : STT_IPAU;
            STT_IPAY:   stt_mach1 <=  eof_en    ? STT_IGAP :
                                      eop_en    ? (fcs_en  ? (fcs_er ? STT_IFCE : STT_IFCS): STT_IGAP) :
                                      pad_en    ? STT_IPAD : STT_IPAY;
            STT_IPAD:   stt_mach1 <=  eof_en    ? STT_IGAP :
                                      eop_en    ? (fcs_er  ? STT_IFCE : STT_IFCS) : STT_IPAD;
            STT_IFCS:   stt_mach1 <=  eof_en    ? STT_IGAP : 
                                      fcs_er    ? STT_IFCE : STT_IFCS;
            STT_IFCE:   stt_mach1 <=  eof_en    ? STT_IGAP : STT_IFCS;
            STT_IDIS:   stt_mach1 <=  pau_en    ? STT_IRDY :
                                      pau_di    ? STT_IDIS : STT_IRDY;
            default:    stt_mach1 <= STT_IGAP;
        endcase
        end
    end

endmodule
