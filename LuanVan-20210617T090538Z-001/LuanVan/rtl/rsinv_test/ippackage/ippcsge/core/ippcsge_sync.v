////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : ippcsge_sync.v
// Description  : .
//
// Author       : nlgiang@HW-NLGIANG
// Created On   : Wed Aug 18 16:57:42 2004
// History (Date, Changed By) changed and modified by lqson
// Mon Oct 12 11:30:23 2009, ndtu@HW-NDTU, modified state machine and signal datvld
////////////////////////////////////////////////////////////////////////////////

module ippcsge_sync
    (
     clk,//@rxclk
     rst_,
     
     pact,
     
     di,
     sync,

     rx_eveno,
     code_err,
     disp_err,
     do,


     sync_state,
     comdet,
     baok,
     comma,

     tbio,
     algo
     );

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input         clk, rst_;
input         pact;

input [9:0]   di;
output        sync;
output        rx_eveno, code_err, disp_err;
output [8:0]  do;    // [8]- k, [7:0]- do
output [3:0]  sync_state;
output        comdet;
output        baok;
output        comma;
output [9:0]  tbio;
output [9:0]  algo;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [9:0]    tbio;
wire [9:0]    algo;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter   LOSYNC      = 4'd0;
parameter   COM_DET1    = 4'd1;
parameter   ACQ_SYNC1   = 4'd2;
parameter   COM_DET2    = 4'd3;
parameter   ACQ_SYNC2   = 4'd4;
parameter   COM_DET3    = 4'd5;
parameter   SYNC_ACQ1   = 4'd6;
parameter   SYNC_ACQ2   = 4'd7;
parameter   SYNC_ACQ3   = 4'd8;
parameter   SYNC_ACQ4   = 4'd9;
parameter   SYNC_ACQ2A  = 4'd10;
parameter   SYNC_ACQ3A  = 4'd11;
parameter   SYNC_ACQ4A  = 4'd12;

parameter   COMMA       = 7'b0011111;//0x1F
parameter   COMMA_      = 7'b1100000;//0x60

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

reg [9:0]   aldata;
wire [8:0]  do;
wire        rx_eveno;

wire [8:0]  ldo;
wire        disp, code_err, disp_err;
wire        code_erro, disp_erro;
wire        cgbad;

reg         rx_even;
wire        lrx_even;
wire [9:0]  di;

//swapbus for alignment: VERY IMPORTANT
wire [9:0]  datin;
fflopx #(10) pltbi (clk, rst_, di, {datin[0],
                                    datin[1],
                                    datin[2],
                                    datin[3],
                                    datin[4],
                                    datin[5],
                                    datin[6],
                                    datin[7],
                                    datin[8],
                                    datin[9]}
                                    );

reg [18:0]  sdata;
always @ (posedge clk or negedge rst_)
    begin
    if (~rst_)  sdata <= 19'h0;
    else        sdata <= {sdata[8:0],datin};
    end

wire [9:0]  ba;

assign      ba[0] = (sdata[9:3]  == COMMA)|(sdata[9:3]  == COMMA_);
assign      ba[1] = (sdata[10:4] == COMMA)|(sdata[10:4] == COMMA_);
assign      ba[2] = (sdata[11:5] == COMMA)|(sdata[11:5] == COMMA_);
assign      ba[3] = (sdata[12:6] == COMMA)|(sdata[12:6] == COMMA_);
assign      ba[4] = (sdata[13:7] == COMMA)|(sdata[13:7] == COMMA_);
assign      ba[5] = (sdata[14:8] == COMMA)|(sdata[14:8] == COMMA_);
assign      ba[6] = (sdata[15:9] == COMMA)|(sdata[15:9] == COMMA_);
assign      ba[7] = (sdata[16:10]== COMMA)|(sdata[16:10]== COMMA_);
assign      ba[8] = (sdata[17:11]== COMMA)|(sdata[17:11]== COMMA_);
assign      ba[9] = (sdata[18:12]== COMMA)|(sdata[18:12]== COMMA_);

wire        comdet;
wire [9:0]  ba_latch;

