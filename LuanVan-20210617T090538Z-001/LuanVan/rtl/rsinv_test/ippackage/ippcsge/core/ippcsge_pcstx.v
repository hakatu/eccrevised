////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : pcstx.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Aug 11 10:48:56 2004
// History (Date, Changed By) changed and modified by lqson
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_pcstx
    (
     clk,//@txclk
     rst_,

     //disp test
     fdisp,//@clk19m
     disp,
     
     //Carrier sense signals
     receiving,//@rxclk
     transmitting,

     //Configuration signals
     xmit,  //@rxclk
     cfdata,

     //GMII signal
     txen,
     txerr,
     col,
     di,
     do

     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input           clk, rst_;
input           fdisp, disp;    //test disparity

input           receiving;   //1- carrier received 0- carrier not received
output          transmitting;  //1- packet being transmitting 0- not being transmitting
input [1:0]     xmit;
input [15:0]    cfdata;
input           txen;
input           txerr;
output          col;    // colision dected
input [7:0]     di;
output [9:0]    do;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
/*parameter       IDL = 3'd0; // Idle             /I/
parameter       CFG = 3'd1; // Config           /C/
parameter       SOP = 3'd2; // Start of packet  /S/
parameter       EOP = 3'd3; // End of packet    /T/
parameter       DAT = 3'd4; // Data             /D/
parameter       CEX = 3'd5; // Carrier Extend   /R/
parameter       ERP = 3'd6; // Error Propagation /V/
*/

parameter       CFG_C1A         = 5'd0;
parameter       CFG_C1B         = 5'd1;
parameter       CFG_C1C         = 5'd2;
parameter       CFG_C1D         = 5'd3;
parameter       CFG_C2A         = 5'd4;
parameter       CFG_C2B         = 5'd5;
parameter       CFG_C2C         = 5'd6;
parameter       CFG_C2D         = 5'd7;
parameter       IDL_DISP        = 5'd8;
parameter       IDL_I1B         = 5'd9;
parameter       IDL_I2B         = 5'd10;

parameter       START_ERROR     = 5'd11;
parameter       TX_DATA_ERROR   = 5'd12;
parameter       START_OF_PACKET = 5'd13;
parameter       TX_DATA         = 5'd14;
parameter       EOP_NOEXT       = 5'd15;
parameter       EOP_EXT         = 5'd16;
parameter       EPD2_NOEXT      = 5'd17;
parameter       EPD3            = 5'd18;
parameter       EXTEND_BY_1     = 5'd19;
parameter       CARR_EXT        = 5'd20;

parameter       K28_0 = 9'h11C;
parameter       K28_1 = 9'h13C;
parameter       K28_2 = 9'h15C;
parameter       K28_3 = 9'h17C;
parameter       K28_4 = 9'h19C;
parameter       K28_5 = 9'h1BC;
parameter       K28_6 = 9'h1DC;
parameter       K28_7 = 9'h1FC;
parameter       K23_7 = 9'h1F7;  // /R/ 
parameter       K27_7 = 9'h1FB;  // /S/
parameter       K29_7 = 9'h1FD;  // /T/
parameter       K30_7 = 9'h1FE;  // /V/

parameter       D21_5 = 9'h0B5;
parameter       D2_2  = 9'h042;
parameter       D5_6  = 9'h0C5;
parameter       D16_2 = 9'h050;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire [9:0]      do;

//latch data for PCS processing

wire [7:0]      di1,di2;
fflopx #(16) pldi (clk,rst_,{di, di1 },{di1, di2});

wire            txen1,txen2;
fflopx #(2) pltxen (clk,rst_,{txen,txen1},{txen1,txen2});

wire            txerr1,txerr2;
fflopx #(2) pltxerr (clk,rst_,{txerr,txerr1},{txerr1,txerr2});

wire [7:0]      data;
wire [1:0]      datinf;

reg             st1,st2;

wire [1:0]      datinf1;
//assign          datinf1 = st1? {txen2, txerr2} : {txen1, txerr1} ;
assign          datinf1 = {txen2, txerr2};

fflopx #(2) plinedatinf (clk, rst_, datinf1,datinf);

wire   dtvl1,dtvl;
assign dtvl1  =  datinf1[1] ;
assign dtvl   =  datinf[1] ;

wire   dterr1,dterr;
assign dterr1 =  datinf1[0] ;
assign dterr  =  datinf[0] ;

wire   [7:0]     data1;
//assign           data1   = st1? di2: di1;
assign           data1   = di2;

fflopx #(8) pline_data (clk, rst_, data1, data);

reg [4:0]     ordset_state;
/*
wire [4:0]     ordset_state1;
fflopx #(5) pline_oderset (clk, rst_,ordset_state ,ordset_state1 );
wire          pos_txen = txen & !txen1;

always @(posedge clk or negedge rst_)
    if(!rst_)
        begin
        st1 <= 1'b0;
        end
    else
        begin
        st1 <= (ordset_state  == IDL_DISP)? pos_txen| txen2: st1;
        st2 <= (ordset_state1 == IDL_DISP)? pos_txen| txen1: st2;
        end
*/

wire        xmit_IDL;
wire        xmit_CFG;
wire        xmit_DAT; 

// consider later
//sync back @ txclk
wire  [1:0]  sxmit;
fflopx #(2) plxmit (clk, rst_, xmit, sxmit);

assign      xmit_IDL = (sxmit == 2'd0);//@txclk
assign      xmit_CFG = (sxmit == 2'd1);
assign      xmit_DAT = (sxmit == 2'd2);

wire [15:0] scfdata;
fflopx #(16) synccfdata (clk, rst_, cfdata, scfdata);

wire        sreceiving;
fflopx #(1) srx (clk,rst_, receiving, sreceiving);

//////////////////////////////////////////////////////////////////////////////////////////////////////// 
reg             tx_even;    // = 1 at rst_ 

//PCS transmit ordered_set state machine

reg             l_trans, l_col;

  
//tx_o_set assignment
wire            transmitting, col;

wire [8:0]      void_D1, void_T1, void_R1;
wire [8:0]      void_D, void_T, void_R;

assign          void_D1 = (dtvl1 & dterr1) | (~dtvl1 & dterr1 & (data1 != 8'b0000_1111))? K30_7 : {1'b0,data1};
assign          void_T1 = (dtvl1 & dterr1) | (~dtvl1 & dterr1 & (data1 != 8'b0000_1111))? K30_7 : K29_7;
assign          void_R1 = (dtvl1 & dterr1) | (~dtvl1 & dterr1 & (data1 != 8'b0000_1111))? K30_7 : K23_7;

fflopx #(27) pl_void (clk, rst_,{void_D1,void_T1,void_R1},{void_D,void_T,void_R});

wire            tx_disp;

reg [8:0]       tx_cdgrp;

always @(posedge clk or negedge rst_)
    if(!rst_)
        begin
        ordset_state <= CFG_C1A;//nxt state
        l_trans      <= 1'b0;
        l_col        <= 1'b0;
        tx_cdgrp     <= K28_5;
        tx_even      <= 1'b1;   //important
        end
    else
        begin
        case (ordset_state)
            
            CFG_C1A:
                begin
                tx_cdgrp     <= D21_5;
                tx_even      <= 1'b0;
                ordset_state <= CFG_C1B;
                end
            
            CFG_C1B:
                begin
                tx_cdgrp     <= {1'b0,scfdata[7:0]};
                tx_even      <= 1'b1;
                ordset_state <= CFG_C1C;
                end
            
            CFG_C1C:
                begin
                tx_cdgrp     <= {1'b0,scfdata[15:8]};
                tx_even      <= 1'b0;//nxt
                ordset_state <= CFG_C1D;
                end
            
            CFG_C1D:
                begin
                tx_even      <= 1'b1;
                tx_cdgrp     <= K28_5;
                //can be optimized
                if (xmit_IDL | xmit_DAT )  
                    begin
                    ordset_state <= IDL_DISP;//{txen,txerr} == 00,11  {10,01}?
                    //tx_cdgrp     <= K28_5;
                    end
                else   
                    begin
                    ordset_state <= CFG_C2A;
                    //tx_cdgrp     <= K28_5;
                    end
                end
            
            CFG_C2A:
                begin
                tx_cdgrp     <= D2_2;
                tx_even      <= 1'b0;
                ordset_state <= CFG_C2B;
                end
            
            CFG_C2B:
                begin
                tx_cdgrp     <= {1'b0,scfdata[7:0]};
                tx_even      <= 1'b1;
                ordset_state <= CFG_C2C;
                end
            
            CFG_C2C:
                begin
                tx_cdgrp     <= {1'b0,scfdata[15:8]};
                tx_even      <= 1'b0;
                ordset_state <= CFG_C2D;
                end
            
            CFG_C2D:
                begin
                tx_even      <= 1'b1;
                tx_cdgrp     <= K28_5;
                if (xmit_IDL | xmit_DAT )  
                    begin
                    ordset_state <= IDL_DISP;//{txen,txerr} == {00},{11}  {10},{01};?
                    //tx_cdgrp     <= K28_5;
                    end
                else   
                    begin
                    ordset_state <= CFG_C1A;
                    //tx_cdgrp     <= K28_5;
                    end
                end
            
            IDL_DISP:
                begin
                tx_even      <= 1'b0;
                if(tx_disp) 
                    begin
                    ordset_state <= IDL_I1B;
                    tx_cdgrp     <= D5_6;
                    end
                else   
                    begin
                    ordset_state <= IDL_I2B;
                    tx_cdgrp     <= D16_2;
                    end
                end
            
            IDL_I1B:
                begin
                tx_even      <= !tx_even;//txeven <= TRUE
                if (xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP; //xmit = IDLE
                    tx_cdgrp     <= K28_5;
                    end
                else if (dtvl & ~dterr) //10,    xmit_DAT
                    begin
                    ordset_state <= START_OF_PACKET;
                    tx_cdgrp     <= K27_7; //    /S/
                    l_trans  <= 1'b1;
                    l_col    <= sreceiving;
                    end
                else if (dtvl & dterr)//11
                    begin
                    ordset_state <= START_ERROR;
                    tx_cdgrp     <= K27_7; //    /S/
                    l_trans      <= 1'b1;
                    l_col        <= sreceiving;
                    end
                else 
                    begin
                    ordset_state <= IDL_DISP; //01,00  <=> (!txen)
                    tx_cdgrp     <= K28_5; //    
                    end 
                
                end
                    
            IDL_I2B:
                begin
                tx_even      <= !tx_even; //tx_even <= TRUE
                if (xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP; //xmit = IDLE
                    tx_cdgrp     <= K28_5;
                    end
                else if (dtvl & ~dterr) //10,    xmit_DAT
                    begin
                    ordset_state <= START_OF_PACKET;
                    tx_cdgrp     <= K27_7; //    /S/
                    l_trans      <= 1'b1;
                    l_col        <= sreceiving;
                    end
                else if (dtvl & dterr)//11
                    begin
                    ordset_state <= START_ERROR;
                    tx_cdgrp     <= K27_7; //    /S/
                    l_trans      <= 1'b1;
                    l_col        <= sreceiving;
                    end
                else 
                    begin
                    ordset_state <= IDL_DISP; //01,00  <=> (!txen)
                    tx_cdgrp     <= K28_5; //    
                    end 
                end
               
            START_ERROR:
                begin
                //tx_cdgrp     <= K27_7;// /S/
                tx_even      <= !tx_even;
                
                if(xmit_CFG & !tx_even)      
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else
                    begin
                    ordset_state <= TX_DATA_ERROR; //xmit_DAT
                    l_col        <= sreceiving;
                    tx_cdgrp     <= K30_7; // /V/
                    end
                end
            
            TX_DATA_ERROR,START_OF_PACKET,TX_DATA:
                begin
                tx_even  <= !tx_even;
                
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else if (dtvl) //10,11   ;xmit_DATA
                    begin
                    ordset_state <= TX_DATA;
                    l_col        <= sreceiving;
                    tx_cdgrp     <= void_D;
                    end
                else if (!dtvl & dterr)//01
                    begin
                    ordset_state <= EOP_EXT;
                    l_col        <= sreceiving;
                    tx_cdgrp     <= void_T;
                    end
                else //00 (!dtvl & !dterr)    
                    begin
                    ordset_state <= EOP_NOEXT;
                    l_trans      <= !tx_even? 1'b0 : l_trans;
                    l_col        <= 1'b0;
                    tx_cdgrp     <= K29_7;   // /T/
                    end
                end
            
            EOP_NOEXT:
                begin
                tx_even  <= !tx_even;
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else 
                    begin
                    ordset_state <= EPD2_NOEXT;
                    l_trans  <= 1'b0;
                    tx_cdgrp <= K23_7;  // /R/
                    end
                end
            
            EPD2_NOEXT:
                begin
                tx_even  <= !tx_even;
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else if (~tx_even)
                     begin
                     ordset_state <= IDL_DISP;
                     tx_cdgrp     <= K28_5;
                     end
                 else
                     begin
                     ordset_state <= EPD3;
                     tx_cdgrp     <= K23_7; // /R/
                     end
                end
        
            EOP_EXT:
                begin
                tx_even  <= !tx_even;
                                
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else if (dterr)//01,11
                    begin
                    ordset_state <= CARR_EXT;
                    l_col        <= sreceiving;
                    tx_cdgrp     <= void_R;
                    end
                else           //10,00
                    begin 
                    ordset_state <= EXTEND_BY_1;
                    l_trans      <= !tx_even? 1'b0 : l_trans;
                    l_col        <= 1'b0;
                    tx_cdgrp     <= K23_7;// /R/
                    end
                end

            EXTEND_BY_1:
                begin
                tx_even <= !tx_even;
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else 
                    begin
                    ordset_state <= EPD2_NOEXT;
                    l_trans      <= 1'b0;
                    tx_cdgrp     <= K23_7;// /R/
                    end
                end
            
            CARR_EXT:
                begin
                tx_even <= !tx_even;
                if(xmit_CFG & !tx_even)
                    begin
                    ordset_state <= CFG_C1A;
                    tx_cdgrp     <= K28_5;
                    end
                else if(xmit_IDL & !tx_even) 
                    begin
                    ordset_state <= IDL_DISP;
                    tx_cdgrp     <= K28_5;
                    end
                else if (~dtvl & ~dterr)//00
                    begin
                    ordset_state <= EXTEND_BY_1;
                    l_trans      <= !tx_even? 1'b0 : l_trans;
                    l_col        <= 1'b0;
                    tx_cdgrp     <= K23_7;// /R/
                    end
                else if (dtvl & dterr)//11
                    begin
                    ordset_state <= START_ERROR;
                    l_trans      <= 1'b1;
                    l_col        <= sreceiving;
                    tx_cdgrp     <= K27_7;  //  /S/
                    end
                else if (dtvl & ~dterr)//10
                    begin
                    ordset_state <= START_OF_PACKET;
                    tx_cdgrp     <= K27_7; //    /S/
                    l_trans      <= 1'b1;
                    l_col        <= sreceiving;
                    end
                else 
                    begin
                    ordset_state <= CARR_EXT; //01
                    l_col        <= sreceiving;
                    tx_cdgrp     <= void_R;
                    end
                end
        
            EPD3:
                begin
                tx_even   <= !tx_even;
                tx_cdgrp  <= K28_5;
                if(xmit_CFG)// tx_even = FALSE
                    begin
                    ordset_state <= CFG_C1A;
                    //tx_cdgrp     <= K28_5;
                    end
                else
                    begin
                    ordset_state <= IDL_DISP;
                    //tx_cdgrp     <= K28_5;
                    end
                end
            default: 
                begin
                tx_even      <= 1'b1;
                ordset_state <= IDL_DISP;
                tx_cdgrp     <= K28_5;
                end
        endcase
        end


     
//8b10 encode
wire dispin;
wire sfdisp;
fflopx #(1) pldisp (clk, rst_, fdisp, sfdisp);//@clk

assign dispin =  sfdisp? disp : tx_disp;

ippcsge_encode_8b10b encode_inst 
    (
     .clk(clk), 
     .rst_(rst_), 
     .datain(tx_cdgrp), 
     .dispin(dispin), 
     .dataout(do), 
     .dispout(tx_disp)
     ) ;
                    
fflopx #(2) pipeline (clk, rst_, {l_trans,l_col},{transmitting,col});


endmodule 
