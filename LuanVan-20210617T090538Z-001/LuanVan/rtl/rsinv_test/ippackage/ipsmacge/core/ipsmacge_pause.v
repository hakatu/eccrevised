////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ipsmacge_pause.v
// Description  : .
//
// Author       :  Nguyen Duy Tu <ndtu.atvn@gmail.com>
// Created On   : Wed Jan 14 14:57:42 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ipsmacge_pause
    (
     txrst_,
     txclk,
     // from Rx Terminate
     ma_ipauvld,
     ma_ipauqua,
     // to & from Txframing 
     pau_ival,
     
     pau_oen,
     pau_off,
     pau_trandis,
     // Gen Pause
     iquanta,
     pause_en,
     
     upact,
     uppaudis
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

////////////////////////////////////////////////////////////////////////////////
// ports declarations
input               txrst_;
input               txclk;
     // from Rx Terminate

input               ma_ipauvld;
input [15:0]        ma_ipauqua;

     // to & from Txframing
input               pau_ival;

output              pau_oen;
output              pau_off;
output              pau_trandis;
     // Gen Pause
input [15:0]        iquanta;
input               pause_en;

input               upact;
input               uppaudis;

////////////////////////////////////////////////////////////////////////////////
// signal declarations0
wire                pau_oen;
reg [5:0]           cntbyte;
wire                pau_start;
wire                pau_stop;
wire                pause_en1;
wire                pause_en2;
reg                 pau_off;
////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

// Rx Quanta
wire   ma_ipauvld1, 
       ma_ipauvld2;

fflopx #(2) ffquaivld (txclk, txrst_, {ma_ipauvld, ma_ipauvld1},
                       {ma_ipauvld1, ma_ipauvld2});

wire   rcvquanvld;
assign rcvquanvld = ma_ipauvld1 & (~ma_ipauvld2);

// Cnt quantum
always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)       cntbyte <= 6'b0;
    else if (~upact)   cntbyte <= 6'b0;
    else if (uppaudis) cntbyte <= 6'b0;
    else if (pau_ival) cntbyte <= cntbyte + 1'b1;
    end

wire        qtumena;
assign      qtumena = (&cntbyte) & pau_ival;


// Pau Terminate
reg [15:0]  rcvquata;

assign      pau_trandis = |rcvquata;

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        rcvquata <= 16'b0;
    else if (~upact)    rcvquata <= 16'b0;
    else if (uppaudis)  rcvquata <= 16'b0;
    else if (rcvquanvld)rcvquata <= ma_ipauqua;
    else if (qtumena)   rcvquata <= pau_trandis ? (rcvquata - 1'b1) : 16'b0;
    end

// Pau Generator

fflopx #(2) ffpppauen (txclk, txrst_, {pause_en, pause_en1}, 
                       {pause_en1, pause_en2});

assign              pau_start = (~pause_en2) &   pause_en1;
assign              pau_stop  =   pause_en2  & (~pause_en1);

reg [15:0]  genquata;
wire        gensample;

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        genquata <= 16'b0;
    else if (~upact)    genquata <= 16'b0;
    else if (~pause_en2)genquata <= 16'b0;
    else if (qtumena)   genquata <= gensample ? 16'b0 : genquata + 1'b1;
    end

assign      gensample  = qtumena & (genquata >= iquanta) & (|iquanta);

assign      pau_oen = (~uppaudis) & (gensample | pau_start | pau_stop);

always @(posedge txclk or negedge txrst_)
    begin
    if (!txrst_)        pau_off <= 1'b0;
    else if (!upact)    pau_off <= 1'b0;
    else if (pau_start) pau_off <= 1'b0;
    else if (pau_stop)  pau_off <= 1'b1;
    end

endmodule