wire [9:0]  ba1;
fflopx #(10) plba (clk, rst_, ba, ba1);
assign      comdet = |ba;

reg [3:0]   sync_state;//stage 3
wire        baena;//update a new word alignment 
assign      baena = comdet& (sync_state==LOSYNC);///???

fflopxe #(10) latch_ba (clk, rst_, baena, ba, ba_latch);

wire        alignok;  
wire        baok;     

assign      alignok = (ba1==ba_latch) & (sync_state != LOSYNC);
fflopx #(1)  pl_baok (clk, rst_,alignok,baok);

//mux data to correct word alignment
always @ (posedge clk or negedge rst_)
    if(~rst_)
        aldata <= 10'd0;
    else
        begin
        if(pact)
        case (ba_latch)
            10'b00_0000_0001: aldata <= sdata[9:0];//stage 1
            10'b00_0000_0010: aldata <= sdata[10:1];
            10'b00_0000_0100: aldata <= sdata[11:2];
            10'b00_0000_1000: aldata <= sdata[12:3];
            10'b00_0001_0000: aldata <= sdata[13:4];
            10'b00_0010_0000: aldata <= sdata[14:5];
            10'b00_0100_0000: aldata <= sdata[15:6];
            10'b00_1000_0000: aldata <= sdata[16:7];
            10'b01_0000_0000: aldata <= sdata[17:8];
            default         : aldata <= sdata[18:9];
        endcase
        else    aldata <= 10'd0;
        end

wire [6:0]  aldata2;//stage 2 
fflopx #(7) pipeline_aldata1 (clk, rst_, aldata[9:3], aldata2);

wire        comma;//stage 2 
assign      comma   = (aldata2[6:0]==COMMA)|(aldata2[6:0]==COMMA_);

//code_err : stage 2
assign      cgbad   = code_erro|(comma&lrx_even);

//Alias for the following terms: !((rx_code-group?/INVALID/) + (rx_code-group=/COMMA/
//*rx_even=TRUE)) * PMA_UNITDATA.indication

wire        cggood;
assign      cggood  = ~cgbad;

wire        comvld,datvld;

assign      comvld  =   (~lrx_even)&comma;
//assign      datvld  =   (~code_erro)&(~comma)&lrx_even;//  PUDI(![/COMMA/]*#[/INVALID/])
assign      datvld  = (~code_err) & (~comma) & (~ldo [8]);


reg         sync_status;//stage 4 
reg [1:0]   good_cgs;


