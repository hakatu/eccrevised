////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_txtimeout.v
// Description  : .
//
// Author       : ndtu@SVT-NDTU
// Created On   : Wed Jun 25 16:53:54 2008
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_txtimeout
    (
     clk,
     rst_,
     // pause cnt
     paudis,
     //
     reqwait,
     //
     timeout,
     idtimeo,
     upact
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter   IDBIT   = 8;
parameter   WAITBIT = 256;
parameter   ENDVAL  = 8'd255;
parameter   CNTBIT  = 8;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               clk;
input               rst_;

input               paudis;

input [WAITBIT-1:0] reqwait;

output              timeout;
output [IDBIT-1:0]  idtimeo;
input               upact;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire            finish;
reg [IDBIT-1:0] idpro;
always @(posedge clk or negedge rst_)
    begin
    if(!rst_) idpro <= {IDBIT{1'b0}};
    else if(finish & upact)
        begin
        if(idpro >= ENDVAL) idpro <= {IDBIT{1'b0}};
        else idpro <= idpro + 1'b1;
        end
    end

reg [CNTBIT-1:0] cnttime;
wire        endcnttime;
assign      endcnttime = &cnttime;

wire        reqwaitbit;
assign      reqwaitbit = reqwait[idpro];

assign      finish = (!reqwaitbit) | endcnttime;

always @(posedge clk or negedge rst_)
    begin
    if(!rst_)           cnttime <= {CNTBIT{1'b0}};
    else if (~upact)    cnttime <= {CNTBIT{1'b0}};
    else if (paudis)   cnttime <= {CNTBIT{1'b0}};
    else if (finish)    cnttime <= {CNTBIT{1'b0}};
    else                cnttime <= cnttime + 1'b1;
    end

wire        timeout;
assign      timeout = endcnttime & (~paudis);

wire [IDBIT-1:0] idtimeo;
assign           idtimeo = idpro;

endmodule 
