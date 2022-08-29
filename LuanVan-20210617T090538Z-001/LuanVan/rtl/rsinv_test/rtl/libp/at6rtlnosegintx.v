////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtlnosegintx.v
// Description  : .
//
// Author       : lqcuong@HW-LQCUONG
// Created On   : Tue Aug 04 14:36:13 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module at6rtlnosegintx
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
    
     istyreq,
     ista,
     ista_msk,
     ista_chgen,
     iinttypeen,

     //Channel buffer: array112x
     ochwe,
     ochwa,     
     ochwrd,    
     ochre,
     ochra,
     ichrdd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter   STYW        = 5;
parameter   STAW        = 5;
parameter   STCHEW      = 5;    //Enable to monitor change to generate interrupt

parameter   SEGB        = 4;    //Bit of segment ID

parameter   SEGNUM      = 12;

parameter   UPW         = 12;   //Maximum bits between 2*styw + staw and SEGNUM in a segment

parameter   UPA         = SEGB + 2;

parameter   CHAW        = SEGB;
parameter   CHDW        = 2*STYW + STAW;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input       iclk;
input       rst;
input       ipactive;

input       iupen;
input [UPA-1:0] iupa;
input           iupws;
input           iuprs;
input [UPW-1:0] iupdi;
output          ouprdy;
output [UPW-1:0] oupdo;
output           oupint;

input            idtvl;          //Data valid
input [SEGB-1:0] isegid;         //Segment ID (such as sts
input [STYW-1:0] istyreq;        //Request to set Sticky in the sticky area
input [STAW-1:0] ista;           //Status to write into status area.
//Note: Bits, being enabled to monitor state change for generating
//interrupt, have to be started from 0  
input [STAW-1:0] ista_msk;       //bit set to enable the related to be updated in the status area
input [STCHEW-1:0] ista_chgen;     //Eanble to monitor change of input status to set related sticky.
//NOTE: bit[i] enable for status [i] and the sticky #i will be set  
input [STYW-1:0]   iinttypeen;     //Enable per type interrupt enable to help quick disable from SW, set 1 to enable, set 0 to clear

////////////////////////////////////////
//Per channel buffer: contain sticky, current status and interrupt enable
//Array112x
//Address: isegid
//Data:
//[STYW-1:0]            : sticky area
//[STYW+STAW-1:STYW]    : status area
//[CHDW-1:CHDW-STYW]    : Interrupt enable erea
output             ochwe;
output [CHAW-1:0]  ochwa;
output [CHDW-1:0]  ochwrd;
output             ochre;
output [CHAW-1:0]  ochra;
input [CHDW-1:0]   ichrdd;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [STYW-1:0]    iinttypeen1;     //for mask sticky by high level defect, per channel
wire [STYW-1:0]    iinttypeen2;     //for mask sticky by high level defect, per channel
fflopx #(STYW*2) ppiinttypeen (iclk,rst,{iinttypeen,iinttypeen1},{iinttypeen1,iinttypeen2});

////////////////////////////////////////////////////////////////////////////////
//                              Per channel buffer
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////
//Engine
reg [STYW-1:0]     istyreq1;
reg [STYW-1:0]     istyreq2;
reg [STAW-1:0]     ista1;
reg [STAW-1:0]     ista2;
reg [SEGB-1:0]     isegid1;
reg [SEGB-1:0]     isegid2;
reg [STCHEW-1:0]   ista_chgen1;
reg [STCHEW-1:0]   ista_chgen2;
reg [STAW-1:0]     ista_msk1;
reg [STAW-1:0]     ista_msk2;

wire               engchwrreq;
wire               engchrdreq;

reg                engchrdreq1;
reg                engchrdreq2;

assign             engchrdreq  = idtvl & ipactive;
assign             engchwrreq  = engchrdreq2;

wire [CHAW-1:0]    engchra;
assign             engchra     = isegid;

wire [CHAW-1:0]    engchwa;
assign             engchwa     = isegid2;