/* 
// Off  

always @ (posedge clk or negedge rst_)  
    begin
    if (~rst_) 
        begin
        sync_state  <= LOSYNC;
        end
    else
        if(pact)
        case (sync_state)
            LOSYNC:
                begin
                if (comma)  sync_state <= COM_DET1;
                else        sync_state <= LOSYNC; 
                end
            
            COM_DET1:
                begin
                if (datvld) sync_state <= ACQ_SYNC1;
                else        sync_state <= LOSYNC;
                end
            
            ACQ_SYNC1:
                begin
                if (comvld)     sync_state <= COM_DET2;
                else if(datvld) sync_state <= ACQ_SYNC1;////???stuck
                else            sync_state <= LOSYNC;
                end
            
            COM_DET2:
                begin
                if (datvld) sync_state <= ACQ_SYNC2;
                else        sync_state <= LOSYNC;
                end
            
            ACQ_SYNC2:
                begin
                if (comvld)      sync_state <= COM_DET3;
                else if(datvld)  sync_state <= ACQ_SYNC2;////???stuck
                else             sync_state <= LOSYNC;
                end
            
            COM_DET3:
                begin
                if (datvld) sync_state <= SYNC_ACQ1;
                else        sync_state <= LOSYNC;
                end
            
            SYNC_ACQ1:
                begin
                if (cgbad)      sync_state <= SYNC_ACQ2;
                else            sync_state <= SYNC_ACQ1;
                end
            
            SYNC_ACQ2:
                begin
                if (cgbad)      sync_state <= SYNC_ACQ3;
                else            sync_state <= SYNC_ACQ2A;
                end

            SYNC_ACQ3:
                begin
                
                if (cgbad)      sync_state <= SYNC_ACQ4;
                else            sync_state <= SYNC_ACQ3A;
                end
            
            SYNC_ACQ4:
                begin
                if (cgbad)      
                    begin 
                    sync_state <= LOSYNC; 
                    end
                else                  sync_state <= SYNC_ACQ4A;
                end
            
            SYNC_ACQ2A:
                begin
                if (cgbad)                    sync_state <= SYNC_ACQ3;
                else if (good_cgs==2'd3)      sync_state <= SYNC_ACQ1;///good_cgs = 3: 0_1_2_3 -> sets of 4 good codegroup
                else                          sync_state <= SYNC_ACQ2A;
                end
            
            SYNC_ACQ3A:
                begin
                if (cgbad)                    sync_state <= SYNC_ACQ4;
                else if (good_cgs==2'd3)      sync_state <= SYNC_ACQ2;///good_cgs = 3: 0_1_2_3 -> sets of 4 good codegroup
                else                          sync_state <= SYNC_ACQ3A;
                end
            
            SYNC_ACQ4A:
                begin
                if (cgbad)
                    begin 
                    sync_state <= LOSYNC; 
                    end
                else if (good_cgs==2'd3)      sync_state <= SYNC_ACQ3;///good_cgs = 3: 0_1_2_3 ->sets of 4 good codegroup
                else                          sync_state <= SYNC_ACQ4A;
                end
            
            default:            
                begin 
                sync_state <= LOSYNC; 
                end
        endcase
        else    sync_state <= LOSYNC; 
    end

always @ (posedge clk or negedge rst_)
    if (~rst_)
        begin
        sync_status <= 1'b0;
        rx_even     <= 1'b0;
        good_cgs    <= 2'b0;
        
        end
    else       
        case (sync_state)
            LOSYNC:
                begin
                sync_status <= 1'b0;
                rx_even     <= ~rx_even;
                end
            
            COM_DET1:
                begin
                rx_even   <= 1'b1;
                end

            ACQ_SYNC1:
                begin
                rx_even <= ~rx_even;
                end
            COM_DET2:
                begin
                rx_even <= 1'b1;
                end
            ACQ_SYNC2:
                begin
                rx_even <= ~rx_even;
                end
            COM_DET3:
                begin
                rx_even <= 1'b1;
                end 
            SYNC_ACQ1:
                begin
                sync_status <= 1'b1;
                rx_even     <= ~rx_even;
                end         
            SYNC_ACQ2:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= 2'b0; 
                end 
            SYNC_ACQ3:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= 2'b0;
                end
            SYNC_ACQ4:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= 2'b0;
                end
            SYNC_ACQ2A:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= good_cgs + 1'b1;
                end
            SYNC_ACQ3A:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= good_cgs + 1'b1;
                end
            SYNC_ACQ4A:
                begin
                rx_even   <= ~rx_even;
                good_cgs  <= good_cgs + 1'b1;
                end
        endcase
*/
 

// D.Tu edit Mon Oct 12 10:35:23 2009

