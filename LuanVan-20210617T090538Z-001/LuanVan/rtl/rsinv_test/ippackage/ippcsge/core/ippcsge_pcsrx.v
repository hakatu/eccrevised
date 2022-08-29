////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : pcsrx.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Fri Aug 20 15:33:08 2004
// History (Date, Changed By) changed and modified by lqson
//
////////////////////////////////////////////////////////////////////////////////

module ippcsge_pcsrx
    (
     clk,
     rst_,

     //Carrier sense signals
    // carr_det,
     receiving,
     
     //configuration signals
     rudi,  //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
     xmit,
     cfdata,

     //syn block signals
     rx_even,
     sync,
     code_err,
     di,

     //GMII signals
     rxdv,
     rxer,
     do,
     rx_state,
     k,
     data_ind
     );

////////////////////////////////////////////////////////////////////////////////

// Port declarations
input           clk, rst_;
//input  carr_det;
output [1:0]    rudi;   //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
output          receiving;
input [1:0]     xmit;
output [15:0]   cfdata;
input           sync, rx_even;
input           code_err;
input [8:0]     di; //[8]-k [7:0]-decoded data
output          rxdv, rxer;
output [7:0]    do;
output [4:0]    rx_state;
output          k;
output          data_ind;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

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

parameter       D0_0  = 9'h000;
parameter       D21_5 = 9'h0B5;
parameter       D2_2  = 9'h042;
parameter       D5_6  = 9'h0C5;
parameter       D16_2 = 9'h050;

parameter       LINK_FAILED         = 5'd0;
parameter       WAIT_FOR_K          = 5'd1;
parameter       RX_K                = 5'd2;
parameter       RX_CB               = 5'd3;
parameter       RX_CC               = 5'd4;
parameter       RX_CD               = 5'd5;
parameter       IDL_D               = 5'd6;
parameter       CARRIER_DET         = 5'd7;
parameter       FALSE_CARR          = 5'd8;
parameter       RX_INVALID          = 5'd9;
parameter       START_OF_PACKET     = 5'd10;
parameter       RECEIVE             = 5'd11;
parameter       EARLY_END           = 5'd12;
parameter       TRI_RRI             = 5'd13;
parameter       TRR_EXTEND          = 5'd14;
parameter       RX_DATA_ERR         = 5'd15;
parameter       RX_DATA             = 5'd16;
parameter       EARLY_END_EXT       = 5'd17;
parameter       EPD2_CHECK_END      = 5'd18;
parameter       EXTEND_ERR          = 5'd19;
parameter       PACKET_BURST_RRS    = 5'd20;

parameter       RUDI_INVLD  = 2'b11;
parameter       RUDI_I      = 2'b10;
parameter       RUDI_C      = 2'b01;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

//wire        xmit_IDL;
wire        xmit_CFG;
wire        xmit_DAT;

wire [1:0]  xmit1;
fflopx #(2) pline_xmit (clk, rst_, xmit, xmit1);
 
//assign      xmit_IDL = (xmit1 == 2'd0);
assign      xmit_CFG = (xmit1 == 2'd1);
assign      xmit_DAT = (xmit1 == 2'd2);

wire        l_sync;
fflopx #(1) pline_sync  (clk, rst_, sync,l_sync);

wire [8:0]  l_di;
fflopx #(9) pline_di  (clk, rst_, di,l_di);

wire        l_code_err;
fflopx #(1) pline_code_err  (clk, rst_, code_err,l_code_err);

wire        l_rx_even;
fflopx #(1) plrx_even (clk, rst_, rx_even, l_rx_even);

reg [1:0]   rudi;   //2'b11 RUDI(INVALID), 2'b10 RUDI(/I/), 2'b01 RUDI(/C/)
reg [15:0]  cfdata;
reg         receiving, rxdv, rxer;

reg [17:0]  check_end_reg;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)  check_end_reg <= 18'b0;
    else        check_end_reg <= {check_end_reg[8:0],di};
    end

wire [26:0] check_end;
assign      check_end = {check_end_reg,di};


wire        chkend_TRK28_5, chkend_TRR, chkend_RRR, chkend_RRS, chkend_RRK28_5, chkearly_end;
/*
assign      chkend_TRK28_5 = (check_end == {K29_7,K23_7,K28_5});
assign      chkend_TRR = (check_end == {K29_7,K23_7,K23_7});
assign      chkend_RRR = (check_end == {K23_7,K23_7,K23_7});
assign      chkend_RRS = (check_end == {K23_7,K23_7,K27_7});
assign      chkend_RRK28_5 = (check_end == {K23_7,K23_7,K28_5});
assign      chkearly_end = ((check_end == {K28_5,1'b0,check_end_reg[16:9],K28_5}) |
                            (check_end == {K28_5,D21_5,D0_0}) |
                            (check_end == {K28_5,D2_2,D0_0})) ;
*/
fflopx #(1) pline_1 (clk, rst_,  (check_end == {K29_7,K23_7,K28_5}),chkend_TRK28_5);
fflopx #(1) pline_2 (clk, rst_,  (check_end == {K29_7,K23_7,K23_7}),chkend_TRR);
fflopx #(1) pline_3 (clk, rst_,  (check_end == {K23_7,K23_7,K23_7}),chkend_RRR);
fflopx #(1) pline_4 (clk, rst_,  (check_end == {K23_7,K23_7,K27_7}),chkend_RRS);
fflopx #(1) pline_5 (clk, rst_,  (check_end == {K23_7,K23_7,K28_5}),chkend_RRK28_5);
fflopx #(1) pline_6 (clk, rst_,  ((check_end == {K28_5,1'b0,check_end_reg[16:9],K28_5}) |
                            (check_end == {K28_5,D21_5,D0_0}) |
                           (check_end == {K28_5,D2_2,D0_0})), chkearly_end);

 
