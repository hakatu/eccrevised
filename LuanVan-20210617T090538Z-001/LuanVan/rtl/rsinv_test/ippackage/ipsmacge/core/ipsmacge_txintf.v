////////////////////////////////////////////////////////////////////////////////
//                                                                              
// Arrive Technologies                                                          
//------------------------------------------------------------------------------
// Filename     : ipsmacge_txintf.v
// Description  : -> interface with 1 port triple speech 10/100/1000 Mps        
//              : -> from phys to mac interface                                 
//              :                                                               
//                                                                              
// Author       : nduytuqn@yahoo.com                                            
// Created On   : Mon Jun 09 12:42:14 2008
// History      :(Date, Changed By)                                             
//                                                                              
////////////////////////////////////////////////////////////////////////////////
module ipsmacge_txintf
    (
     txrst_,
     txclk,
     //
     txhdat,
     txldat,
     txhctl,
     txlctl,
     txherr,
     txlerr,
     //
     igdat,
     igval,
     igen,
     iger,
     // cpu interface
     up_act,
     up_gmii,
     up_spd
     );
///////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_DW = 8;
parameter MSP_DW = 2; // mode speed operation

parameter MRESERVE = 2'b11, // reserve
          M1000    = 2'b10, // speed 1000 Mbps, clk 125Mhz
          M100     = 2'b01, // speed 100 Mbps, clk 25Mhz, 
          M10      = 2'b00; // speed 10 Mbps, clk 2.5Mhz
// Help
// {mgmii,up_spd}
// {1,00} -> MII   speed 10   Mbps, clk 2.5Mhz
// {1,01} -> MII   speed 100  Mbps, clk 25Mhz
// {1,1x} -> GMII  speed 1000 Mbps, clk 125Mhz
// {0,00} -> RGMII speed 10   Mbps, clk 2.5Mhz
// {0,01} -> RGMII speed 100  Mbps, clk 25Mhz
// {0,1x} -> RGMII speed 1000 Mbps, clk 125Mhz
////////////////////////////////////////////////////////////////////////////////
// input declarations
input               txrst_;
input               txclk;
// gmii interface
input  [DAT_DW-1:0] igdat;
input               igval;
input               igen;
input               iger;
// interface with ddio ouput
output [DAT_DW-1:0] txhdat;
output [DAT_DW-1:0] txldat;
output              txhctl;
output              txlctl;
output              txherr;
output              txlerr;
// cpu interface
input [MSP_DW-1:0]  up_spd;
input               up_gmii;
input               up_act;
////////////////////////////////////////////////////////////////////////////////
// signal declarations0
reg [DAT_DW-1:0]    txhdat;
reg [DAT_DW-1:0]    txldat;
reg                 txhctl;
reg                 txlctl;
reg                 txherr;
reg                 txlerr;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//---------------------------------------------
//  GMII to RGMII Interface
//---------------------------------------------
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)
        begin
        txhdat <= {DAT_DW{1'b0}};
        txldat <= {DAT_DW{1'b0}};
        txhctl <= 1'b0;
        txlctl <= 1'b0;
        txherr <= 1'b0;
        txlerr <= 1'b0;
        end
    else if (~up_act)
        begin
        txhdat <= {DAT_DW{1'b0}};
        txldat <= {DAT_DW{1'b0}};
        txhctl <= 1'b0;
        txlctl <= 1'b0;
        txherr <= 1'b0;
        txlerr <= 1'b0;
        end
    else 
        begin
        if (!up_gmii) // RGMII Interface
            begin
            txherr <= 1'b0;
            txlerr <= 1'b0;
            //
            case (up_spd)
                MRESERVE:
                    begin
                    txhdat <= {DAT_DW{1'b0}};
                    txldat <= {DAT_DW{1'b0}};
                    txhctl <= 1'b0;
                    txlctl <= 1'b0;
                    end
                M1000:
                    begin
                    txhdat <= {4'd0, igdat [3:0]};
                    txldat <= {4'd0, igdat [7:4]};
                    txhctl <= igen;
                    txlctl <= igen ^ iger;
                    end
                default:    // M100/M10
                    begin
                    txhdat <= igval ? {4'd0, igdat [3:0]} : {4'd0, igdat [7:4]};
                    txldat <= igval ? {4'd0, igdat [3:0]} : {4'd0, igdat [7:4]};
                    txhctl <= igen;
                    txlctl <= igen ^ iger;
                    end
            endcase
            end
        else    // GMII or MII Interfaces
            begin   
            case (up_spd)
                MRESERVE:
                    begin
                    txhdat <= {DAT_DW{1'b0}};
                    txldat <= {DAT_DW{1'b0}};   
                    txhctl <= 1'b0;
                    txlctl <= 1'b0;
                    txherr <= 1'b0;
                    txlerr <= 1'b0;
                    end
                M1000:
                    begin
                    txhdat <= igdat;
                    txldat <= igdat;
                    txhctl <= igen;
                    txlctl <= igen;
                    txherr <= iger;
                    txlerr <= iger;
                    end
                default:    // M100/M10
                    begin
                    txhdat <= igval ? {4'd0, igdat [3:0]} : {4'd0, igdat [7:4]};
                    txldat <= igval ? {4'd0, igdat [3:0]} : {4'd0, igdat [7:4]};
                    txhctl <= igen;
                    txlctl <= igen;
                    txherr <= iger;
                    txlerr <= iger;
                    end
            endcase
            end
        end
    end

endmodule