wire        goodok;
assign      goodok = (good_cgs == 2'd3);

always @ (posedge clk or negedge rst_)  
    begin
    if (~rst_) 
        begin
        sync_state  <= LOSYNC;
        sync_status <= 1'b0;
        rx_even     <= 1'b0;
        good_cgs    <= 2'b0;
        end
    else if (~pact)
        begin
        sync_state  <= LOSYNC;
        sync_status <= 1'b0;
        rx_even     <= 1'b0;
        good_cgs    <= 2'b0;
        end
    else
        begin
        case (sync_state)
            LOSYNC:
                begin
                sync_state  <= comma    ? COM_DET1      : LOSYNC;
                sync_status <= 1'b0;
                rx_even     <= ~rx_even;
                end
            
            COM_DET1:
                begin
                sync_state  <= datvld   ? ACQ_SYNC1 : LOSYNC;
                rx_even     <= 1'b1;
                end
            
            ACQ_SYNC1:
                begin
                sync_state  <= comvld   ? COM_DET2  :
                               cgbad    ? LOSYNC    : ACQ_SYNC1;
                
                rx_even     <= ~rx_even;
                end
            
            COM_DET2:
                begin
                sync_state  <= datvld   ? ACQ_SYNC2 : LOSYNC;
                rx_even     <= 1'b1;
                end
            
            ACQ_SYNC2:
                begin
                sync_state  <= comvld   ? COM_DET3  :
                               cgbad    ? LOSYNC    : ACQ_SYNC2;
                
                rx_even     <= ~rx_even;
                end
            
            COM_DET3:
                begin
                sync_state  <= datvld   ? SYNC_ACQ1 : LOSYNC;
                
                rx_even     <= 1'b1;
                end
            
            SYNC_ACQ1:
                begin
                sync_state  <= cgbad    ? SYNC_ACQ2 : SYNC_ACQ1;
                
                rx_even     <= ~rx_even;
                sync_status <= 1'b1;
                end
            
            SYNC_ACQ2:
                begin
                sync_state  <= cgbad    ? SYNC_ACQ3 : SYNC_ACQ2A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= 2'b0;
                end

            SYNC_ACQ3:
                begin
                sync_state  <= cgbad    ? SYNC_ACQ4 : SYNC_ACQ3A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= 2'b0;
                end
            
            SYNC_ACQ4:
                begin
                sync_state  <= cgbad    ? LOSYNC : SYNC_ACQ4A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= 2'b0;

                end
            
            SYNC_ACQ2A:
                begin
                sync_state  <= cgbad    ? SYNC_ACQ3 :
                               goodok   ? SYNC_ACQ1 : SYNC_ACQ2A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= good_cgs + 1'b1;
                end
            
            SYNC_ACQ3A:
                begin
                sync_state  <= cgbad    ? SYNC_ACQ4 :
                               goodok   ? SYNC_ACQ2 : SYNC_ACQ3A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= good_cgs + 1'b1;
                end
            
            SYNC_ACQ4A:
                begin
                sync_state  <= cgbad    ? LOSYNC    :
                               goodok   ? SYNC_ACQ3 : SYNC_ACQ4A;
                
                rx_even     <= ~rx_even;
                good_cgs    <= good_cgs + 1'b1;

                end

            default:            
                begin 
                sync_state  <= LOSYNC; 
                end
        endcase
        end
    end


wire [8:0] ldo_1;
wire       code_err1,disp_err1;

fflopx #(1) pline_sync (clk, rst_, sync_status,sync);
fflopx #(18) pline_ldo (clk, rst_, {ldo, ldo_1},{ldo_1, do}); 
fflopx #(2)  pline_lrxeven  (clk, rst_, {rx_even, lrx_even},{lrx_even, rx_eveno});
fflopx #(2)  pline_code_err (clk, rst_, {code_erro, code_err1},{code_err1, code_err});
fflopx #(2)  pline_disp_err (clk, rst_, {disp_erro, disp_err1},{disp_err1, disp_err});

//8b10 decoder
//after alignment, invert data bus again for 8b10b decoding.

wire [9:0] iv_aldata;
assign     iv_aldata = {aldata[0],
                        aldata[1],
                        aldata[2],
                        aldata[3],
                        aldata[4],
                        aldata[5],
                        aldata[6],
                        aldata[7],
                        aldata[8],
                        aldata[9]};

ippcsge_decode_8b10b dec_inst
    (.clk(clk), 
     .rst_(rst_), 
     .datain(iv_aldata),  //datain _ stage1 
     .dispin(disp), 
     .dataout(ldo),       //stage2
     .dispout(disp), 
     .code_err(code_erro),//stage2 
     .disp_err(disp_erro)
     );

wire [9:0] algo2,algo3;//algo : stage4
fflopx #(30) pline_algo (clk, rst_, {aldata, algo2, algo3},{algo2, algo3,algo});

wire [9:0] tbio1,tbio2,tbio3;//tbio : stage4
fflopx #(40) pline_tbio (clk, rst_, {sdata[9:0], tbio1, tbio2, tbio3},
                                    {tbio1,      tbio2, tbio3, tbio});

endmodule 
