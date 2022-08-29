////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_lbin.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Sat Jun 21 13:59:00 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_lbin
    (
     //-- RX--
     rxrst_,
     rxclk,
     // RX IN
     rx_idat,
     rx_idv,
     rx_ier,
     rx_ival,
     // RX OUT
     rx_odat,
     rx_odv,
     rx_oer,
     rx_oval,
     //-- TX--
     txclk,
     txrst_,
     // TX IN
     tx_idat,
     tx_ien,
     tx_ier,
     tx_ival,
     // sticky
     lbin_fifowrerr,
     lbin_fiforderr,
     //-- Config--
     uplbin,
     upfifofsh,
     uplbffnum,
     //
     lbin_wdat,
     lbin_wena,
     lbin_wadd,
     
     lbin_rdat,
     lbin_rena,
     lbin_radd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter LBIN_AW = 4,
          LBIN_LW = 16,
          LBIN_DW = 10;
////////////////////////////////////////////////////////////////////////////////
// Port declarations
// RX
input           rxrst_;
input           rxclk;
//
input [7:0]     rx_idat;
input           rx_idv;
input           rx_ier;
input           rx_ival;
//
output [7:0]    rx_odat;
output          rx_odv;
output          rx_oer;
output          rx_oval;
// TX
input           txclk;
input           txrst_;
//    
input [7:0]     tx_idat;
input           tx_ien;
input           tx_ier;
input           tx_ival;
// sticky
output          lbin_fifowrerr;
output          lbin_fiforderr;

// Config
input           uplbin;
input           upfifofsh;
input [3:0]     uplbffnum;
// memory
input  [LBIN_DW-1:0] lbin_rdat;
output               lbin_rena;
output [LBIN_AW-1:0] lbin_radd;

output [LBIN_DW-1:0] lbin_wdat;
output               lbin_wena;
output [LBIN_AW-1:0] lbin_wadd;
////////////////////////////////////////////////////////////////////////////////
// Signal declarations0
reg [7:0]       rx_odat;
reg             rx_odv;
reg             rx_oer;
reg             rx_oval;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
// =============================================================
// &&&&&&&&&&&&&&&&& LoopBack In &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  *************************************
// synch uplbin
//              __________rx1__________    ____rx2______    _____rx3__        ___rx4__
//  RxDv ______|                       |__|             |__|          |______|        |___
//                          ______tx1_______          ____tx2_______    _____tx3___
//  TxEn __________________|                |________|              |__|           |______
//                        _____________________________________
//  uplbin ______________|                                     |__________________________
//                                      ______________________________
//  rx_synlbin ________________________|                              |___________________
//                                           __________________________ 
//  rx2tx_synlbin __________________________|                          |__________________
//                                           ________________________
//  tx_synlbin   ___________________________|                        |____________________
//                                                       _____________                    
//  tx2rx_synlbin    ___________________________________|             |___________________ 
//              _________rx1___________               _____tx2______          ___rx4__
//  RxDv_out __|                       |_____________|              |________|        |___
//
//
wire      rx_synlbin_meta, rx_synlbin;
wire      rx2tx_synlbin_meta, rx2tx_synlbin;

wire      tx_synlbin_meta, tx_synlbin;
wire      tx2rx_synlbin_meta, tx2rx_synlbin;

//
fflopxe #(2) ffrxlbsyn (rxclk, rxrst_, (rx_ival & (!rx_idv)), 
                        {uplbin         , rx_synlbin_meta}, 
                        {rx_synlbin_meta, rx_synlbin});

fflopxe #(2) ffrx2txlbsyn (txclk, txrst_, (tx_ival & (!tx_ien)), 
                           {rx_synlbin          , rx2tx_synlbin_meta}, 
                           {rx2tx_synlbin_meta  , rx2tx_synlbin});

//
fflopxe #(2) fftxlbsyn (txclk, txrst_, (tx_ival & (!tx_ien)), 
                        {uplbin          , tx_synlbin_meta}, 
                        {tx_synlbin_meta , tx_synlbin});

fflopxe #(2) fftx2rxlbsyn (rxclk, rxrst_, (rx_oval & (!rx_odv)), 
                           {tx_synlbin         , tx2rx_synlbin_meta}, 
                           {tx2rx_synlbin_meta , tx2rx_synlbin});

wire      lbin_fifofsh;
assign    lbin_fifofsh = (~(rx_synlbin | tx2rx_synlbin)) | upfifofsh;

///////////////////////////////////////////////////////////////////////////////
// Domain Txclk
wire tx_ien_1;
wire lbin_fifowr;
wire lbin_fifofull;
wire lbin_fifowrerr;
wire lbin_write;
wire [3:0] lbin_wraddr;

assign lbin_fifowrerr= lbin_fifowr & lbin_fifofull;
//
fflopxe #(1) fftxien (txclk, txrst_, tx_ival, tx_ien, tx_ien_1);

