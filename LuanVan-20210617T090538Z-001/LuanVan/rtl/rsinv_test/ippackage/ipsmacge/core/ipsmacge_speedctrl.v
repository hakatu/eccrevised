////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_monrxinfo.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Sun Feb 15 16:18:53 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_speedctrl
    (
     // from phy,
     rxrst_,
     rxclk,
     iifovld,
     iifodat,
     // from & to select clock
     txclk,
     txrst_,
     oselclk,
     // to txframing
     ostable,
     omodspd,
     // cpu read
     stacapdat,
     stamodspd,
     staselclk,
     // cpu config
     pautodis,
     pmodspd,
     pstable,
     pmodgmii
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
// Help
// {mgmii,mspd}
// {1,00} -> MII   speed 10   Mbps, clk 2.5Mhz
// {1,01} -> MII   speed 100  Mbps, clk 25Mhz
// {1,1x} -> GMII  speed 1000 Mbps, clk 125Mhz
// {0,00} -> RGMII speed 10   Mbps, clk 2.5Mhz
// {0,01} -> RGMII speed 100  Mbps, clk 25Mhz
// {0,1x} -> RGMII speed 1000 Mbps, clk 125Mhz

// oselclk [1:0]
// 00: txclk = phy_txclk input (only  mode MII) or refclk125
// 01: txclk = pin input clk 2.5
// 10: txclk = pll output clk 125 Mhz
// 11: txclk = pll output clk 25 Mhz

////////////////////////////////////////////////////////////////////////////////
// input declarations
input           rxrst_;
input           rxclk;
     // from rxframing
input           iifovld;
input [7:0]     iifodat;
     // from & to select clock
input           txclk;
input           txrst_;
output [1:0]    oselclk;
     // to txframing
output          ostable;
output [1:0]    omodspd;
     // cpu read
output [7:0]    stacapdat;
output [1:0]    stamodspd;
output [1:0]	staselclk;
     // cpu config
input           pstable;
input           pautodis;
input [1:0]     pmodspd;
input           pmodgmii;

////////////////////////////////////////////////////////////////////////////////
// signal declarations0

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [1:0]       omodspd;
assign          stamodspd = omodspd;

wire [7:0]      rcvdat;
fflopxe #(8)    ffrcvcap (rxclk, rxrst_, iifovld, iifodat, rcvdat);

assign          stacapdat = rcvdat;

wire [1:0]      rcvspeed;
assign          rcvspeed = rcvdat [2:1];

always @(pautodis or pmodspd or rcvspeed)
    begin
    case (pautodis)
        1'b1:   omodspd <= pmodspd;
        1'b0:   omodspd <= rcvspeed;
    endcase
    end

reg [1:0]       oselclk;
assign 			staselclk = oselclk;

always @(pmodgmii or pautodis or rcvspeed or pmodspd)
    begin
    case (pautodis)
        1'b1:   
            begin
            case (pmodspd)
                2'b00:  oselclk <= pmodgmii ? 2'b00 : 2'b01;
                2'b01:  oselclk <= pmodgmii ? 2'b00 : 2'b11;
                default:oselclk <= pmodgmii ? 2'b10 : 2'b10;
            endcase
            end
        1'b0:
            begin
            case (rcvspeed)
                2'b00:  oselclk <= pmodgmii ? 2'b00 : 2'b01;
                2'b01:  oselclk <= pmodgmii ? 2'b00 : 2'b11;
                default:oselclk <= pmodgmii ? 2'b10 : 2'b10;
            endcase
            end
    endcase
    end

fflopx #(1) ffostable (txclk, txrst_, pstable, ostable);

endmodule
