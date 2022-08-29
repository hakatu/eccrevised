////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
// Filename     : ipsmacge_rxintf.v
// Description  : -> interface with 1 port triple speech 10/100/1000 Mps
//              : -> from phys to mac interface                                 
//
// Author       : nduytuqn@yahoo.com
// Created On   : Mon May 24 16:51:49 2008
// History      :(Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////
module ipsmacge_rxintf
    (
     rxrst_,
     rxclk,
     // input from Phys
     rxhdat,
     rxhctl,
     rxherr,
     rxldat,
     rxlctl,
     rxlerr,
     //
     ogval,
     ogdat,
     ogdv,
     oger,
     // cpu interface
     up_act,
     up_pos,
     up_gmii,
     up_mspd
     );
////////////////////////////////////////////////////////////////////////////////
// parameter declarations
parameter DAT_DW = 8;

parameter MSP_DW = 2;

parameter MRESERVE = 2'b11, // reserve
          M1000    = 2'b10, // speed 1000 Mbps, rxclk 125Mhz
          M100     = 2'b01, // speed 100 Mbps, rxclk 25Mhz, 
          M10      = 2'b00; // speed 10 Mbps, rxclk 2.5Mhz
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
// Help
// {mgmii,mspd}
// {1,00} -> MII   speed 10   Mbps, rxclk 2.5Mhz
// {1,01} -> MII   speed 100  Mbps, rxclk 25Mhz
// {1,1x} -> GMII  speed 1000 Mbps, rxclk 125Mhz
// {0,00} -> RGMII speed 10   Mbps, rxclk 2.5Mhz
// {0,01} -> RGMII speed 100  Mbps, rxclk 25Mhz
// {0,1x} -> RGMII speed 1000 Mbps, rxclk 125Mhz
////////////////////////////////////////////////////////////////////////////////
// input declarations
input     rxrst_;
input     rxclk;

input [DAT_DW-1:0] rxhdat;
input [DAT_DW-1:0] rxldat;
input              rxhctl;
input              rxlctl;
input              rxherr;
input              rxlerr;
// output
output [DAT_DW-1:0]ogdat;
output             ogdv;
output             oger;
output             ogval;
// cpu interface
input              up_act;
input [MSP_DW-1:0] up_mspd;
input              up_gmii;
input              up_pos;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
wire               rxhctl_1, rxhctl_2;
wire               rxlctl_1, rxlctl_2;

wire               rxherr_1, rxherr_2;
wire               rxlerr_1, rxlerr_2;

wire [DAT_DW-1:0]  rxhdat_1, rxhdat_2;
wire [DAT_DW-1:0]  rxldat_1, rxldat_2;
///
reg [DAT_DW-1:0]   ogdat;
reg                ogval;
reg                ogdv;
reg                oger;
reg                evalid;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
fflopx #(1*2) ff2rxhctl (rxclk, rxrst_, {rxhctl, rxhctl_1}, {rxhctl_1, rxhctl_2});
fflopx #(1*2) ff2rxlctl (rxclk, rxrst_, {rxlctl, rxlctl_1}, {rxlctl_1, rxlctl_2});

fflopx #(1*2) ff2rxherr (rxclk, rxrst_, {rxherr, rxherr_1}, {rxherr_1, rxherr_2});
fflopx #(1*2) ff2rxlerr (rxclk, rxrst_, {rxlerr, rxlerr_1}, {rxlerr_1, rxlerr_2});

fflopx #(DAT_DW*2) ff2rxhdat (rxclk, rxrst_, {rxhdat, rxhdat_1}, {rxhdat_1, rxhdat_2});
fflopx #(DAT_DW*2) ff2rxldat (rxclk, rxrst_, {rxldat, rxldat_1}, {rxldat_1, rxldat_2});

// rgmii/mii data valid mode speed 10/100 Mbps
always @ (posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)                     evalid <= 1'b0;
    else if (!rxhctl_2 & rxhctl_1)   evalid <= 1'b1; // is first nipple of first bytes data received
    else                             evalid <= ~evalid;
    end

always @ (posedge rxclk or negedge rxrst_)
    begin
    if (!rxrst_)
        begin
        ogdat <= {DAT_DW{1'b0}};
        ogval <= 1'b0;
        ogdv  <= 1'b0;
        oger  <= 1'b0;
        end
    else if (~up_act)
        begin
        ogdat <= {DAT_DW{1'b0}};
        ogval <= 1'b0;
        ogdv  <= 1'b0;
        oger  <= 1'b0;
        end
    else
        begin
        if (!up_gmii) // RGMII Interface
            begin
            case (up_mspd)
                MRESERVE:
                    begin
                    ogdat <= {DAT_DW{1'b0}};
                    ogval <= 1'b0;
                    ogdv  <= 1'b0;
                    oger  <= 1'b0;
                    end
                M1000:
                    begin
                    ogdat <= {rxldat_2 [3:0], rxhdat_2 [3:0]};
                    ogval <= 1'b1;
                    ogdv  <= rxhctl_2;
                    oger  <= rxhctl_2 ^ rxlctl_2;
                    end
                default:
                    begin
                    ogval <= evalid;
                    ogdat <= evalid ? (up_pos ? {rxhdat_1 [3:0], rxhdat_2 [3:0]} : {rxldat_1[3:0], rxldat_2 [3:0]}) : ogdat;
                    ogdv  <= rxhctl_2;
                    oger  <= rxhctl_2 ^ rxlctl_2;
                    end
            endcase
            end
        else // GMII or MII Interface
            begin
            case (up_mspd)
                MRESERVE:
                    begin
                    ogdat <= {DAT_DW{1'b0}};
                    ogval <= 1'b0;
                    ogdv  <= 1'b0;
                    oger  <= 1'b0;
                    end
                M1000:
                    begin
                    ogval <= 1'b1;
                    ogdat <= up_pos ? rxhdat_2 : rxldat_2;
                    ogdv  <= up_pos ? rxhctl_2 : rxlctl_2;
                    oger  <= up_pos ? rxherr_2 : rxlerr_2;
                    end
                default:
                    begin
                    ogval <= evalid;
                    ogdat <= evalid ? (up_pos ? {rxhdat_1 [3:0], rxhdat_2 [3:0]} : {rxldat_1[3:0], rxldat_2 [3:0]}) : ogdat;
                    ogdv  <= up_pos ? rxhctl_2 : rxlctl_2;
                    oger  <= up_pos ? rxherr_2 : rxlerr_2;
                    end
            endcase
            end
        end
    end

endmodule