////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_rx2clk.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Thu Jul 24 09:53:06 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_rx2clk
    (
     wrst_,
     // write
     wclk, // line clk 125/25/2.5
     wvld,
     wdat,
     // read
     rrst_,
     rclk, // sys clk 77
     rdat,
     rvld,
     //
     rerr
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter BUS_AW = 2,
          BUS_NU = 2,
          BUS_DW = 36;
//
parameter BUS_I0 = 2'd0,
          BUS_I1 = 2'd1,
          BUS_I2 = 2'd2;
////////////////////////////////////////////////////////////////////////////////
// Port declarations
//
input                   wrst_;
input                   wclk;
input                   wvld;
input  [BUS_DW-1:0]     wdat;
// out
input                   rrst_;
input                   rclk;
output [BUS_DW-1:0]     rdat;
output                  rvld;
// Alarm
output                  rerr;

////////////////////////////////////////////////////////////////////////////////
//----------------------------------
// domain wclk
//----------------------------------
wire [1:0]              wvld_bus0;
wire [1:0]              wvld_bus1;
wire [1:0]              wvld_bus2;
//
reg [BUS_DW-1:0]        edat_bus0;
reg [BUS_DW-1:0]        edat_bus1;
reg [BUS_DW-1:0]        edat_bus2;
//
wire                    wchn_bus;
wire                    wnewp_bus0;
wire                    wnewp_bus1;
wire                    wnewp_bus2;
reg [BUS_AW-1:0]        wptr_busid;
//----------------------------------
// domain rclk
//----------------------------------
reg [BUS_DW-1:0]        rdat;
reg                     rvld;
wire                    rdnewdat_bus0;
wire                    rdnewdat_bus1;
wire                    rdnewdat_bus2;
wire [2:0]              regsynwvld_bus0;
wire [2:0]              regsynwvld_bus1;
wire [2:0]              regsynwvld_bus2;
reg [BUS_AW-1:0]        rptr;
wire                    rdnew;
wire                    rdcol;
wire                    rdcol_1;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//----------------------------------
// domain wclk
//----------------------------------
// wptr_pid process
//assign winf_bus = mrdat [33:32] ;
assign wchn_bus = wvld;
//
always @(posedge wclk or negedge wrst_)
    begin
    if (!wrst_)         wptr_busid <= BUS_I0;
    else if (wchn_bus)
        begin
        case (wptr_busid)
            BUS_I0:     wptr_busid <= BUS_I1;
            BUS_I1:     wptr_busid <= BUS_I2;
            BUS_I2:     wptr_busid <= BUS_I0;
            default:    wptr_busid <= BUS_I0;
        endcase
        end
    end

assign wnewp_bus0 = (wptr_busid == BUS_I0) & wvld;
assign wnewp_bus1 = (wptr_busid == BUS_I1) & wvld;
assign wnewp_bus2 = (wptr_busid == BUS_I2) & wvld;

fflopx #(2) ffwvldbus0 (wclk, wrst_, {(wnewp_bus0 | wvld_bus0 [0]), wnewp_bus0},  wvld_bus0 [1:0]);
fflopx #(2) ffwvldbus1 (wclk, wrst_, {(wnewp_bus1 | wvld_bus1 [0]), wnewp_bus1},  wvld_bus1 [1:0]);
fflopx #(2) ffwvldbus2 (wclk, wrst_, {(wnewp_bus2 | wvld_bus2 [0]), wnewp_bus2},  wvld_bus2 [1:0]);
//--------------------------------
// bus process
//--------------------------------
always @(posedge wclk or negedge wrst_)
    begin
    if (!wrst_)
        begin
        edat_bus0 <= {BUS_DW{1'b0}};
        edat_bus1 <= {BUS_DW{1'b0}};
        edat_bus2 <= {BUS_DW{1'b0}};
        end
    else
        begin
        if (wnewp_bus0) edat_bus0 <= wdat;
        if (wnewp_bus1) edat_bus1 <= wdat;
        if (wnewp_bus2) edat_bus2 <= wdat;
        end
    end

//-------------------------------- 
// domain rclk
//--------------------------------
fflopx #(3) ffw2r_bus0 (rclk, rrst_, {regsynwvld_bus0 [1:0], wvld_bus0 [1]}, {regsynwvld_bus0 [2:0]});
fflopx #(3) ffw2r_bus1 (rclk, rrst_, {regsynwvld_bus1 [1:0], wvld_bus1 [1]}, {regsynwvld_bus1 [2:0]});
fflopx #(3) ffw2r_bus2 (rclk, rrst_, {regsynwvld_bus2 [1:0], wvld_bus2 [1]}, {regsynwvld_bus2 [2:0]});

assign rdnewdat_bus0 = ~regsynwvld_bus0 [2] & regsynwvld_bus0 [1];
assign rdnewdat_bus1 = ~regsynwvld_bus1 [2] & regsynwvld_bus1 [1];
assign rdnewdat_bus2 = ~regsynwvld_bus2 [2] & regsynwvld_bus2 [1];

//assign rdnew = rdnewdat_bus0 | rdnewdat_bus1 | rdnewdat_bus2;
assign rdnew = rdnewdat_bus0 | rdnewdat_bus1 | rdnewdat_bus2 | rdcol_1;
assign rdcol = ((rdnewdat_bus0 & rdnewdat_bus1) |
                (rdnewdat_bus1 & rdnewdat_bus2) |
                (rdnewdat_bus2 & rdnewdat_bus0) );

fflopx #(1) ffrdcol (rclk, rrst_, rdcol, rdcol_1);

always @(posedge rclk or negedge rrst_)
    begin
    if (!rrst_)         rptr <= BUS_I0;
    else if (rdcol_1)
        begin
        case (rptr)
            BUS_I0:     rptr <= BUS_I1;
            BUS_I1:     rptr <= BUS_I2;
            BUS_I2:     rptr <= BUS_I0;
            default:    rptr <= BUS_I0;
        endcase
        end
    else
        begin
        case ({rdnewdat_bus0, rdnewdat_bus1, rdnewdat_bus2})
            3'b100:     rptr <= BUS_I1;
            3'b110:     rptr <= BUS_I1;
            3'b010:     rptr <= BUS_I2;
            3'b011:     rptr <= BUS_I2;
            3'b001:     rptr <= BUS_I0;
            3'b101:     rptr <= BUS_I0;
            default:    rptr <= rptr;
        endcase
        end
    end

always @(posedge rclk or negedge rrst_)
    begin
    if (!rrst_)      rdat <= {BUS_DW{1'b0}};
    else if (rdnew)
        begin
        case (rptr)
            BUS_I0:  rdat <= edat_bus0;
            BUS_I1:  rdat <= edat_bus1;
            BUS_I2:  rdat <= edat_bus2;
            default: rdat <= edat_bus0;
        endcase
        end
    else             rdat <= {BUS_DW{1'b0}};
    end

always @(posedge rclk or negedge rrst_)
    begin
    if (!rrst_)      rvld <= 1'b0;
    else             rvld <= rdnew;
    end

wire [BUS_AW-1:0] rptr_l;
fflopxe #(BUS_AW) flxerptr_l
    (rclk, rrst_, rvld, rptr, rptr_l);

reg        rerr;
always @(posedge rclk or negedge rrst_)
    begin
    if (!rrst_)      rerr <= 1'b0;
    else if (rvld)
        begin
        case (rptr_l)
            BUS_I0:  rerr <= (rptr != BUS_I1);
            BUS_I1:  rerr <= (rptr != BUS_I2);
            BUS_I2:  rerr <= (rptr != BUS_I0);
            default: rerr <= 1'b1;
        endcase
        end
    else             rerr <= 1'b0;
    end

endmodule