////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_rxshift.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Sat May 31 11:20:57 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_rxshift
    (
     rxclk,
     rxrst_,
     // from rxframing
     rx_idat, 
     rx_isop,  
     rx_ieop,  
     rx_ivld,  
     rx_ierr,
     // to fifo convert
     out_dat,
     out_nob,
     out_sop,  
     out_eop,  
     out_vld,  
     out_err
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;
parameter DAT_EW = 4;

parameter MAC_DW = 32; // Mac interface, Data input Width, width of register shift
parameter MAC_BW = 2;  // Mac interface, Number Byte Valid Width

parameter SHIFT_DW = MAC_DW - DAT_DW;
parameter VLD_1B = 2'h0,
          VLD_2B = 2'h1,
          VLD_3B = 2'h2,
          VLD_4B = 2'h3;
////////////////////////////////////////////////////////////////////////////////
// input declarations
input     rxrst_;
input     rxclk;
// framing
input  [DAT_DW-1:0] rx_idat;
input               rx_ivld;
input               rx_isop;
input               rx_ieop;
input  [DAT_EW-1:0] rx_ierr;
// out
output [MAC_DW-1:0] out_dat;
output [MAC_BW-1:0] out_nob;

output              out_vld;
output              out_sop;
output              out_eop;
output [DAT_EW-1:0] out_err;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
// out
reg  [MAC_DW-1:0]   out_dat;
wire [MAC_BW-1:0]   out_nob;
// shift
reg [MAC_BW-1:0]    bvld_cnt;
reg [SHIFT_DW-1:0]  shift_dat;
reg                 shift_sop;
reg [DAT_EW-1:0]    shift_err;
wire                shift_out;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

//--------------------------------
// shift process
//--------------------------------

always @(posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)            bvld_cnt <= {(MAC_BW){1'b0}};
    else if (rx_ivld)
        begin
        if (rx_isop)        bvld_cnt <= {(MAC_BW){1'b0}} + 1'b1;
        else if (shift_out) bvld_cnt <= {(MAC_BW){1'b0}};
        else                bvld_cnt <= bvld_cnt + 1'b1;
        end
    end

integer i;

always @(posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)
        begin
        shift_sop <= 1'b0;
        shift_err <= {DAT_EW{1'b0}};
        end
    else if (rx_ivld)
        begin
        if (rx_isop)         shift_sop <= 1'b1;
        else if (shift_out)  shift_sop <= 1'b0;
        else                 shift_sop <= shift_sop;
        //
        if (rx_isop)         shift_err <= rx_ierr;
        else if (shift_out)  shift_err <= rx_ierr;
        else
            begin
            for (i = 0; i < DAT_EW; i = i + 1)
                shift_err [i] <= rx_ierr [i] ? 1'b1 : shift_err [i];
            end
        end
    end

always @(posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)        shift_dat <= {SHIFT_DW{1'b0}};
    else if (rx_ivld)   shift_dat <= {shift_dat [SHIFT_DW-DAT_DW-1:0], rx_idat};
    end
//--------------------------------
// output
//--------------------------------
assign shift_out = rx_ivld & (rx_ieop | (bvld_cnt == {MAC_BW{1'b1}}));

fflopx #(MAC_BW) ffoutnob (rxclk, rxrst_, bvld_cnt, out_nob);
always @(posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)      out_dat <= {(MAC_DW){1'b0}};
    else if (shift_out)
        begin
        case (bvld_cnt)
            VLD_1B: out_dat <= {rx_idat, {SHIFT_DW{1'b0}}};
            VLD_2B: out_dat <= {shift_dat [1*DAT_DW-1:0], rx_idat, {2*DAT_DW{1'b0}}};
            VLD_3B: out_dat <= {shift_dat [2*DAT_DW-1:0], rx_idat, {1*DAT_DW{1'b0}}};
            VLD_4B: out_dat <= {shift_dat, rx_idat};
            default:out_dat <= {shift_dat, rx_idat};
        endcase
        end
    end

///////////////////////////////////////////////////

// number byte valid in bus
// 00: 1 byte valid
// 01: 2 byte valid
// 10: 3 byte valid
// 11: 4 byte valid

fflopx #(1) ovld (rxclk, rxrst_, shift_out, out_vld);
fflopx #(1) oeop (rxclk, rxrst_, rx_ieop, out_eop);
fflopx #(1) osop (rxclk, rxrst_, (shift_out & shift_sop), out_sop);
fflopx #(DAT_EW) oerr (rxclk, rxrst_, (rx_ieop ? rx_ierr : shift_err), out_err);

endmodule
