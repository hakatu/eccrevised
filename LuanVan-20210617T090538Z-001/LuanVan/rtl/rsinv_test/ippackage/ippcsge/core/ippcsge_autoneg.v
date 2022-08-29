////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : autoneg.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Mon Aug 23 10:44:42 2004
// History (Date, Changed By) changed and modified by lqson
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_autoneg
    (
     clk,   //@rxclk
     clk19m,//@clk19
     rst_,
     sync,
     rudi,      //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
     rx_cfdata,
     tx_cfdata,
     xmit,
     an_state,
     an_complete,

     upa,
     upen,
     upactive,
     uprs,
     upws,
     updi,
     updo,
     uprdy

     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input           clk, rst_, sync;
input           clk19m;// @clk19 sys

input [1:0]     rudi;//@rxclk

input [15:0]    rx_cfdata;
output [15:0]   tx_cfdata;
output [1:0]    xmit;
output [3:0]    an_state;
output          an_complete;


input [4:0]     upa;
input           upen;
input           upactive;
input           uprs,upws;
input [15:0]    updi;
output [15:0]   updo;
output          uprdy;


////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter       XMIT_IDL = 2'd0;
parameter       XMIT_CFG = 2'd1;
parameter       XMIT_DAT = 2'd2;

parameter       AN_ENABLE       = 4'd0;
parameter       AN_RESTART      = 4'd1;
parameter       AN_DIS_LINK_OK  = 4'd2;
parameter       ABILITY_DET     = 4'd3;
parameter       ACK_DET         = 4'd4;
parameter       NEXT_PAGE_WAIT  = 4'd5;
parameter       COMPLETE_ACK    = 4'd6;
parameter       IDLE_DET        = 4'd7;
parameter       LINK_OK         = 4'd8;

parameter       RUDI_INVLD  = 2'b11;
parameter       RUDI_I      = 2'b10;
parameter       RUDI_C      = 2'b01;

parameter       TIMER_DONE_VAL = 21'd1250000;    //may be cpu config

parameter       ADV_ABILITY = 16'b0000_00000_0010_0000;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [16:1]     adv_abi;       // Advertised ability (CPU config)
wire [16:1]     np_tx;          // Next page for tx_Config_Reg
wire            np_ena;


//reg [16:1]      lp_adv_abi;     // Advertised ability (from rx_cfdata)
//reg [16:1]      lp_np_rx;
wire [16:1]     lp_adv_abi;     // Advertised ability (from rx_cfdata)
wire [16:1]     lp_np_rx;


wire            abi_match;  //function to indicate the matching of ability
wire            ack_match;  //function to indicate acknowledge match
wire            consist_match;  //function to indicate consistency match
wire            txcf_NP;        // tx_Config_Reg<NP>

wire            idle_match;     // function to indicate Idle_match


reg             page_rx;
reg             bp_rx;

reg             an_complete;
reg [3:0]       an_state;

reg [15:0]      tx_cfdata;  //tx_Config_Reg
reg [1:0]       xmit;
reg             np_loaded;
reg             np_rx;
reg             toggle_rx;
reg             toggle_tx;
reg [15:0]      lrx_cfdata;
//reg             resolve_prio;



//Management Registers implement
wire [15:0]     lpen;
//----------------------------------------------------------------------------------------||
//| 15  | 14 |  13   | 12  |  11  |  10   |   9   |  8   |  7  |  6   | 5   4  3  2  1  0 ||
//| RST | LB |  SpSl | ANE |  PD  |Isolate| rstAN | Mode |  _  | SpSl | _   _  _  _  _  _ ||
//----------------------------------------------------------------------------------------||
assign          lpen[0] = upen & (upa == 5'd0);//control reg0

//----------------------------------------------------------------------------------------||
//1.2 Link Status  | 1.5 Auto-Negotiation complete                                        ||
//----------------------------------------------------------------------------------------||
assign          lpen[1] = upen & (upa == 5'd1);//status reg1

assign          lpen[2] = upen & (upa == 5'd2);
assign          lpen[3] = upen & (upa == 5'd3);

//register 4 : AN advertisement register
//----------------------------------------------------------------------------------------||
//| 15  | 14 |  13 | 12  |  11 |  10 |  9  |  8  |  7  |  6  |  5   | 4   3    2    1   0 ||
//| NP  | _  |  RF | RF  |  _  |  _  |  _  |  P  |  P  |  HD |  FD  | _   _    _    _   _ ||
//|---------------------------------------------------------------------------------------||
assign          lpen[4] = upen & (upa == 5'd4);

//register 5 : AN Link partner ability base page register __ Status Register
assign          lpen[5] = upen & (upa == 5'd5);
//Register 6 : AN expansion register __ RO
//----------------------------------------------------------------------------------------||
//| 15  | 14 |  13 | 12  |  11 |  10 |  9  |  8  |  7  |  6  |  5   | 4   3    2    1   0 ||
//| __  | _  |  __ | __  |  _  |  _  |  _  |  _  |  _  |  _  |  _   | _   _   NPE  PR   _ ||
//|---------------------------------------------------------------------------------------||
assign          lpen[6] = upen & (upa == 5'd6);

//Register 7 : AN next page transmit register
//----------------------------------------------------------------------------------------||
//| 15  | 14 |  13 | 12   |  11 |  10 |  9  |  8  |  7  |  6  |  5   | 4   3   2    1   0 ||
//| NP  | _  |  MP | Ack2 |  T  |          Message / Unformatted Code Field               ||
//|---------------------------------------------------------------------------------------||
assign          lpen[7]  = upen & (upa == 5'd7);

//register 8 : AN Link Partner ability next page register __ Status Register
assign          lpen[8]  = upen & (upa == 5'd8);

//register9 : config for ignore LINK STATUS
assign          lpen[9]  = upen & (upa == 5'd9);

assign          lpen[10] = upen & (upa == 5'd10);
assign          lpen[11] = upen & (upa == 5'd11);
assign          lpen[12] = upen & (upa == 5'd12);
assign          lpen[13] = upen & (upa == 5'd13);
assign          lpen[14] = upen & (upa == 5'd14);
assign          lpen[15] = upen & (upa == 5'd15);

wire [15:0]     pdo0, pdo1, pdo2, pdo3, pdo4, pdo5, pdo6, 
                pdo7, pdo8, pdo9, pdo10, pdo11, pdo12, pdo13, pdo14, pdo15;

wire [15:0]     cfout0, cfout4;

wire [15:0]     reg0,reg4;

//disable autoneg on 9/6/2008
pconfigx #(16,16'b0000_0001_0100_0000) mg_reg0  //AN-Enable, Full Duplex, 1Gb/s
    (
     .clk(clk),
     .rst_(rst_),
     .upen(lpen[0]),
     .upws(upws),
     .updi(updi),
     .out(cfout0),
     .updo(reg0)
     );
/* CONFIG
pconfigx #(16,16'b0001_0001_0100_0000) mg_reg0  //AN-Enable, Full Duplex, 1Gb/s
    (
     .clk(clk),
     .rst_(rst_),
     .upen(lpen[0]),
     .upws(upws),
     .updi(updi),
     .out(cfout0),
     .updo(reg0)
     );
*/
assign          pdo0 = lpen[0]? reg0 : 16'b0;

reg [1:0]       reg1;//status reg

always @(posedge clk or negedge rst_)
    if(!rst_) reg1 <= 2'b0;
    else if(!upactive) 
        reg1 <= lpen[1]& upws? {updi[5],updi[2]}: reg1;
    else
        reg1 <= {an_complete,(xmit == XMIT_DAT)};//sync @clk 

assign          pdo1 = lpen[1]? {10'b0,reg1[1],2'b00,reg1[0],2'b0} : 16'b0;

pconfigx #(16,16'b1000_0000_0010_0000) mg_reg4  
    (
     .clk(clk),
     .rst_(rst_),
     .upen(lpen[4]),
     .upws(upws),
     .updi(updi),
     .out(cfout4),
     .updo(reg4)
     );

assign          pdo4 = lpen[4]? reg4 : 16'b0;

//lp_adv_ability lp_np_rx : status register

reg [15:0]      slp_np_rx,slp_adv_abi;

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)
        begin
        slp_adv_abi  <= 16'b0;
        slp_np_rx    <= 16'b0;
        end
    else
        if(!upactive)
            begin
            slp_np_rx   <= lpen[8] &upws? updi[15:0] : slp_np_rx;
            slp_adv_abi <= lpen[5] &upws? updi[15:0] : slp_adv_abi;
            end 
        else 
            begin
            slp_np_rx    <= lp_np_rx;//sync @clk
            slp_adv_abi  <= lp_adv_abi;
            end
    end

/* Change on 21/5/2008
always @ (an_state)
    if (an_state == COMPLETE_ACK)
        begin
        if(bp_rx)  lp_adv_abi  = lrx_cfdata;
        else if(np_rx)  lp_np_rx    = lrx_cfdata;
        
        end
*/

wire    state_cmpack;
assign  state_cmpack = (an_state == COMPLETE_ACK);

assign  lp_adv_abi  =   (state_cmpack& bp_rx)? lrx_cfdata: slp_adv_abi;
assign  lp_np_rx    =   (state_cmpack& np_rx)? lrx_cfdata: slp_np_rx;



assign          pdo5  = lpen[5]? slp_adv_abi : 16'b0;
assign          pdo8  = lpen[8]? slp_np_rx   : 16'b0;

reg [1:0]       reg6;
assign          np_ena = adv_abi[16]& np_tx[16];

always @(posedge clk or negedge rst_)
    if(!rst_) reg6 <= 2'b0;
    else if(!upactive) reg6 <= lpen[6]& upws? {updi[2],updi[1]} : reg6;
    else               reg6 <= {np_ena, page_rx};//sync @ clk

assign          pdo6 = lpen[6]? {13'b0, reg6[1:0], 1'b0} : 16'b0;

//sync adv_abi @clk
fflopx #(16)plcfout4 (clk, rst_, cfout4[15:0], adv_abi[16:1]);

reg [20:0]      link_timer;


wire            start_link_timer;

wire            link_timer_done;
assign          link_timer_done = (link_timer == TIMER_DONE_VAL);

wire            spact;
fflopx #(1) plpact (clk, rst_,upactive, spact);

assign          start_link_timer = (an_state == AN_RESTART)|(an_state == COMPLETE_ACK)|(an_state == IDLE_DET);

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)                  link_timer <= 21'b0;
    else
        begin
        if(spact)
            if (!start_link_timer) link_timer <= 21'b0;
            else                   link_timer <= link_timer_done       ? 
                                                 (an_state == IDLE_DET)? 21'b0: link_timer: link_timer + 1'b1;
        end
    end


// Assign some conditions for State machine
wire            an_rest; //Control register bit 0.9 = 1
wire            an_enable;

assign          an_enable   = cfout0[12];//Control register bit 0.12 = 1

wire            san_enable;
fflopx #(1) planen(clk, rst_,an_enable, san_enable);//@clk

assign          an_rest     = cfout0[9];

wire            san_rest;
fflopx #(1) planrst (clk, rst_,an_rest, san_rest);//@clk

//TX ignore LINK STATUS
wire            cfout9;
wire            reg9;

pconfigx #(1,1'b1) ignore_link  
    (
     .clk(clk),
     .rst_(rst_),
     .upen(lpen[9]),
     .upws(upws),
     .updi(updi[0]),
     .out(cfout9),
     .updo(reg9)
     );

reg [20:0]      sync_timer;

wire            sync_timer_done;
assign          sync_timer_done = (sync_timer == 21'd1500000);


always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)        sync_timer <= 21'b0;
    else
        begin
        if(spact)
            if (sync)  sync_timer <= 21'b0;
            else       sync_timer <= sync_timer_done? sync_timer: sync_timer + 1'b1;
        end
    end

wire            sync_fail;
assign          sync_fail = (!sync)& sync_timer_done;//note : timer is independent

wire            rudi_fail;
assign          rudi_fail = (rudi == RUDI_INVLD);

wire            link_err;
assign          link_err  = (!cfout9& (sync_fail| rudi_fail) );

assign          pdo9 = lpen[9]? {15'd0,reg9}: 16'b0;

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)  an_state <= AN_ENABLE;
    else if (san_rest | link_err|(!spact))
        begin
        an_state <= AN_ENABLE;
        end
    else
        case (an_state)
            AN_ENABLE:
                begin
                if (san_enable)  an_state <= AN_RESTART;
                else             an_state <= AN_DIS_LINK_OK;
                end
            AN_RESTART:
                begin
                if (link_timer_done)    an_state <= ABILITY_DET;
                end
            ABILITY_DET:
                begin
                if (abi_match & (|lrx_cfdata))   an_state <= ACK_DET;
                end
            ACK_DET:
                begin
                if (ack_match & consist_match)                                           an_state <= COMPLETE_ACK;
                else if ((ack_match & ~consist_match) | (abi_match & ~(|lrx_cfdata)))    an_state <= AN_ENABLE;
                end
            COMPLETE_ACK:
                begin
                if (abi_match & ~(|lrx_cfdata))                                          an_state <= AN_ENABLE;
                else if (link_timer_done & adv_abi[16] & lp_adv_abi[16] & np_loaded &
                         (txcf_NP | np_rx) & (~abi_match | (|lrx_cfdata)))               an_state <= NEXT_PAGE_WAIT;
                else if (((link_timer_done & (~adv_abi[16] | ~lp_adv_abi[16])) |
                         (link_timer_done & adv_abi[16] & lp_adv_abi[16] & ~txcf_NP & ~np_rx)) &
                         (~abi_match | (|lrx_cfdata)))                                   an_state <= IDLE_DET;               
                end
            NEXT_PAGE_WAIT:
                begin
                if (abi_match & (toggle_rx ^ lrx_cfdata[11]) & (|lrx_cfdata))            an_state <= ACK_DET;
                else if (abi_match & ~(|lrx_cfdata))                                     an_state <= AN_ENABLE;
                end
            IDLE_DET:
                begin
                if (abi_match & ~(|lrx_cfdata))          an_state <= AN_ENABLE;
                else if (link_timer_done & idle_match)   an_state <= LINK_OK;
                end
            LINK_OK:
                begin
                if (abi_match)      an_state <= AN_ENABLE;
                else                an_state <= LINK_OK;
                end
            default:                an_state <= AN_DIS_LINK_OK;
        endcase
    end

//implement state variables

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)
        begin
        page_rx         <= 1'b0;
        an_complete     <= 1'b0;
        tx_cfdata       <= 16'b0;
        xmit            <= XMIT_IDL;
        np_rx           <= 1'b0;
        bp_rx           <= 1'b0;
        toggle_rx       <= 1'b0;
        toggle_tx       <= 1'b0;
        end 
    else
        case (an_state)
            AN_ENABLE:
                begin
                page_rx     <= 1'b0;
                an_complete <= 1'b0;
                if (san_enable)
                    begin
                    tx_cfdata   <= 16'b0;
                    xmit        <= XMIT_CFG;
                    end
                else    xmit    <= XMIT_IDL;
                end
            AN_RESTART:
                begin
                tx_cfdata       <= 16'b0;
                xmit            <= XMIT_CFG;  
                bp_rx           <= 1'b1;
                np_rx           <= 1'b0;
                end
            AN_DIS_LINK_OK:
                begin
                xmit <= XMIT_DAT;
                end
            ABILITY_DET:
                begin
                toggle_tx       <= adv_abi[12];
                tx_cfdata       <= {adv_abi[16],1'b0,adv_abi[14:1]};
                end
            ACK_DET:
                begin
                tx_cfdata[14] <= 1'b1;              
                end
            COMPLETE_ACK:
                begin
                toggle_tx   <= !tx_cfdata[11];
                toggle_rx   <= page_rx? toggle_rx: lrx_cfdata[11];
                np_rx       <= page_rx? np_rx    : lrx_cfdata[15];
                page_rx     <= 1'b1;
                end
            NEXT_PAGE_WAIT:
                begin
                tx_cfdata   <= {np_tx[16],1'b0,np_tx[14:13],toggle_tx,np_tx[11:1]};
                page_rx     <= 1'b0;
                bp_rx       <= 1'b0;
                end
            IDLE_DET:
                begin
                xmit            <= XMIT_IDL;
                end
            LINK_OK:
                begin
                xmit            <= XMIT_DAT;
                an_complete     <= 1'b1;
                end
        endcase
    end
 

//Implementation for some function        

//Transmission of next page
//considering later

wire   np_tx_ind;
assign np_tx_ind =  lpen[7]& upws;// 

reg    snp_tx_ind;// latch np_tx_ind
always @(posedge clk or negedge rst_)
    if(!rst_)
        snp_tx_ind <= 1'b0;
    else
        snp_tx_ind <= np_tx_ind;  //sync @clk


wire [15:0] np_tx_dat;
wire [15:0]  snp_tx_dat;
fflopx #(16) plnp_tx_dat (clk, rst_,np_tx_dat,snp_tx_dat);

assign      np_tx[16:1] = snp_tx_dat;

wire [15:0] reg7;

pconfigx #(16,16'b0) mg_reg7  //AN next page transmit register
    (
     .clk(clk),
     .rst_(rst_),
     .upen(lpen[7]),
     .upws(upws),
     .updi(updi),
     .out(np_tx_dat),
     .updo(reg7)
     );

assign      pdo7 = lpen[7]? reg7 : 16'b0;

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)
        begin
        np_loaded   <= 1'b0;
        end
    else if ((an_state == AN_RESTART) | (an_state == NEXT_PAGE_WAIT))
        begin
        np_loaded   <= 1'b0;
        end
    else if(snp_tx_ind)
        begin
        np_loaded   <= 1'b1;
        end
    else if(!txcf_NP)  np_loaded <= np_rx; //Auto load null message
    
    end


assign txcf_NP = tx_cfdata[15];


//Match functions

always @(posedge clk or negedge rst_)
    if(!rst_)
        lrx_cfdata <= 16'b0;
    else
        lrx_cfdata <= rx_cfdata;

wire    pre_abi_match;
assign  pre_abi_match = ({rx_cfdata[15],rx_cfdata[13:0]} == {lrx_cfdata[15],lrx_cfdata[13:0]});//do not have bit ACK


reg [3:0] abi_cnt;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)          abi_cnt <= 4'b0;
    else if ((rudi == RUDI_INVLD) | (rudi == RUDI_I))    abi_cnt <= 4'b0;
    else if (~pre_abi_match)           abi_cnt <= 4'b0;    
    else if (pre_abi_match )           abi_cnt <= abi_match? abi_cnt : abi_cnt + 1'b1;
    end

assign abi_match = (abi_cnt == 4'd11);

reg [15:0] labi_match;

always @(posedge clk or negedge rst_)
    if(!rst_)
        labi_match <= 16'b0;
    else 
        if(abi_match) labi_match <= lrx_cfdata;


wire       pre_ack_match;
assign     pre_ack_match = pre_abi_match & rx_cfdata[14]& lrx_cfdata[14];

reg [3:0]  ack_cnt;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)          ack_cnt <= 4'b0;
    else if ((rudi == RUDI_INVLD) | (rudi == RUDI_I))   ack_cnt <= 4'b0;
    else if (~pre_ack_match)                            ack_cnt <= 4'b0;    
    else if (pre_ack_match )                            ack_cnt <= ack_match? ack_cnt : ack_cnt + 1'b1;
    end

assign ack_match = (ack_cnt == 4'd11);

assign consist_match = ack_match& (lrx_cfdata == labi_match);
       
reg [2:0] idle_cnt;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)          idle_cnt <= 3'b0;
    else 
        begin
        if (rudi != RUDI_I)         idle_cnt <= 2'b0;
        else if (idle_cnt < 3'd5)   idle_cnt <= idle_cnt + 1'b1;
        end
    end

assign     idle_match = (idle_cnt == 3'd5);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// CPU
assign updo  = pdo0| pdo1| pdo4| pdo5| pdo6| pdo7| pdo8| pdo9;

assign uprdy = (|lpen) & (upws| uprs);

endmodule 