always @(posedge iclk)
    begin
    if(rst)
        begin
        istyreq1    <= {STYW{1'b0}};
        istyreq2    <= {STYW{1'b0}};
        ista1       <= {STAW{1'b0}};
        ista2       <= {STAW{1'b0}};
        isegid1     <= {SEGB{1'b0}};
        isegid2     <= {SEGB{1'b0}};
        ista_chgen1 <= {STCHEW{1'b0}};
        ista_chgen2 <= {STCHEW{1'b0}};
        engchrdreq1 <= 1'b0;
        engchrdreq2 <= 1'b0;
        ista_msk1   <= {STAW{1'b0}};
        ista_msk2   <= {STAW{1'b0}};
        end
    else
        begin
        ista_msk1   <= {STAW{idtvl}} & ista_msk;
        ista_msk2   <= ista_msk1;
        istyreq1    <= istyreq;
        istyreq2    <= istyreq1;
        ista1       <= ista;
        ista2       <= ista1;
        isegid1     <= isegid;
        isegid2     <= isegid1;
        ista_chgen1 <= ista_chgen;
        ista_chgen2 <= ista_chgen1;
        engchrdreq1 <= engchrdreq;
        engchrdreq2 <= engchrdreq1;
        end
    end

////////////////////////////////////////
//CPU Interface

reg             iupws1;
reg             iuprs1;

//Convention:
//- ro: read only
//- r2w: read to write (write only but have to read and then write
//- w2c: write to clear

//Configuration:
wire [CHAW-1:0] upcha;
assign          upcha   = iupa[CHAW-1:0];

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

assign          upchcfgro   = upchcfgpen & iuprs1;
assign          upchcfgr2w  = upchcfgpen & iupws1;

assign          upchstyro   = upchstypen & iuprs1;
assign          upchstyw2c  = upchstypen & iupws1 & ipactive;
assign          upchstyr2w  = upchstypen & iupws1 & (!ipactive);

assign          upchstaro   = upchstapen & iuprs1;
assign          upchstar2w  = upchstapen & iupws1;

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

/* -----\/----- EXCLUDED -----\/-----
assign          ochra   = engchrdreq    ? engchra : upcha;
assign          ochwa   = engchwrreq ? engchwa : upcha;

assign          ochwe   = (engchwrreq | upchcfgr2wwin2 | upchstyw2cwin2 | 
                           upchstyr2wwin2 | upchstar2wwin2);
 -----/\----- EXCLUDED -----/\----- */
fflopx #(1) ochwepp (iclk,rst,(engchwrreq | upchcfgr2wwin2 | upchstyw2cwin2 | upchstyr2wwin2 | upchstar2wwin2),ochwe);
fflopx #(CHAW) ochwapp (iclk,rst,(engchwrreq ? engchwa : upcha),ochwa);
fflopx #(CHAW) ochrapp (iclk,rst,(engchrdreq ? engchra : upcha),ochra);

wire            chrdcnflt;  //read conflict
assign          chrdcnflt   = ochwe & (ochwa == ochra);

reg [CHAW-1:0]  ochra1;
reg [CHAW-1:0]  ochra2;

wire            chrdcnflt1; //read conflict
assign          chrdcnflt1  = ochwe & (ochwa == ochra1);

wire            chrdcnflt2; //read conflict
assign          chrdcnflt2  = ochwe & (ochwa == ochra2);


reg             chrdcnfltpl1;
reg             chrdcnfltpl2;
reg             chrdcnfltpl3;

wire            prechre;
assign          prechre = (engchrdreq | upchcfgr2wlat | upchcfgrolat | upchstyw2clat | 
                           upchstyr2wlat | upchstyrolat | upchstar2wlat | upchstarolat);
//assign          ochre   = prechre & (!chrdcnflt);
fflopx #(1) ochrepp (iclk,rst,(prechre & (!chrdcnflt)),ochre);

reg [CHDW-1:0]  ochwrd1;
reg [CHDW-1:0]  ochwrd2;
reg [CHDW-1:0]  ochwrd3;

wire [CHDW-1:0] chrdd_real; //real ch buffer read data
//assign          chrdd_real  = chrdcnfltpl2 ? ochwrd2 : chrdcnflt1pl1 ? ochwrd1 : ichrdd;
assign          chrdd_real  = /*chrdcnflt1pl1 ? ochwrd1 :*/ chrdcnfltpl3 ? ochwrd3 : ichrdd;// follow rtlramsta113x 

wire [STYW-1:0] chrdd_cfg;
assign          chrdd_cfg   = chrdd_real[CHDW-1:CHDW-STYW];

wire [STYW-1:0] chrdd_sty;
assign          chrdd_sty   = chrdd_real[STYW-1:0];

wire [STAW-1:0] chrdd_sta;
assign          chrdd_sta   = chrdd_real[STAW+STYW-1:STYW];

//Configuration
wire [STYW-1:0] chcfgwrd;
assign          chcfgwrd    = upchcfgr2wwin2    ? iupdi[STYW-1:0] : chrdd_cfg;

//Sticky
wire [STYW-1:0] engchstywrd;
assign          engchstywrd = istyreq2 | (ista_chgen2 & ista_msk2[STCHEW-1:0] & (ista2 ^ chrdd_sta));

/*
wire [STYW-1:0] chstywrd;
assign          chstywrd    = (upchstyr2wwin2 ? iupdi[STYW-1:0] :  //not pactive
                               (({STYW{engchwrreq}} & engchstywrd) |  //Set regardless any condition
                                ((~({STYW{upchstyw2cwin2}} & iupdi[STYW-1:0])) & chrdd_sty)));    //Up clear before setting from engine
*/

wire [STYW-1:0] chstywrd;
assign          chstywrd    = upchstyr2wwin2 ? iupdi[STYW-1:0] :  //not pactive
                              upchstyw2cwin2 ? (((~iupdi[STYW-1:0]) & chrdd_sty) | ({STYW{engchwrreq}} & engchstywrd  & iinttypeen2)) :
                              engchwrreq     ? ((engchstywrd | chrdd_sty) & iinttypeen2) : chrdd_sty;


//Status
wire [STAW-1:0] engchstawrd;
assign          engchstawrd = ((~ista_msk2) & chrdd_sta) | (ista_msk2 & ista2);

wire [STAW-1:0] chstawrd;
assign          chstawrd    = (upchstar2wwin2   ? iupdi[STAW-1:0] : engchstawrd);

//assign          ochwrd      = {chcfgwrd,chstawrd,chstywrd};
fflopx #(STAW) ochwrdpp (iclk,rst,{chcfgwrd,chstawrd,chstywrd},ochwrd);

wire            chprdy;
assign          chprdy      = upchcfgr2wwin2 | upchcfgrowin2 | upchstyw2cwin2 | upchstyrowin2 |
                upchstyr2wwin2 | upchstar2wwin2 | upchstarowin2;

wire [UPW-1:0]  chpdo;
assign          chpdo       = chprdy ? (upchcfgpen   ? chrdd_cfg :
                                        upchstypen   ? chrdd_sty : chrdd_sta) : {UPW{1'b0}};

always @(posedge iclk)
    begin
    if(rst)
        begin
        iupws1          <= 1'b0;
        iuprs1          <= 1'b0;
        
        //ochwrd1         <= {CHDW{1'b0}};
        //ochwrd2         <= {CHDW{1'b0}};

        //ochra1          <={CHAW{1'b0}};
        
        chrdcnfltpl1    <= 1'b0;
        chrdcnfltpl2    <= 1'b0;
        chrdcnfltpl3    <= 1'b0;

        upchcfgr2wlat   <= 1'b0;
        upchcfgrolat    <= 1'b0;
        upchstyw2clat   <= 1'b0;
        upchstyrolat    <= 1'b0;
        upchstyr2wlat   <= 1'b0;
        upchstar2wlat   <= 1'b0;
        upchstarolat    <= 1'b0;
        
        upchcfgr2wwin1  <= 1'b0;
        upchcfgrowin1   <= 1'b0;
        upchstyw2cwin1  <= 1'b0;
        upchstyrowin1   <= 1'b0;
        upchstyr2wwin1  <= 1'b0;
        upchstar2wwin1  <= 1'b0;
        upchstarowin1   <= 1'b0;

        upchcfgr2wwin2  <= 1'b0;
        upchcfgrowin2   <= 1'b0;
        upchstyw2cwin2  <= 1'b0;
        upchstyrowin2   <= 1'b0;
        upchstyr2wwin2  <= 1'b0;
        upchstar2wwin2  <= 1'b0;
        upchstarowin2   <= 1'b0;
        end
    else
        begin
        iupws1          <= iupws;
        iuprs1          <= iuprs;

        ochwrd1         <= ochwrd;
        ochwrd2         <= chrdcnflt1 ? ochwrd : ochwrd1;
        ochwrd3         <= chrdcnflt2 ? ochwrd : ochwrd2;

        ochra1          <= ochra;
        ochra2          <= ochra1;

        chrdcnfltpl1    <= chrdcnflt;
        chrdcnfltpl2    <= chrdcnfltpl1 | chrdcnflt1;
        chrdcnfltpl3    <= chrdcnfltpl2 | chrdcnflt2;

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
//                          Global Interrupt OR status
////////////////////////////////////////////////////////////////////////////////

wire                chintreq;
//assign              chintreq    = |(chcfgwrd & chstywrd & iinttypeen);
assign              chintreq    = |(chcfgwrd & chstywrd);//add mask by high level defect

wire                upglbintpen;

wire                upglbintwrreq;
assign              upglbintwrreq   = upglbintpen & iupws1 & (!ipactive);

reg [SEGNUM-1:0]    glbintreg;
always @(posedge iclk)
    begin
    if(rst)
        begin
        glbintreg   <= {SEGNUM{1'b0}};
        end
    else
        begin
        if(ipactive)
            begin
            if(ochwe)   glbintreg[ochwa]   <= chintreq;
            end
        else
            begin
            if(upglbintwrreq)   glbintreg   <= iupdi[SEGNUM-1:0];
            end
        end
    end

wire [SEGNUM-1:0]   upglbintpdo;
assign              upglbintpdo = upglbintpen   ? glbintreg : {SEGNUM{1'b0}};

wire [SEGNUM-1:0]   cfgglbintenreg;

assign              oupint  = |(glbintreg & cfgglbintenreg);

////////////////////////////////////////////////////////////////////////////////
//                          CPU interface
////////////////////////////////////////////////////////////////////////////////

wire [7:0]          regpar_err;
wire                iregpar_dis = 1'b0;

wire                cfgglbintenpen;
wire [SEGNUM-1:0]   cfgglbintenpdo;
pconfigpx #(SEGNUM) cfgglbinteni
    (iclk,rst,cfgglbintenpen,iupws1,iupdi[SEGNUM-1:0],
     cfgglbintenreg,iregpar_dis,regpar_err[0],cfgglbintenpdo);

assign              upchcfgpen  = iupen & (iupa[UPA-1:UPA-2] == 2'd0);
assign              upchstypen  = iupen & (iupa[UPA-1:UPA-2] == 2'd1);
assign              upchstapen  = iupen & (iupa[UPA-1:UPA-2] == 2'd2);

wire                glbpen;
assign              glbpen      = iupen & (&iupa[UPA-1:1]);

assign              cfgglbintenpen  = glbpen & (!iupa[0]);
assign              upglbintpen     = glbpen & iupa[0];

wire                glbprdy;
assign              glbprdy     = glbpen & (iupws1 | iuprs1);

assign              ouprdy      = chprdy | glbprdy;
assign              oupdo       = iupen ? (chpdo | upglbintpdo | cfgglbintenpdo) : {UPW{1'b0}};

endmodule 
