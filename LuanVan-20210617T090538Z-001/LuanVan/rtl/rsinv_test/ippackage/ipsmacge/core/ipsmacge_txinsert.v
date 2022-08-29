////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_txinsert.v
// Description  : .
//
// Author       : HW-NDTU <tund@atvn.com.vn>
// Created On   : Thu Apr 09 16:41:43 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_txinsert
    (
     txrst_,
     txclk,
     pena,
     // status
     idat_stt,
     isfd,
     isttm, // state machine
     icnt,
     icrc,
     // input
     ierr,
     idat,
     //
     uptxen,
     spdstable,
     // output
     oer,
     oen,
     odat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;
parameter CNT_DW = 6;
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

parameter FCSB1 = 6'd0,
          FCSB2 = 6'd1,
          FCSB3 = 6'd2,
          FCSB4 = 6'd3;

parameter DAT_SFD = 8'hD5,
          DAT_PRM = 8'h55;
////////////////////////////////////////////////////////////////////////////////
// input declarations
input     txrst_;
input     txclk;

input [DAT_DW-1:0] idat;
input              ierr;

input [DAT_DW-1:0] idat_stt;
input              pena;
input              isfd;
input [STT_DW-1:0] isttm;
input [CNT_DW-1:0] icnt;
input [31:0]       icrc;

input              uptxen;
input              spdstable; //1'b1: speed stable, 1'b0: speed unstable

output [DAT_DW-1:0] odat;
output              oen;
output              oer;
////////////////////////////////////////////////////////////////////////////////
// signal declarations
reg    [DAT_DW-1:0] odat;
reg                 oen;
reg                 oer;
wire [31:0]         icrc_inv;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
assign icrc_inv = {icrc[24],icrc[25],icrc[26],icrc[27],icrc[28],icrc[29],icrc[30],icrc[31],
                   icrc[16],icrc[17],icrc[18],icrc[19],icrc[20],icrc[21],icrc[22],icrc[23],
                   icrc[8] ,icrc[9] ,icrc[10],icrc[11],icrc[12],icrc[13],icrc[14],icrc[15],
                   icrc[0] ,icrc[1] ,icrc[2] ,icrc[3] ,icrc[4] ,icrc[5] ,icrc[6] ,icrc[7]};

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        odat <= {DAT_DW{1'b0}};
    else if (!uptxen)   odat <= {DAT_DW{1'b0}};
    else if (~spdstable)odat <= idat_stt;          
    else if (pena)
        begin
        case (isttm)
            STT_IPRM:   odat <= isfd ? DAT_SFD  : DAT_PRM;
            STT_IFCS:   odat <= (icnt == FCSB1) ? icrc_inv [31:24] ^ 8'hff :
                                (icnt == FCSB2) ? icrc_inv [23:16] ^ 8'hff :
                                (icnt == FCSB3) ? icrc_inv [15: 8] ^ 8'hff :
                                icrc_inv [ 7: 0] ^ 8'hff;
            STT_IFCE:   odat <= (icnt == FCSB1) ? icrc_inv [31:24]:
                                (icnt == FCSB2) ? icrc_inv [23:16]:
                                (icnt == FCSB3) ? icrc_inv [15: 8]:
                                icrc_inv [ 7: 0];
            STT_IGAP:   odat <= idat_stt;
            STT_IRDY:   odat <= idat_stt;
            STT_IDIS:   odat <= idat_stt;
            default:    odat <= idat;
        endcase
        end
    end

// oena
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        oen <= 1'b0;
    else if (~uptxen)   oen <= 1'b0;
    else if (~spdstable)oen <= 1'b0;
    else if (pena)
        begin
        case (isttm)
            STT_IGAP:   oen <= 1'b0;
            STT_IRDY:   oen <= 1'b0;
            STT_IDIS:   oen <= 1'b0;
            default:    oen <= 1'b1;
        endcase
        end
    end

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        oer <= 1'b0;
    else if (~uptxen)   oer <= 1'b0;
    else if (~spdstable)oer <= 1'b0;
    else if (pena)
        begin
        case (isttm)
            STT_IPAY:   oer <= ierr;
            STT_IFCS:   oer <= ierr;
            default:    oer <= 1'b0;
        endcase
        end
    end

endmodule
