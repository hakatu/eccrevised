////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtlintx.v
// Description  : .
//
// Author       : lqcuong@HW-LQCUONG
// Created On   : Mon Aug 03 11:35:02 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module at6rtlint115wrp
    (
     iclk,
     rst,
     ipactive,

     ialrmrest,

     iupen,
     iupa,
     iupws,
     iuprs,
     iupdi,
     ouprdy,
     oupdo,
     oupint,

     idtvl,
     isegid,
     ibitid,
     
     istyreq,
     ista,
     ista_msk,
     ista_chgen,
     iinttypeen,
     
     //Channel buffer: iarray113x or iarray112x pipeline input
     ochwe,
     ochwa,     
     ochwrd,    
     ochre,
     ochra,
     ichrdd,

     //Segment buffer: iarray113x or iarray112x pipeline input
     osegwe,
     osegwa,
     osegwrd,
     osegre,
     osegra,
     isegrdd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter   STYW        = 5;
parameter   STAW        = 5;
parameter   STCHEW      = 5;    //Enable to monitor change to generate interrupt

parameter   SEGB        = 4;    //Bit of segment ID
parameter   BITB        = 5;    //Bit of Bit ID

parameter   BITNUM      = 32;
parameter   SEGNUM      = 12;

parameter   UPW         = 32;   //Maximum bits between 2*styw + staw and bits in a segment

parameter   UPA         = SEGB + BITB + 2;

parameter   CHAW        = SEGB + BITB;
parameter   CHDW        = 2*STYW + STAW;

parameter   SEGAW       = SEGB;
parameter   SEGDW       = BITNUM;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               iclk;
input               rst;
input               ipactive;

input               ialrmrest;

input               iupen;
input [UPA-1:0]     iupa;
input               iupws;
input               iuprs;
input [UPW-1:0]     iupdi;
output              ouprdy;
output [UPW-1:0]    oupdo;
output              oupint;

input               idtvl;          //Data valid
input [SEGB-1:0]    isegid;         //Segment ID (such as sts
input [BITB-1:0]    ibitid;         //Bit ID in the segment such as VT
input [STYW-1:0]    istyreq;        //Request to set Sticky in the sticky area
input [STAW-1:0]    ista;           //Status to write into status area.
                                    //Note: Bits, being enabled to monitor state change for generating
                                    //interrupt, have to be started from 0  
input [STAW-1:0]    ista_msk;       //bit set to enable the related to be updated in the status area
input [STCHEW-1:0]  ista_chgen;     //Eanble to monitor change of input status to set related sticky.
                                    //NOTE: bit[i] enable for status [i] and the sticky #i will be set  
input [STYW-1:0]    iinttypeen;     //Enable per type interrupt enable to help quick disable from SW, set 1 to enable, set 0 to clear
////////////////////////////////////////
//Per channel buffer: contain sticky, current status and interrupt enable
//Array112x
//Address: {isegid,ibitid}
//Data:
//[STYW-1:0]            : sticky area
//[STYW+STAW-1:STYW]    : status area
//[CHDW-1:CHDW-STYW]    : Interrupt enable erea
output              ochwe;
output [CHAW-1:0]   ochwa;
output [CHDW-1:0]   ochwrd;
output              ochre;
output [CHAW-1:0]   ochra;
input [CHDW-1:0]    ichrdd;

////////////////////////////////////////
//Per channel interrupt OR status
//Array112x
//Address: isegid
//bit[i]: Interrupt OR status of channel i in the related segment
output              osegwe;
output [SEGAW-1:0]  osegwa;
output [SEGDW-1:0]  osegwrd;
output              osegre;
output [SEGAW-1:0]  osegra;
input [SEGDW-1:0]   isegrdd;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

////////////////////////////////////////////////////////////////////////////////
// Pipeline per channel buffer ram
wire                chwe;
wire   [CHAW-1:0]   chwa;
wire   [CHDW-1:0]   chwrd;
wire                chre;
wire   [CHAW-1:0]   chra;
wire  [CHDW-1:0]    chrdd;
fflopx #(2+2*CHAW+2*CHDW) ppchram (iclk,rst,{chwe,chwa,chwrd,chre,chra,ichrdd},{ochwe,ochwa,ochwrd,ochre,ochra,chrdd});

////////////////////////////////////////////////////////////////////////////////
//                  Clear status to raise interrupt in case of alarm
parameter   IDLE        = 4'd0;
parameter   PREREAD     = 4'd1; //Read current status
parameter   WAIT1       = 4'd2; //Wait status
parameter   WAIT2       = 4'd3; //Wait status
parameter   WAIT3       = 4'd4; //Wait status
parameter   WAIT4       = 4'd5; //Wait status
parameter   WAIT5       = 4'd6; //Wait status
parameter   CLEARSTA    = 4'd7; //Write status = 0
parameter   SETSTK      = 4'd8; //Write old value to set sticky for current status = 1

parameter   CNTB        = BITB + SEGB;

wire [2:0]         alrmrestpl;

fflopx #(3) alrmrestpli
    (iclk,rst,{alrmrestpl[1:0],ialrmrest},alrmrestpl);

wire                alrmrestpos  = alrmrestpl[1] & (!alrmrestpl[2]);

reg [CNTB-1:0]      alrmrestcnt = 0;
reg                 dtvli;
reg [SEGB-1:0]      segidi;
reg [BITB-1:0]      bitidi;

reg [STYW-1:0]      styreqi;
reg [STAW-1:0]      stai;
reg [STAW-1:0]      stalat;
reg [STAW-1:0]      sta_mski;
reg [STCHEW-1:0]    sta_chgeni;
reg [STYW-1:0]      inttypeen;

reg [3:0]           alrmreststate = 4'd0;

wire               alrmregvl    = |{alrmrestcnt,alrmrestpos};



always @(posedge iclk)
    begin

        case(alrmreststate)
            IDLE:
                begin
                alrmreststate   <= alrmrestpos ? PREREAD : IDLE;
                alrmrestcnt     <= {SEGB{1'b0}};
                dtvli       <= idtvl;
                segidi      <= isegid;
                bitidi      <= ibitid;
                styreqi     <= istyreq;
                stai        <= ista;
                sta_mski    <= ista_msk;
                sta_chgeni  <= ista_chgen;
                inttypeen   <= iinttypeen;              
                end
            PREREAD:
                begin
                dtvli       <= 1'b1;
                segidi      <= alrmrestcnt[CNTB-1:BITB];
                bitidi      <= alrmrestcnt[BITB-1:0];
                styreqi     <= {STYW{1'b0}};
                stai        <= {STAW{1'b0}};
                sta_mski    <= {STAW{1'b0}};
                sta_chgeni  <= {STCHEW{1'b1}};
                inttypeen   <= {STYW{1'b1}};                
                
                alrmreststate   <= WAIT1;
                end
            WAIT1:
                begin
                dtvli           <= 1'b0;
                alrmreststate   <= WAIT2;
                end
            WAIT2:
                begin
                dtvli           <= 1'b0;
                alrmreststate   <= WAIT3;
                end
            WAIT3:
                begin
                dtvli           <= 1'b0;
                alrmreststate   <= WAIT4;
                end
            WAIT4:
                begin
                dtvli           <= 1'b0;
                alrmreststate   <= WAIT5;
                end
            WAIT5:
                begin
                dtvli           <= 1'b0;
                alrmreststate   <= CLEARSTA;
                end
            CLEARSTA:
                begin
                dtvli           <= 1'b1;
                segidi          <= alrmrestcnt[CNTB-1:BITB];
                bitidi          <= alrmrestcnt[BITB-1:0];
                styreqi         <= {STYW{1'b0}};
                stai            <= {STAW{1'b0}};
                sta_mski        <= {STAW{1'b1}};
                sta_chgeni      <= {STCHEW{1'b1}};
                inttypeen       <= {STYW{1'b1}};                
                
                stalat          <= chrdd[STYW+STAW-1:STYW];
                alrmreststate   <= SETSTK;
                end
            SETSTK:
                begin
                dtvli           <= 1'b1;
                segidi          <= alrmrestcnt[CNTB-1:BITB];
                bitidi          <= alrmrestcnt[BITB-1:0];
                styreqi         <= {STYW{1'b0}};
                stai            <= stalat;
                sta_mski        <= {STAW{1'b1}};
                sta_chgeni      <= {STCHEW{1'b1}};
                inttypeen       <= {STYW{1'b1}};                
                
                alrmreststate   <= &alrmrestcnt ? IDLE: PREREAD;
                
                alrmrestcnt     <= alrmrestcnt + 1'b1;
                end
            default:
                begin
                alrmreststate   <= IDLE;
                dtvli           <= 1'b0;
                end
        endcase
        
    end

at6rtlint113  #(STYW,STAW,STCHEW,SEGB,BITB,BITNUM,SEGNUM,UPW) at6rtlintxi    
    (
     .iclk      (iclk),
     .rst       (rst),
     .ipactive  (ipactive),

     .iupen     (iupen),
     .iupa      (iupa),
     .iupws     (iupws),
     .iuprs     (iuprs),
     .iupdi     (iupdi),
     .ouprdy    (ouprdy),
     .oupdo     (oupdo),
     .oupint    (oupint),

     .idtvl     (dtvli),
     .isegid    (segidi),
     .ibitid    (bitidi),
    
     .istyreq   (styreqi),
     .ista      (stai),
     .ista_msk  (sta_mski),
     .ista_chgen(sta_chgeni),
     .iinttypeen(inttypeen),

     //Channel buffer: array115x
     .ochwe     (chwe),
     .ochwa     (chwa),     
     .ochwrd    (chwrd),    
     .ochre     (chre),
     .ochra     (chra),
     .ichrdd    (chrdd),

     //Segment buffer: array113x
     .osegwe    (osegwe),
     .osegwa    (osegwa),
     .osegwrd   (osegwrd),
     .osegre    (osegre),
     .osegra    (osegra),
     .isegrdd   (isegrdd)
     );


endmodule 