assign lbin_fifowr = tx_ival & (tx_ien | tx_ien_1) & (rx2tx_synlbin & tx_synlbin);


reg [9:0] lbin_datipg;

always @(posedge txclk or negedge txrst_)
    begin
    if(!txrst_)
        begin
        lbin_datipg <= 9'b0;
        end
    else if (tx_ival & (~tx_ien))
        begin
        lbin_datipg <= {tx_ier,tx_idat};
        end
    end
//
assign lbin_wena = lbin_write;
assign lbin_wadd = lbin_wraddr;
assign lbin_wdat = {tx_ier, tx_ien, tx_idat};
///////////////////////////////////////////////////////////////////////////////
// Domain Rxclk
wire [9:0] lbin_rddout;   
wire       lbin_rdok;
reg        lbin_state;
wire       lbin_ptknew;

wire       lbin_fiford;
wire       lbin_read;
wire [3:0] lbin_rdaddr;
wire [4:0] lbin_rfifolen;
wire       lbin_rnotempty;
wire       lbin_fiforderr;
//
wire       lbin_rnotempty1; // ram used 2clk
wire       lbin_rnotempty2; // ram used 2clk
assign     lbin_fiforderr = (~lbin_rnotempty2) & lbin_state;
fflopx #(2) fflbinnotemp (rxclk, rxrst_, {lbin_rnotempty,  lbin_rnotempty1},
                                        {lbin_rnotempty1, lbin_rnotempty2});
//
//assign     lbin_ptknew = lbin_rnotempty;
assign     lbin_ptknew = (lbin_rfifolen >= ({1'b0, uplbffnum}));

// state machine
always @(posedge rxclk or negedge rxrst_)
    begin
    if(!rxrst_)
        begin
        lbin_state <= 1'b0;
        end
    else if (rx_synlbin | tx2rx_synlbin)
        begin
        if (lbin_rdok & (~lbin_rddout [8] )) //  ~tx_ien
            begin
            lbin_state <= 1'b0;
            end
        else if (lbin_ptknew)
            begin
            lbin_state <= 1'b1;
            end
        else if (lbin_state)
            begin
            lbin_state <= 1'b1;
            end
        else
            begin
            lbin_state <= 1'b0;
            end
        end
    else lbin_state <= 1'b0;
    end

assign lbin_fiford = (((lbin_ptknew & (~lbin_state)) | lbin_state ) & rx_ival) & 
                     (lbin_rnotempty1 & lbin_rnotempty2);
//
assign lbin_rena = lbin_read;
assign lbin_radd = lbin_rdaddr;

assign lbin_rddout = lbin_rdat;
ipsmacge_delay_k_clk #(2) fflbinrdok (rxclk, rxrst_, lbin_read, lbin_rdok);
////////////////////////////////////////////////////////////
// rx ouput
always @(posedge rxclk or negedge rxrst_)
    begin
    if(!rxrst_)
        begin
        rx_odat <= 8'b0;
        rx_odv  <= 1'b0;
        rx_oer  <= 1'b0;
        rx_oval <= 1'b0;
        end
    else if (rx_synlbin | tx2rx_synlbin)
        begin
        case ({rx_ival, (lbin_state & lbin_rdok)})
            2'b10:
                begin
                rx_odat <= lbin_datipg [7:0];
                rx_odv  <= 1'b0;
                rx_oer  <= lbin_datipg [8];
                rx_oval <= 1'b1;
                end
            2'b11:
                begin
                rx_odat <= lbin_rddout [7:0];
                rx_odv  <= lbin_rddout [8];
                rx_oer  <= lbin_rddout [9];
                rx_oval <= 1'b1;
                end
            default:
                begin
                rx_odat <= rx_odat;
                rx_odv  <= rx_odv;
                rx_oer  <= rx_oer;
                rx_oval <= 1'b0;
                end
        endcase
        end   
    else
        begin
        rx_odat <= rx_idat;
        rx_odv  <= rx_idv;
        rx_oer  <= rx_ier;
        rx_oval <= rx_ival;
        end
    end
//
convclk_grayffctrl #(LBIN_AW, LBIN_LW) igrayffctrl
    (
     .wrclk     (txclk),
     .rdclk     (rxclk),
     .wrrst_    (txrst_),
     .rdrst_    (rxrst_),

     .fifowr    (lbin_fifowr),
     .fiford    (lbin_fiford),
     
     .fifoflush (lbin_fifofsh),
     
     .fifofull  (lbin_fifofull),
     .half_full (),
     .fifonemp  (lbin_rnotempty),

     .rdfifolen (lbin_rfifolen),
     .wrfifolen (),
     
     .write     (lbin_write),
     .wraddr    (lbin_wraddr),
     .read      (lbin_read),
     .rdaddr    (lbin_rdaddr)
     );
       
endmodule