wire [8:0]  di1, di2;
fflopx #(18) pldi (clk, rst_, {l_di,di1}, {di1, di2});

       
//rx state machine
reg [4:0]   rx_state;
wire        k;
assign      k = di2[8];

wire        code_err1,code_err2;
fflopx #(2) plcode_err (clk, rst_, {l_code_err, code_err1},{code_err1, code_err2});

wire        data_ind;
fflopx #(1) pl_dataind (clk, rst_,(!code_err1 & !di1[8]),data_ind);

reg [7:0]   do;
wire [7:0]  ldi;
fflopx #(8) pldi4 (clk, rst_, di2[7:0], ldi);

always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)
        begin
        rx_state    <= WAIT_FOR_K;
        rudi        <= 2'b00;
        receiving   <= 1'b0;
        rxdv        <= 1'b0;
        rxer        <= 1'b0;  
        do          <= 8'b0;
        cfdata      <= 16'b0;
        end
    else if (~l_sync)
        begin
        rx_state <= LINK_FAILED;
        rxdv     <= 1'b0;//note 
        end
    else
        case (rx_state)
            LINK_FAILED:
                begin
                rx_state <= WAIT_FOR_K;             
                if (xmit_DAT)   rudi <= RUDI_INVLD;
                if (receiving)  
                    begin
                    receiving <= 1'b0;
                    rxer      <= 1'b1;
                    end
                else
                    begin
                    rxdv    <= 1'b0;
                    rxer    <= 1'b0;
                    end
                end
            WAIT_FOR_K:
                begin
                if ((di2 == K28_5) & l_rx_even)    rx_state <= RX_K;
                receiving <= 1'b0;
                rxdv <= 1'b0;
                rxer <= 1'b0;
                end
            RX_K:
                begin
                if ((di2 == D21_5) | (di2 == D2_2))                             rx_state <= RX_CB;
                else
                if (!data_ind & !xmit_DAT)                                    rx_state <= RX_INVALID;
                else
                if ((!xmit_DAT & data_ind & (di2 != D21_5) & (di2 != D2_2)) |
                    (xmit_DAT & (di2 != D21_5) & (di2 != D2_2)))                rx_state <= IDL_D;
                receiving <= 1'b0;
                rxdv      <= 1'b0;
                rxer      <= 1'b0;
                end
            RX_CB:
                begin
                if (data_ind)   rx_state <= RX_CC;
                else            rx_state <= RX_INVALID;
                receiving <= 1'b0;
                rxdv      <= 1'b0;
                rxer      <= 1'b0;
                end
            RX_CC:
                begin
                if (data_ind)   rx_state <= RX_CD;
                else            rx_state <= RX_INVALID;
                cfdata[7:0] <= ldi[7:0];
                end
            RX_CD:
                begin
                if (l_rx_even & (di2 == K28_5))    rx_state <= RX_K;
                else                            rx_state <= RX_INVALID;
                cfdata[15:8] <= ldi[7:0];
                rudi <= RUDI_C;             
                end
            RX_INVALID:
                begin
                if (l_rx_even & (di2 == K28_5))        rx_state <= RX_K;
                if (l_rx_even & (di2 != K28_5))        rx_state <= WAIT_FOR_K;
                if (xmit_CFG)       rudi <= RUDI_INVLD;
                if (xmit_DAT)       receiving <= 1'b1;
                end
            IDL_D:
                begin
                if (!xmit_DAT & (di2 != K28_5))       rx_state <= RX_INVALID;
                else if (di2 == K28_5)                rx_state <= RX_K;
                else if (xmit_DAT & (di2 == K27_7))   rx_state <= START_OF_PACKET;
                else if (xmit_DAT & (di2 != K27_7))   rx_state <= FALSE_CARR;
                receiving <= 1'b0;
                rxdv <= 1'b0;
                rxer <= 1'b0;
                rudi <= RUDI_I;
                end
            FALSE_CARR:
                begin
                //CARRIER_DET
                receiving <= 1'b1;
                //FALSE_CARR
                if ((di2 == K28_5) & l_rx_even)       rx_state <= RX_K;               
                rxer <= 1'b1;
                do   <= 8'b0000_1110;
                end
            START_OF_PACKET:
                begin
                //CARRIER_DET
                receiving <= 1'b1;
                //START_OF_PACKET
                if (chkearly_end & l_rx_even)         rx_state <= EARLY_END;
                else if (chkend_TRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                else if (chkend_TRR)                rx_state <= TRR_EXTEND;
                else if (chkend_RRR)                rx_state <= EARLY_END_EXT;
                else if (data_ind)                  rx_state <= RX_DATA;
                else                                rx_state <= RX_DATA_ERR;
                //end RECEIVE state
                rxdv <= 1'b1;
                rxer <= 1'b0;
                do   <= 8'b0101_0101;
                end
            EARLY_END:
                begin
                if ((di2 == D21_5) | (di2 == D2_2))   rx_state <= RX_CB;
                else                                  rx_state <= IDL_D;
                rxer <= 1'b1;
                end
            TRI_RRI:
                begin
                if (di2 == K28_5)                    rx_state <= RX_K;
                receiving <= 1'b0;
                rxdv <= 1'b0;
                rxer <= 1'b0;
                end
            TRR_EXTEND:
                begin
                //EPD2_CHECK_END state
                if (chkend_RRR)                     rx_state <= TRR_EXTEND;
                else if (chkend_RRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                else if (chkend_RRS)                rx_state <= PACKET_BURST_RRS;
                else                                rx_state <= EXTEND_ERR;
                //end EPD2_CHECK_END state
                rxdv <= 1'b0;
                rxer <= 1'b1;
                do   <= 8'b0000_1111;
                end
            PACKET_BURST_RRS:
                begin
                if (di2 == K27_7)                    rx_state <= START_OF_PACKET;
                rxdv <= 1'b0;
                do   <= 8'b0000_1111;
                end
            EXTEND_ERR:
                begin
                if (di2 == K27_7)                    rx_state <= START_OF_PACKET;
                else if ((di2 == K28_5) & l_rx_even)   rx_state <= RX_K;
                else if ((di2 != K27_7) & (di2 != K28_5) & l_rx_even)   //EPD2_CHECK_END
                    begin
                    if (chkend_RRR)                     rx_state <= TRR_EXTEND;
                    else if (chkend_RRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                    else if (chkend_RRS)                rx_state <= PACKET_BURST_RRS;
                    else                                rx_state <= EXTEND_ERR;
                    end
                rxdv <= 1'b0;
                do   <= 8'b0001_1111;
                end
            EARLY_END_EXT:
                begin
                //EPD2_CHECK_END state
                if (chkend_RRR)                     rx_state <= TRR_EXTEND;
                else if (chkend_RRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                else if (chkend_RRS)                rx_state <= PACKET_BURST_RRS;
                else                                rx_state <= EXTEND_ERR;
                //end EPD2_CHECK_END state
                rxer <= 1'b0;
                end
            RX_DATA:
                begin
                // RECEIVE state
                if (chkearly_end & l_rx_even)         rx_state <= EARLY_END;
                else if (chkend_TRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                else if (chkend_TRR)                rx_state <= TRR_EXTEND;
                else if (chkend_RRR)                rx_state <= EARLY_END_EXT;
                else if (data_ind)                  rx_state <= RX_DATA;
                else                                rx_state <= RX_DATA_ERR;
                //end RECEIVE state
                rxer <= 1'b0;
                do   <= ldi[7:0];
                end
            RX_DATA_ERR:
                begin
                // RECEIVE state
                if (chkearly_end & l_rx_even)         rx_state <= EARLY_END;
                else if (chkend_TRK28_5 & l_rx_even)  rx_state <= TRI_RRI;
                else if (chkend_TRR)                rx_state <= TRR_EXTEND;
                else if (chkend_RRR)                rx_state <= EARLY_END_EXT;
                else if (data_ind)                  rx_state <= RX_DATA;
                else                                rx_state <= RX_DATA_ERR;
                //end RECEIVE state
                rxer <= 1'b1;
                end
            default:                                rx_state <= WAIT_FOR_K;
        endcase
    end

endmodule 
