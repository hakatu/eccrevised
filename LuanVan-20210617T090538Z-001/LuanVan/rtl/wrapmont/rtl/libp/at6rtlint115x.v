////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtlintx.v
// Description  : .
//
// Author       : lqcuong@HW-LQCUONG
// Created On   : Mon Aug 03 11:35:02 2009
// History (Date, Changed By) cuongnv@HW-NVCUONG Tue May 30 13:28:05 2017
// Change support to max 16384 channel
////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy = "yes" *) module at6rtlint115x
    (
     iclk,
     rst,
     ipactive,

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
     
     //Channel buffer: iarray115x or iarray113x pp in/out
     ochwe,
     ochwa,     
     ochwrd,    
     ochre,
     ochra,
     ichrdd,

     //Segment buffer: iarray113x
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

parameter   SEGB        = 9;    //Bit of segment ID
parameter   BITB        = 5;    //Bit of Bit ID

parameter   BITNUM      = 32;
parameter   SEGNUM      = 512;

parameter   UPW         = 32;   //Maximum bits between 2*styw + staw and bits in a segment

parameter   UPA         = SEGB + BITB + 2;

parameter   CHAW        = SEGB + BITB;
parameter   CHDW        = 2*STYW + STAW;

parameter   SEGAW       = SEGB;
parameter   SEGDW       = BITNUM;

localparam          SEGINSA = SEGB-5; // divide to 1024 instant
localparam          SEGINS = SEGNUM/32; // divide to 1024 instant

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               iclk;
input               rst;
input               ipactive;

input               iupen;
input [UPA-1:0]     iupa;
input               iupws;
input               iuprs;
input [UPW-1:0]     iupdi;
output              ouprdy;
output [UPW-1:0]    oupdo;
output [SEGINS-1:0] oupint;

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

// Pipeline input
reg                 upen_ppxxx = 1'b0/*synthesis preserve*/;
reg [UPA-1:0]       upa_ppxxx = {UPA{1'b0}}/*synthesis preserve*/;
reg  [UPW-1:0]      updi_ppxxx = {UPW{1'b0}}/*synthesis preserve*/;
reg                 ipactive1 = 1'b0,ipactive2 = 1'b0;
reg [STYW-1:0]      iinttypeen1 = {STYW{1'b0}};     //for mask sticky by high level defect, per channel
reg [STYW-1:0]      iinttypeen2 = {STYW{1'b0}};     //for mask sticky by high level defect, per channel
reg [STYW-1:0]      iinttypeen3 = {STYW{1'b0}};     //for mask sticky by high level defect, per channel
reg [STYW-1:0]      iinttypeen4 = {STYW{1'b0}};     //for mask sticky by high level defect, per channel
reg [STYW-1:0]      iinttypeen5 = {STYW{1'b0}};     //for mask sticky by high level defect, per channel

always @ (posedge iclk)
    begin
    {upen_ppxxx,upa_ppxxx,updi_ppxxx} <= {iupen,iupa,iupdi};
    {ipactive1,ipactive2} <= {ipactive,ipactive1};
    {iinttypeen1,iinttypeen2,iinttypeen3,iinttypeen4,iinttypeen5} <= {iinttypeen,iinttypeen1,iinttypeen2,iinttypeen3,iinttypeen4};                             
    end

////////////////////////////////////////////////////////////////////////////////
//                              Per channel buffer
////////////////////////////////////////////////////////////////////////////////
//wire [STYW-1:0]    iinttypeen1;     //for mask sticky by high level defect, per channel
//wire [STYW-1:0]    iinttypeen2;     //for mask sticky by high level defect, per channel
//fflopx #(STYW*2) ppiinttypeen (iclk,rst,{iinttypeen,iinttypeen1},{iinttypeen1,iinttypeen2});


////////////////////////////////////////
//Engine
reg [STYW-1:0]  istyreq1;
reg [STYW-1:0]  istyreq2,
                istyreq3,
                istyreq4,
                istyreq5;
reg [STAW-1:0]  ista1;
reg [STAW-1:0]  ista2,
                ista3,
                ista4,
                ista5;
reg [SEGB-1:0]  isegid1;
reg [SEGB-1:0]  isegid2,
                isegid3,
                isegid4,
                isegid5;
reg [BITB-1:0]  ibitid1;
reg [BITB-1:0]  ibitid2,
                ibitid3,
                ibitid4,
                ibitid5;
reg [STCHEW-1:0] ista_chgen1;
reg [STCHEW-1:0] ista_chgen2,
                 ista_chgen3,
                 ista_chgen4,
                 ista_chgen5;
reg [STAW-1:0]   ista_msk1;
reg [STAW-1:0]   ista_msk2,
                 ista_msk3,
                 ista_msk4,
                 ista_msk5;

wire            engchwrreq4;
wire            engchwrreq5;
wire            engchrdreq;

reg             engchrdreq1;
reg             engchrdreq2,
                engchrdreq3,
                engchrdreq4,
                engchrdreq5;

assign          engchrdreq  = idtvl & ipactive2;
assign          engchwrreq4  = engchrdreq4;
assign          engchwrreq5  = engchrdreq5;

wire [CHAW-1:0] engchra;
assign          engchra     = {isegid,ibitid};

wire [CHAW-1:0] engchwa;
assign          engchwa     = {isegid5,ibitid5};

always @(posedge iclk)
    begin
    if(rst)
        begin
        istyreq1    <= {STYW{1'b0}};
        istyreq2    <= {STYW{1'b0}};
        istyreq3    <= {STYW{1'b0}};    
        istyreq4    <= {STYW{1'b0}};    
        istyreq5    <= {STYW{1'b0}};    
       
        end
    else
        begin       

        istyreq1    <= istyreq;
        istyreq2    <= istyreq1;
        istyreq3    <= istyreq2; 
        istyreq4    <= istyreq3; 
        istyreq5    <= istyreq4; 
        end
    end

always @(posedge iclk)
    begin    
    ista_msk1   <= {STAW{idtvl}} & ista_msk;
    ista_msk2   <= ista_msk1;
    ista_msk3   <= ista_msk2;
    ista_msk4   <= ista_msk3;
    ista_msk5   <= ista_msk4;
   
    ista1       <= ista;
    ista2       <= ista1;
    ista3       <= ista2;
    ista4       <= ista3;
    ista5       <= ista4;
    isegid1     <= isegid;
    isegid2     <= isegid1;
    isegid3     <= isegid2;
    isegid4     <= isegid3;
    isegid5     <= isegid4;
    ibitid1     <= ibitid;
    ibitid2     <= ibitid1;
    ibitid3     <= ibitid2;
    ibitid4     <= ibitid3;
    ibitid5     <= ibitid4;
    ista_chgen1 <= ista_chgen;
    ista_chgen2 <= ista_chgen1;
    ista_chgen3 <= ista_chgen2;
    ista_chgen4 <= ista_chgen3;
    ista_chgen5 <= ista_chgen4;
    engchrdreq1 <= engchrdreq;
    engchrdreq2 <= engchrdreq1;
    engchrdreq3 <= engchrdreq2;
    engchrdreq4 <= engchrdreq3;
    engchrdreq5 <= engchrdreq4;
    end


////////////////////////////////////////
//CPU Interface

reg             iupws1,iupws2/*synthesis preserve*/;
reg             iuprs1,iuprs2/*synthesis preserve*/;

//Convention:
//- ro: read only
//- r2w: read to write (write only but have to read and then write
//- w2c: write to clear

//Configuration:
wire [CHAW-1:0] upcha;
assign          upcha   = upa_ppxxx[CHAW-1:0];

wire            upchcfgpen;     //Config pen
wire            upchcfgr2w;     //Read to write (write only)
wire            upchcfgro;      //read only
reg             upchcfgr2wlat;  //latch
reg             upchcfgrolat;   //latch
wire            upchcfgr2wwin;  //win
wire            upchcfgrowin;

//sticky
wire            upchstypen;     //Sticky pen
wire            upchstyw2c;     //write 1 to clear
wire            upchstyro;      //read only
wire            upchstyr2w;     //write only: in case of not pactive
reg             upchstyw2clat;  //latch
reg             upchstyrolat;   
reg             upchstyr2wlat;   
wire            upchstyr2wwin;  //win
wire            upchstyw2cwin;  //win
wire            upchstyrowin;

//Status
wire            upchstapen;     //Status pen
wire            upchstar2w;     //write only
wire            upchstaro;      //read only
reg             upchstar2wlat;  //latch
reg             upchstarolat;
wire            upchstar2wwin;  //win
wire            upchstarowin;

reg             upchcfgr2wwin1;  //win
reg             upchcfgrowin1;
reg             upchstyr2wwin1;  //win
reg             upchstyw2cwin1;  //win
reg             upchstyrowin1;
reg             upchstar2wwin1;  //win
reg             upchstarowin1;

reg             upchcfgr2wwin2;  //win
reg             upchcfgrowin2;
reg             upchstyr2wwin2;  //win
reg             upchstyw2cwin2;  //win
reg             upchstyrowin2;
reg             upchstar2wwin2;  //win
reg             upchstarowin2;

reg             upchcfgr2wwin3;  //win
reg             upchcfgrowin3;
reg             upchstyr2wwin3;  //win
reg             upchstyw2cwin3;  //win
reg             upchstyrowin3;
reg             upchstar2wwin3;  //win
reg             upchstarowin3;

reg             upchcfgr2wwin4;  //win
reg             upchcfgrowin4;
reg             upchstyr2wwin4;  //win
reg             upchstyw2cwin4;  //win
reg             upchstyrowin4;
reg             upchstar2wwin4;  //win
reg             upchstarowin4;

reg             upchcfgr2wwin5;  //win
reg             upchcfgrowin5;
reg             upchstyr2wwin5;  //win
reg             upchstyw2cwin5;  //win
reg             upchstyrowin5;
reg             upchstar2wwin5;  //win
reg             upchstarowin5;

assign          upchcfgro   = upchcfgpen & iuprs2;
assign          upchcfgr2w  = upchcfgpen & iupws2;

assign          upchstyro   = upchstypen & iuprs2;
assign          upchstyw2c  = upchstypen & iupws2 & ipactive2;
assign          upchstyr2w  = upchstypen & iupws2 & (!ipactive2);

assign          upchstaro   = upchstapen & iuprs2;
assign          upchstar2w  = upchstapen & iupws2;

wire            eng_up_chra_same; //engine and CPU channel read address same
assign          eng_up_chra_same  = engchra == upcha;

wire            upch_readen;    //UP read enable
assign          upch_readen     = ((!engchrdreq) | eng_up_chra_same);

assign          upchcfgr2wwin   = upchcfgr2wlat & upch_readen;
assign          upchcfgrowin    = upchcfgrolat & upch_readen;

assign          upchstyw2cwin   = upchstyw2clat & upch_readen;
assign          upchstyr2wwin   = upchstyr2wlat & upch_readen;
assign          upchstyrowin    = upchstyrolat & upch_readen;

assign          upchstar2wwin   = upchstar2wlat & upch_readen;
assign          upchstarowin    = upchstarolat & upch_readen;


////////////////////////////////////////
//Buffer process

assign          ochra   = engchrdreq ? engchra : upcha;
assign          ochwa   = engchwrreq5 ? engchwa : upcha;

wire            ochwe4;
assign          ochwe4   = (engchwrreq4 | upchcfgr2wwin4 | upchstyw2cwin4 | 
                            upchstyr2wwin4 | upchstar2wwin4);
fflopx #(1) ppochwe4 (iclk,rst,ochwe4,ochwe);

wire            chrdcnflt;  //read conflict
assign          chrdcnflt   = ochwe & (ochwa == ochra);

reg [CHAW-1:0]  ochra1;
wire            chrdcnflt1; //read conflict
assign          chrdcnflt1  = ochwe & (ochwa == ochra1);

reg [CHAW-1:0]  ochra2;
wire            chrdcnflt2; //read conflict
assign          chrdcnflt2  = ochwe & (ochwa == ochra2);

reg [CHAW-1:0]  ochra3;
wire            chrdcnflt3; //read conflict
assign          chrdcnflt3  = ochwe & (ochwa == ochra3);

reg [CHAW-1:0]  ochra4;
wire            chrdcnflt4; //read conflict
assign          chrdcnflt4  = ochwe & (ochwa == ochra4);

reg             chrdcnfltpl1;
reg             chrdcnfltpl2;
reg             chrdcnfltpl3;
reg             chrdcnfltpl4;
reg             chrdcnfltpl5;

wire            prechre;
assign          prechre = (engchrdreq | upchcfgr2wlat | upchcfgrolat | upchstyw2clat | 
                           upchstyr2wlat | upchstyrolat | upchstar2wlat | upchstarolat);
assign          ochre   = prechre & (!chrdcnflt);

reg [CHDW-1:0]  ochwrd1 = {CHDW{1'b0}};
reg [CHDW-1:0]  ochwrd2 = {CHDW{1'b0}};
reg [CHDW-1:0]  ochwrd3 = {CHDW{1'b0}};
reg [CHDW-1:0]  ochwrd4 = {CHDW{1'b0}};
reg [CHDW-1:0]  ochwrd5 = {CHDW{1'b0}};

wire [CHDW-1:0] chrdd_real; //real ch buffer read data
//assign          chrdd_real  = chrdcnfltpl3 ? ochwrd1 : chrdcnfltpl2 ? ochwrd2 : ichrdd;
assign          chrdd_real  = chrdcnfltpl5 ? ochwrd5 : ichrdd;

wire [STYW-1:0] chrdd_cfg;
assign          chrdd_cfg   = chrdd_real[CHDW-1:CHDW-STYW];

wire [STYW-1:0] chrdd_sty;
assign          chrdd_sty   = chrdd_real[STYW-1:0];

wire [STAW-1:0] chrdd_sta;
assign          chrdd_sta   = chrdd_real[STAW+STYW-1:STYW];
            
//Configuration
wire [STYW-1:0] chcfgwrd;
assign          chcfgwrd    = upchcfgr2wwin5 ? updi_ppxxx[STYW-1:0] : chrdd_cfg;

//Sticky
wire [STYW-1:0] engchstywrd;
assign          engchstywrd = istyreq5 | (ista_chgen5 & ista_msk5[STCHEW-1:0] & (ista5 ^ chrdd_sta));

/*
wire [STYW-1:0] chstywrd;
assign          chstywrd    = (upchstyr2wwin2 ? updi_ppxxx[STYW-1:0] :  //not pactive
                               (({STYW{engchwrreq3}} & engchstywrd) |  //Set regardless any condition
                                ((~({STYW{upchstyw2cwin2}} & updi_ppxxx[STYW-1:0])) & chrdd_sty)));    //Up clear before setting from engine
*/

wire [STYW-1:0] chstywrd;
assign          chstywrd    = upchstyr2wwin5 ? updi_ppxxx[STYW-1:0] :  //not pactive
                              upchstyw2cwin5 ? (((~updi_ppxxx[STYW-1:0]) & chrdd_sty) | ({STYW{engchwrreq5}} & engchstywrd  & iinttypeen5)) :
                              engchwrreq5    ? ((engchstywrd | chrdd_sty) & iinttypeen5) : chrdd_sty;

//Status
wire [STAW-1:0] engchstawrd;
assign          engchstawrd = ((~ista_msk5) & chrdd_sta) | (ista_msk5 & ista5);

wire [STAW-1:0] chstawrd;
assign          chstawrd    = (upchstar2wwin5   ? updi_ppxxx[STAW-1:0] : engchstawrd);

assign          ochwrd      = {chcfgwrd,chstawrd,chstywrd};

wire            chprdy,chprdy4;
assign          chprdy4      = upchcfgr2wwin4 | upchcfgrowin4 | upchstyw2cwin4 | upchstyrowin4 |
                               upchstyr2wwin4 | upchstar2wwin4 | upchstarowin4;
fflopx #(1) ichprdy (iclk,rst,chprdy4,chprdy);

//wire [UPW-1:0]  chpdo;
//assign          chpdo       = (upchcfgpen   ? chrdd_cfg :
//                               upchstypen   ? chrdd_sty : chrdd_sta);
                
always @(posedge iclk)
    begin
   
        begin
        {iupws1,iupws2} <= {iupws,iupws1};
        {iuprs1,iuprs2} <= {iuprs,iuprs1};

        ochra1          <= ochra;
        ochra2          <= ochra1;
        ochra3          <= ochra2;
        ochra4          <= ochra3;

        chrdcnfltpl1    <= chrdcnflt;
        ochwrd1         <= ochwrd;
        
        chrdcnfltpl2    <= chrdcnflt1 | chrdcnfltpl1;
        ochwrd2         <= chrdcnflt1 ? ochwrd : ochwrd1;

        chrdcnfltpl3    <= chrdcnflt2 | chrdcnfltpl2;
        ochwrd3         <= chrdcnflt2 ? ochwrd : ochwrd2;

        chrdcnfltpl4    <= chrdcnflt3 | chrdcnfltpl3;
        ochwrd4         <= chrdcnflt3 ? ochwrd : ochwrd3;

        chrdcnfltpl5    <= chrdcnflt4 | chrdcnfltpl4;
        ochwrd5         <= chrdcnflt4 ? ochwrd : ochwrd4;
        
        upchcfgr2wwin1  <= upchcfgr2wwin;
        upchcfgrowin1   <= upchcfgrowin;
        upchstyw2cwin1  <= upchstyw2cwin;
        upchstyrowin1   <= upchstyrowin;
        upchstyr2wwin1  <= upchstyr2wwin;
        upchstar2wwin1  <= upchstar2wwin;
        upchstarowin1   <= upchstarowin;
        
        upchcfgr2wwin2  <= upchcfgr2wwin1;
        upchcfgrowin2   <= upchcfgrowin1;
        upchstyw2cwin2  <= upchstyw2cwin1;
        upchstyrowin2   <= upchstyrowin1;
        upchstyr2wwin2  <= upchstyr2wwin1;
        upchstar2wwin2  <= upchstar2wwin1;
        upchstarowin2   <= upchstarowin1;

        upchcfgr2wwin3  <= upchcfgr2wwin2;
        upchcfgrowin3   <= upchcfgrowin2;
        upchstyw2cwin3  <= upchstyw2cwin2;
        upchstyrowin3   <= upchstyrowin2;
        upchstyr2wwin3  <= upchstyr2wwin2;
        upchstar2wwin3  <= upchstar2wwin2;
        upchstarowin3   <= upchstarowin2;
        
        upchcfgr2wwin4  <= upchcfgr2wwin3;
        upchcfgrowin4   <= upchcfgrowin3;
        upchstyw2cwin4  <= upchstyw2cwin3;
        upchstyrowin4   <= upchstyrowin3;
        upchstyr2wwin4  <= upchstyr2wwin3;
        upchstar2wwin4  <= upchstar2wwin3;
        upchstarowin4   <= upchstarowin3;
        
        upchcfgr2wwin5  <= upchcfgr2wwin4;
        upchcfgrowin5   <= upchcfgrowin4;
        upchstyw2cwin5  <= upchstyw2cwin4;
        upchstyrowin5   <= upchstyrowin4;
        upchstyr2wwin5  <= upchstyr2wwin4;
        upchstar2wwin5  <= upchstar2wwin4;
        upchstarowin5   <= upchstarowin4;
        
        if(!iupen)
            begin
            upchcfgr2wlat   <= 1'b0;
            upchcfgrolat    <= 1'b0;
            upchstyw2clat   <= 1'b0;
            upchstyrolat    <= 1'b0;
            upchstyr2wlat   <= 1'b0;
            upchstar2wlat   <= 1'b0;
            upchstarolat    <= 1'b0;
            end
        else
            begin
            if(upchcfgr2w)          upchcfgr2wlat   <= 1'b1;
            else if(upchcfgr2wwin)  upchcfgr2wlat   <= 1'b0;

            if(upchcfgro)           upchcfgrolat    <= 1'b1;
            else if(upchcfgrowin)   upchcfgrolat    <= 1'b0;
        
            if(upchstyw2c)          upchstyw2clat   <= 1'b1;
            else if(upchstyw2cwin)  upchstyw2clat   <= 1'b0;

            if(upchstyro)           upchstyrolat    <= 1'b1;
            else if(upchstyrowin)   upchstyrolat    <= 1'b0;
          
            if(upchstyr2w)          upchstyr2wlat   <= 1'b1;
            else if(upchstyr2wwin)  upchstyr2wlat   <= 1'b0;
          
            if(upchstar2w)          upchstar2wlat   <= 1'b1;
            else if(upchstar2wwin)  upchstar2wlat   <= 1'b0;

            if(upchstaro)           upchstarolat    <= 1'b1;
            else if(upchstarowin)   upchstarolat    <= 1'b0;
            end
        end
    end

////////////////////////////////////////////////////////////////////////////////
//                              Segment process
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////
//Engine
wire                engsegrdreq;
wire                engsegwrreq3;

reg                 engsegrdreq1;
reg                 engsegrdreq2;
reg                 engsegrdreq3;

//assign              engsegrdreq = prechre & ipactive2;
assign              engsegwrreq3 = engsegrdreq3;

wire [SEGAW-1:0]    engsegra;
//assign              engsegra    = ochra[CHAW-1:CHAW-SEGAW];

wire [SEGAW-1:0]    engsegwa;
assign              engsegwa    = ochwa[CHAW-1:CHAW-SEGAW];
ffxkclkx #(2,SEGAW+1) iengsegreq (iclk,rst,{(prechre & ipactive2),ochra[CHAW-1:CHAW-SEGAW]},{engsegrdreq,engsegra});
 
////////////////////////////////////////
//CPU Interface

wire [SEGAW-1:0]    upsega;
assign              upsega  = upa_ppxxx[SEGAW-1:0];

wire                upsegpen;
wire                upsegro;
wire                upsegwo;    //Highest priority
reg                 upsegrolat = 1'b0;
reg                 upsegwolat = 1'b0;
wire                upsegrowin;
wire                upsegwowin;


assign              upsegro     = upsegpen & iuprs2;
assign              upsegwo     = upsegpen & iupws2 & (!ipactive2);

wire                eng_up_segra_same; //engine and CPU channel read address same
assign              eng_up_segra_same  = engsegra == upsega;

wire                upseg_readen;    //UP read enable
assign              upseg_readen    = ((!engsegrdreq) | eng_up_segra_same);

assign              upsegrowin      = upsegrolat & upseg_readen;
assign              upsegwowin      = upsegwolat;

reg                 upsegrowin1;
reg                 upsegrowin2;
reg                 upsegrowin3;

////////////////////////////////////////
//Buffer process

assign              osegra      = engsegrdreq ? engsegra : upsega;
assign              osegwa      = engsegwrreq3 ? engsegwa : upsega;

assign              osegwe      = (engsegwrreq3 | upsegwowin);

wire                segrdcnflt;  //read conflict
assign              segrdcnflt  = osegwe & (osegwa == osegra);

reg [SEGAW-1:0]     osegra1 = {SEGAW{1'b0}};
reg [SEGAW-1:0]     osegra2 = {SEGAW{1'b0}};

wire                segrdcnflt1; //read conflict
assign              segrdcnflt1 = osegwe & (osegwa == osegra1);

wire                segrdcnflt2; //read conflict
assign              segrdcnflt2 = osegwe & (osegwa == osegra2);

reg                 segrdcnfltpl1 = 1'b0;
reg                 segrdcnfltpl2 = 1'b0;
reg                 segrdcnfltpl3 = 1'b0;

wire                presegre;
assign              presegre    = engsegrdreq | upsegrolat;

assign              osegre      = presegre & (!segrdcnflt);

reg [SEGDW-1:0]     osegwrd1 = {SEGDW{1'b0}};
reg [SEGDW-1:0]     osegwrd2 = {SEGDW{1'b0}};
reg [SEGDW-1:0]     osegwrd3 = {SEGDW{1'b0}};

wire [SEGDW-1:0]    segrdd_real;
//assign              segrdd_real = segrdcnfltpl3 ? osegwrd1 : segrdcnfltpl2 ? osegwrd2 : isegrdd;
assign              segrdd_real = segrdcnfltpl3 ? osegwrd3 : isegrdd;

wire [{1'b1,{BITB{1'b0}}}-1:0]    engsegwrdmsk;
decodex #(BITB,{1'b1,{BITB{1'b0}}}) engsegwrdmski(ochwa[BITB-1:0],engsegwrdmsk);

wire                chintreq;
//assign              chintreq    = |(ochwrd[CHDW-1:CHDW-1-STYW] & ochwrd[STYW-1:0] & iinttypeen);

//assign              chintreq    = |(chcfgwrd & chstywrd & iinttypeen);  // Ngoc
assign              chintreq    = |(chcfgwrd & chstywrd);  //thanhnd@HW-NDTHANH, Fri Aug 28 11:20:12 2015, for mask high level defects

assign              osegwrd     = upsegwowin    ? updi_ppxxx[BITNUM-1:0] : 
                                                  ((~engsegwrdmsk) & segrdd_real) | ({BITNUM{chintreq}} & engsegwrdmsk);
wire                segprdy;
assign              segprdy     = upsegwowin | upsegrowin3;

wire [BITNUM-1:0]   segpdo;
assign              segpdo      = segrdd_real;

always @(posedge iclk)
    begin
    if(rst)
        begin
        //osegwrd1        <= {SEGDW{1'b0}};
        //osegwrd2        <= {SEGDW{1'b0}};
        //osegwrd3        <= {SEGDW{1'b0}};

        osegra1         <= {SEGAW{1'b0}};
        osegra2         <= {SEGAW{1'b0}};

        segrdcnfltpl1   <= 1'b0;
        segrdcnfltpl2   <= 1'b0;
        segrdcnfltpl3  <= 1'b0;

        upsegrolat      <= 1'b0;
        upsegwolat      <= 1'b0;

        upsegrowin1     <= 1'b0;
        upsegrowin2     <= 1'b0;
        upsegrowin3     <= 1'b0;

        engsegrdreq1    <= 1'b0;
        engsegrdreq2    <= 1'b0;
        engsegrdreq3    <= 1'b0;
        end
    else
        begin
        osegra1         <= osegra;
        osegra2         <= osegra1;
        
        segrdcnfltpl1   <= segrdcnflt;
        osegwrd1        <= osegwrd;
        
        segrdcnfltpl2   <= segrdcnflt1 | segrdcnfltpl1;
        osegwrd2        <= segrdcnflt1 ? osegwrd : osegwrd1;

        segrdcnfltpl3   <= segrdcnflt2 | segrdcnfltpl2;
        osegwrd3        <= segrdcnflt2 ? osegwrd : osegwrd2;

        upsegrowin1     <= upsegrowin;
        upsegrowin2     <= upsegrowin1;
        upsegrowin3     <= upsegrowin2;

        engsegrdreq1    <= engsegrdreq;
        engsegrdreq2    <= engsegrdreq1;
        engsegrdreq3    <= engsegrdreq2;
        
        if(upsegro)         upsegrolat  <= 1'b1;
        else if(upsegrowin) upsegrolat  <= 1'b0;
        
        if(upsegwo)         upsegwolat  <= 1'b1;
        else if(upsegwowin) upsegwolat  <= 1'b0;
        end
    end
        
////////////////////////////////////////////////////////////////////////////////
//                          Global Interrupt OR status
////////////////////////////////////////////////////////////////////////////////

wire                upglbintpen_i;

wire                upglbintwrreq;
assign              upglbintwrreq   = upglbintpen_i & iupws2 & (!ipactive2);

// Fix timing by hw-nvcuong on Thu Feb 23 14:43:17 2017
// Active: remove reset, add pipeline for bit mask

reg                 osegwe1 = 1'b0;
reg                 osegwe2 = 1'b0;
reg [SEGAW-1:0]     osegwa1 = {SEGAW{1'b0}};
reg [SEGAW-1:0]     osegwa2 = {SEGAW{1'b0}};
wire [8:0]          segwa2;
assign              segwa2 = osegwa2;

reg                 osegset2 = 1'b0;
reg                 upglbintwrreq1 = 1'b0;
reg                 upglbintwrreq2 = 1'b0;

always @(posedge iclk)
    begin
    {osegwe1,osegwe2} <= {(osegwe & ipactive2),osegwe1};
    {osegwa1,osegwa2} <= {osegwa,osegwa1};
    osegset2 <= |osegwrd1;
    upglbintwrreq1 <= upglbintwrreq;
    upglbintwrreq2 <= upglbintwrreq1;
    end

////////////////////////////////////////////////////////////////////////////////
// Decode CPU address
assign              upchcfgpen  = upen_ppxxx & (upa_ppxxx[UPA-1:UPA-2] == 2'd0);
assign              upchstypen  = upen_ppxxx & (upa_ppxxx[UPA-1:UPA-2] == 2'd1);
assign              upchstapen  = upen_ppxxx & (upa_ppxxx[UPA-1:UPA-2] == 2'd2);

assign              upsegpen    = upen_ppxxx & (upa_ppxxx[UPA-1:SEGB] == {2'd3, {BITB{1'b0}} });

wire                glbpen;
assign              glbpen      = upen_ppxxx & (&upa_ppxxx[UPA-1:SEGINSA+1]);

wire                cfgglbintenpen_i  = glbpen & (!upa_ppxxx[SEGINSA]);
assign              upglbintpen_i     = glbpen & upa_ppxxx[SEGINSA];

////////////////////////////////////////////////////////////////////////////////
// Instant 1024 channel

wire                    iregpar_dis = 1'b0;
wire [SEGINS*32-1:0]    cfgglbintenreg;
wire [SEGINS*32-1:0]    cfgglbintenpdo;
reg [SEGINS*32-1:0]     glbintreg = {SEGINS*32{1'b0}};
wire [SEGINS-1:0]       glbintreg_or,glbintreg_orp;
wire [SEGINS-1:0]       regpar_err;
wire [SEGINS-1:0]       cfgglbintenpen;
wire [SEGINS-1:0]       upglbintpen;

genvar  i;
generate
    for (i=0;i<SEGINS;i=i+1)
        begin: inst_segch
        assign  cfgglbintenpen[i] = cfgglbintenpen_i & (upa_ppxxx[SEGINSA-1:0] == i);
        assign  upglbintpen[i] = upglbintpen_i & (upa_ppxxx[SEGINSA-1:0] == i);
        assign  glbintreg_or[i] = |(cfgglbintenreg[i*32+31:i*32] & glbintreg[i*32+31:i*32]);
        fflopx #(1) iglbintreg_orp (iclk,rst,glbintreg_or[i],glbintreg_orp[i]);      
        pconfigpx #(32) cfgglbinteni
            (iclk,rst,cfgglbintenpen[i],iupws2,updi_ppxxx[31:0],
             cfgglbintenreg[i*32+31:i*32],iregpar_dis,regpar_err[i],cfgglbintenpdo[i*32+31:i*32]);
        always @ (posedge iclk)
            begin
            if(osegwe2 & (osegwa2[SEGAW-1:5] == i)) glbintreg[i*32+osegwa2[4:0]] <= osegset2;    
            else if (upglbintwrreq2 & (upa_ppxxx[SEGINSA-1:0] == i))  glbintreg[i*32+31:i*32] <= updi_ppxxx[31:0];  
            end
        end
endgenerate

// Interrupt
fflopx #(SEGINS) upint_ppxxx (iclk,rst,glbintreg_orp,oupint);

////////////////////////////////////////////////////////////////////////////////
//                          CPU interface
////////////////////////////////////////////////////////////////////////////////

reg [31:0]          cfgglbinten_pdo = 32'd0;
reg [31:0]          glbintreg_pdo = 32'd0;

wire [16*32-1:0]    cfgglbintenpdoi = cfgglbintenpdo;
wire [16*32-1:0]    glbintregi = glbintreg;
always @ (posedge iclk)
    begin
    case (upa_ppxxx[3:0])
        4'd0:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[0*32+31:0*32],glbintregi[0*32+31:0*32]};
        4'd1:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[1*32+31:1*32],glbintregi[1*32+31:1*32]};
        4'd2:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[2*32+31:2*32],glbintregi[2*32+31:2*32]};
        4'd3:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[3*32+31:3*32],glbintregi[3*32+31:3*32]};
        4'd4:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[4*32+31:4*32],glbintregi[4*32+31:4*32]};
        4'd5:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[5*32+31:5*32],glbintregi[5*32+31:5*32]};
        4'd6:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[6*32+31:6*32],glbintregi[6*32+31:6*32]};
        4'd7:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[7*32+31:7*32],glbintregi[7*32+31:7*32]};
        4'd8:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[8*32+31:8*32],glbintregi[8*32+31:8*32]};
        4'd9:       {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[9*32+31:9*32],glbintregi[9*32+31:9*32]};
        4'd10:      {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[10*32+31:10*32],glbintregi[10*32+31:10*32]};
        4'd11:      {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[11*32+31:11*32],glbintregi[11*32+31:11*32]};
        4'd12:      {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[12*32+31:12*32],glbintregi[12*32+31:12*32]};
        4'd13:      {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[13*32+31:13*32],glbintregi[13*32+31:13*32]};
        4'd14:      {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[14*32+31:14*32],glbintregi[14*32+31:14*32]};
        default:    {cfgglbinten_pdo,glbintreg_pdo} <= {cfgglbintenpdoi[15*32+31:15*32],glbintregi[15*32+31:15*32]};
    endcase 
    end

wire                glbprdy;
assign              glbprdy     = glbpen & (iupws2 | iuprs2);

wire                uprdy;
assign              uprdy      = chprdy | segprdy | glbprdy;

//assign              oupdo       = upen_ppxxx ? (chpdo | segpdo | upglbintpdo | cfgglbintenpdo) : {UPW{1'b0}};

wire [UPW-1:0]      updo;
assign  updo  = (cfgglbintenpen_i ? cfgglbinten_pdo :
                 upglbintpen_i    ? glbintreg_pdo :
                 upchcfgpen     ? chrdd_cfg :
                 upchstypen     ? chrdd_sty : 
                 upchstapen     ? chrdd_sta :
                 upsegpen       ? segpdo : {UPW{1'b0}});

reg             ouprdy = 1'b0;
reg [UPW-1:0]   oupdo = {UPW{1'b0}};
always @(posedge iclk)
    begin
/* -----\/----- EXCLUDED -----\/-----
    if(rst)
        begin
        ouprdy <= 1'b0;
        oupdo  <= {UPW{1'b0}};
        end
    else
        begin
 -----/\----- EXCLUDED -----/\----- */
        ouprdy <= uprdy;
        oupdo  <= updo;
//        end
    end

endmodule 
