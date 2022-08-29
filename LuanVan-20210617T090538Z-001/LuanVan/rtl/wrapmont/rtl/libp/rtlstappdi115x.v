////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : rtlstappdi115x.v
// Description  : .
//
// Author       : cuongnv@HW-NVCUONG
// Created On   : Thu Jul 30 12:48:25 2015
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module rtlstappdi115x
    (
     clk,
     rst,

      // Engine Read/write interface
     eng_re,
     eng_ra,
     eng_rdd,
     eng_we,
     eng_wa,
     eng_wrd,
     eng_wsame,  // = eng_we  & (eng_ra5 == eng_we);
     
     // CPU interface
     upen,     
     upa,
     upws,
     uprs,
     updi,
     updo,
     uprdy,
     active,

     // Connect memory 3 clock, eg: iarray113x.v
     memwe,
     memre,
     memwa,
     memwrd,
     memra,
     memrdd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter ADDRBIT  = 5;
parameter WIDTH    = 32;
parameter MEM5CLK  = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input                   clk;
input                   rst;

input                   eng_re;
input  [ADDRBIT-1:0]    eng_ra;
output [WIDTH-1:0]      eng_rdd;
input                   eng_we;
input  [ADDRBIT-1:0]    eng_wa;
input  [WIDTH-1:0]      eng_wrd;
input                   eng_wsame;
                        
input                   upen,
                        upws,
                        uprs,
                        active;
input  [ADDRBIT-1:0]    upa;
input  [WIDTH-1:0]      updi;
output [WIDTH-1:0]      updo;
output                  uprdy;

output                  memwe;
output                  memre;
output [ADDRBIT-1:0]    memwa;
output [WIDTH-1:0]      memwrd;
output [ADDRBIT-1:0]    memra;
input  [WIDTH-1:0]      memrdd;

////////////////////////////////////////////////////////////////////////////////
//
wire    engwr, engrd;
assign  engwr = eng_we & active;
assign  engrd = eng_re & active;

reg     upwr_lat = 1'b0,uprd_lat = 1'b0;
wire    upwr,uprd;
wire    upwr_ok, uprd_ok;

assign  upwr = upws & upen;
assign  uprd = uprs & upen;

//assign  upwr_ok = upwr_lat & ((!engwr)|(eng_wa == upa));
//assign  uprd_ok = uprd_lat & ((!engrd)|(eng_ra == upa));
assign  upwr_ok = upwr_lat & (!engwr);
assign  uprd_ok = uprd_lat & (!engrd);

always @ (posedge clk)
    begin
    if(rst)
        begin
        upwr_lat <= 1'b0;
        uprd_lat <= 1'b0;
        end
    else if(!upen)
        begin
        upwr_lat <= 1'b0;
        uprd_lat <= 1'b0;
        end
    else
        begin
        if(upwr_ok)   upwr_lat <= 1'b0; 
        else if(upwr) upwr_lat <= 1'b1;
        
        if(uprd_ok)   uprd_lat <= 1'b0; 
        else if(uprd) uprd_lat <= 1'b1;
        end
    end

// Memory write process
wire                memramwe;
wire [ADDRBIT-1:0]  memramwa;
wire [WIDTH-1:0]    memramwrd;
assign              memramwe  = engwr | upwr_lat;
assign              memramwa  = engwr ? eng_wa : upa;
assign              memramwrd = engwr ? eng_wrd : updi;

// Memory read process
wire                memramre;
wire [ADDRBIT-1:0]  memramra;

//-------------------------------------------------------
wire [ADDRBIT-1:0]  memramra1;
wire [ADDRBIT-1:0]  memramra2;
wire [ADDRBIT-1:0]  memramra3;
wire [ADDRBIT-1:0]  memramra4;
fflopx #(ADDRBIT) memrapl1 (clk,rst,memramra,memramra1);
fflopx #(ADDRBIT) memrapl2 (clk,rst,memramra1,memramra2);
fflopx #(ADDRBIT) memrapl3 (clk,rst,memramra2,memramra3);
fflopx #(ADDRBIT) memrapl4 (clk,rst,memramra3,memramra4);

wire                wrconflict4;
assign              wrconflict4 = memramwe  & (memramra4 == memramwa);

wire                wrconflict3;
assign              wrconflict3 = memramwe  & (memramra3 == memramwa);

wire                wrconflict2;
assign              wrconflict2 = memramwe  & (memramra2 == memramwa);

wire                wrconflict1;
assign              wrconflict1 = memramwe  & (memramra1 == memramwa);

wire                wrconflict;
assign              wrconflict = memramwe  & (memramra == memramwa);

reg                 samestage1 = {1{1'b0}};
reg                 samestage2 = {1{1'b0}};
reg                 samestage3 = {1{1'b0}};
reg                 samestage4 = {1{1'b0}};
reg                 samestage5 = {1{1'b0}};
always @ (posedge clk)
    begin
    if (rst)
        begin
        samestage1 <= 1'b0;
        samestage2 <= 1'b0;
        samestage3 <= 1'b0;
        samestage4 <= 1'b0;
        samestage5 <= 1'b0;
        end
    else
        begin
        samestage5 <= wrconflict4 | samestage4;
        samestage4 <= wrconflict3 | samestage3;
        samestage3 <= wrconflict2 | samestage2;       
        samestage2 <= wrconflict1 | samestage1;
        samestage1 <= wrconflict;
        end
    end

reg [WIDTH-1:0]     memramwrd1 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd2 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd3 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd4 = {WIDTH{1'b0}};
reg [WIDTH-1:0]     memramwrd5 = {WIDTH{1'b0}};
always @ (posedge clk)
    begin
    memramwrd5 <= wrconflict4 ? memramwrd : samestage4 ? memramwrd4 : {WIDTH{1'b0}};     
    memramwrd4 <= wrconflict3 ? memramwrd : memramwrd3;     
    memramwrd3 <= wrconflict2 ? memramwrd : memramwrd2;     
    memramwrd2 <= wrconflict1 ? memramwrd : memramwrd1;     
    memramwrd1 <= memramwrd;
    end

wire                cpu_sameadd,cpu_same;
assign              cpu_same = cpu_sameadd & upwr_ok; 
fflopx #(1) icpu_sameadd (clk,rst,(upa == memramra4),cpu_sameadd);

wire                samestage;
assign              samestage = eng_wsame | cpu_same;


wire [WIDTH-1:0]    engrddsame  = {WIDTH{samestage}} & memramwrd;

wire                engsame5win = !samestage;
wire [WIDTH-1:0]    engrddsame5 = {WIDTH{engsame5win}} & memramwrd5;

wire [WIDTH-1:0]    memrdd5;
wire                engrddwin = !(samestage | samestage5);
wire [WIDTH-1:0]    engrdd5 = {WIDTH{engrddwin}} & memrdd5;

wire [WIDTH-1:0]    eng_rdd;
assign              eng_rdd = engrddsame | engrddsame5 | engrdd5;

//--------------------------------------
assign              memramre = (engrd | uprd_lat) & (~wrconflict);
assign              memramra = engrd ? eng_ra : upa;

//----------------------------------------------------
wire                upaccess_ok;
assign              upaccess_ok = uprd_ok | upwr_ok;
wire                upaccess_ok1;
fflopx #(1)         upaccess_ok1pl (clk,rst,upaccess_ok,upaccess_ok1);
wire                upaccess_ok2;
fflopx #(1)         upaccess_ok2pl (clk,rst,upaccess_ok1,upaccess_ok2);
wire                upaccess_ok3;
fflopx #(1)         upaccess_ok3pl (clk,rst,upaccess_ok2,upaccess_ok3);
wire                upaccess_ok4;
fflopx #(1)         upaccess_ok4pl (clk,rst,upaccess_ok3,upaccess_ok4);
wire                upaccess_ok5;
fflopx #(1)         upaccess_ok5pl (clk,rst,upaccess_ok4,upaccess_ok5);

fflopx #(1) iuprdy (clk,rst,upaccess_ok5,uprdy);
fflopx #(WIDTH) iupdo (clk,rst,upen ? eng_rdd : {WIDTH{1'b0}},updo);

//----------------------------------------------------
// Pipeline output and input and connect RAM 113 to cause RAM115
generate
    begin
    if (MEM5CLK == 1)
        begin: inst_5clk
        assign  {memwe,memre,memwa,memra,memwrd,memrdd5} = {memramwe,memramre,memramwa,memramra,memramwrd,memrdd};     
        end
    else
        begin: inst_3clk
        reg                     memwep = 1'b0;
        reg                     memrep = 1'b0;
        reg [ADDRBIT-1:0]       memwap = {ADDRBIT{1'b0}};
        reg [WIDTH-1:0]         memwrdp = {WIDTH{1'b0}};
        reg [ADDRBIT-1:0]       memrap = {ADDRBIT{1'b0}};
        reg [WIDTH-1:0]         memrddp = {WIDTH{1'b0}};

        assign  {memwe,memre,memwa,memra,memwrd,memrdd5} = {memwep,memrep,memwap,memrap,memwrdp,memrddp};
     
        always @ (posedge clk)
            begin
            {memwep,memrep,memwap,memrap,memwrdp,memrddp} <= {memramwe,memramre,memramwa,memramra,memramwrd,memrdd};  
            end
        end
    end
endgenerate

endmodule 
