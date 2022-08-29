////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : auc_mmulinit.v
// Description  : .
//
// Author       : PC@DESKTOP-9FI2JF9
// Created On   : Sun May 05 12:21:38 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module auc_mmulinit
    (
     clk,
     rst,

     // Input
     init_en,//controller
     
     // Output
     init_done,//done

     //alu
     //from ALU
     init_auvld,
     init_audat,
     //to ALU
     init_opcode,
     init_auen,
     init_carry,
     
     // RAM control
     init_ra,
     init_wa,
     init_we,
     init_wd
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WID   = 256;
parameter           CURWID = 256;
parameter           AWID  = 5;
parameter           OPWID = 4;

localparam          ZERO   = 0;
localparam          A24VL  = 256'd121665;
localparam          PS2VL = 256'd57896044618658097711785492504343953926634992332820282019728792003956564819947;

//Block RAM address table

localparam          X_G     = 0;//X2
localparam          Y_G     = 1;//Z2
localparam          X_3G    = 2;//X3
localparam          Y_3G    = 3;//Z3
localparam          Z_3G    = 3;
localparam          X_5G    = 5;
localparam          Y_5G    = 6;
localparam          Z_5G    = 7;
localparam          X_7G    = 8;
localparam          Y_7G    = 9;
localparam          Z_7G    = 10;

localparam          K_NUM   = 11;
localparam          K_INV   = 12;
localparam          R_NUM   = 13;
localparam          S_NUM   = 14;
localparam          X_KG    = 15;
localparam          HASH    = 16;
localparam          PKEY    = 17;
localparam          ZRRAM   = 18;
localparam          ONERAM  = 19;

localparam          TEMP0   = 20;
localparam          TEMP1   = 21;
localparam          TEMP2   = 22;
localparam          TEMP3   = 23;
localparam          TEMP4   = 24;
localparam          TEMP5   = 25;
localparam          TEMP6   = 26;   
localparam          TEMP7   = 27;
localparam          TEMP8   = 28;//A24

localparam          S_RP    = 29;
localparam          S_RPH   = 30;
localparam          BLNK    = 31;
//INITTABLE
localparam          X2    = 7;//X2
localparam          Z2    = 8;//Z2
localparam          X3    = 9;//X3
localparam          Z3    = 10;//Z3

localparam          PS2 = 29;//p-2 address for last pow
localparam          ACCIDENT   = 30;//Accident write debug
localparam          A24   = 31;//A24
//VALUE INIT
localparam          X2VL   = 1;
localparam          Z2VL   = 0;
localparam          X3VL   = X_G;
localparam          Z3VL   = 1;

//init statemachine
localparam          ISWID    = 4;
localparam          I_IDLE   = 4'd0;
localparam          I_INITX2 = 4'd1;//INIT X2
localparam          I_INITZ2 = 4'd2;//INIT Z2
localparam          I_INITX3 = 4'd3;//INIT X3
localparam          I_INITZ3 = 4'd4;//INIT Z3
localparam          I_INITA24= 4'd5;//INIT A24
localparam          I_INITPS2= 4'd6;//INIT A24
localparam          I_INITK1 = 4'd7;//read K 
localparam          I_INITK2 = 4'd8;//read 0 // enable fa //waitvld
localparam          I_INITK3 = 4'd9;//change //write K_dec

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input     clk;
input     rst;
     
// Input
input     init_en;//controller //done

// Output
output          init_done;//done //done

//ALU
//to ALU
output [OPWID-1:0] init_opcode;
output             init_auen;
output             init_carry;//for sub
//from ALU
input [WID-1:0]    init_audat;
input              init_auvld;

// RAM control
output [AWID-1:0] init_ra;
output [AWID-1:0] init_wa;
output            init_we;
output [WID-1:0]  init_wd;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
//INIT FSM
//FSM
reg               init_done;

reg [ISWID-1:0] init_state;

wire      initisidle; //declared for the scope of perfection

assign    initisidle = init_state == I_IDLE;

wire      initisinitx2; 

assign    initisinitx2 = init_state == I_INITX2;

wire      initisinitz2; 

assign    initisinitz2 = init_state == I_INITZ2;

wire      initisinitx3; 

assign    initisinitx3 = init_state == I_INITX3;

wire      initisinitz3;

assign    initisinitz3 = init_state == I_INITZ3;

wire      initisinita24;

assign    initisinita24 = init_state == I_INITA24;

wire      initisinitps2;

assign    initisinitps2 = init_state == I_INITPS2;

wire      initisinitk1;

assign    initisinitk1 = init_state == I_INITK1;

wire      initisinitk2;

assign    initisinitk2 = init_state == I_INITK2;

wire      initisinitk2vld;

assign    initisinitk2vld = initisinitk2 & init_auvld;

wire      initisinitk3;

assign    initisinitk3 = init_state == I_INITK3;

always@(posedge clk)
    begin
    if(rst)
        begin
        init_state <= I_IDLE;
        init_done <= 1'b0;//declared
        end
    else
        begin
        if(init_en & initisidle)
            begin
            init_state <= I_INITX2;
            init_done <= 1'b0;
            end
        else if(initisinitx2)
            begin
            init_state <= I_INITZ2;
            init_done <= 1'b0;
            end        
        else if(initisinitz2)
            begin
            init_state <= I_INITX3;
            init_done <= 1'b0;
            end
        else if(initisinitx3)
            begin
            init_state <= I_INITZ3;
            init_done <= 1'b0;
            end
        else if(initisinitz3)
            begin
            init_state <= I_INITA24;
            init_done <= 1'b0;
            end
        else if(initisinita24)
            begin
            init_state <= I_INITPS2;
            init_done <= 1'b0;
            end
        else if(initisinitps2)
            begin
            init_state <= I_INITK1;
            init_done <= 1'b0;
            end
        else if(initisinitk1)
            begin
            init_state <= I_INITK2;
            init_done <= 1'b0;
            end
        else if(initisinitk2vld)
            begin
            init_state <= I_INITK3;
            init_done <= 1'b0;
            end
        else if(initisinitk3)
            begin
            init_state <= I_IDLE;
            init_done <= 1'b1;//done
            end
        else
            begin
            init_state <= init_state;
            init_done <= 1'b0;
            end
        end
    end

//K_NUM decode
reg [WID-1:0] kdecode;

always@(posedge clk)
    begin
    if(rst)
        begin
        kdecode <= 256'd0;
        end
    else
        begin
        if(initisinitk2vld)
            begin
            kdecode <= {1'b0,1'b1,init_audat[253:3],3'b0};
            end
        end
    end
//RAM access
reg [WID-1:0] init_wd;

always@(posedge clk)
    begin
    init_wd <= initisinitx2? X2VL:
               initisinitz2? Z2VL:
               initisinitx3? X3VL:
               initisinitz3? Z3VL:
               initisinita24? A24VL:
               initisinitps2? PS2VL:
               initisinitk3? kdecode:
               ZRRAM; //mark accidental write //write this address
    end

reg [AWID-1:0] init_wa;

always@(posedge clk)
    begin
    init_wa <= initisinitx2? X2:
               initisinitz2? Z2:
               initisinitx3? X3:
               initisinitz3? Z3:
               initisinita24? A24:
               initisinitps2? PS2:
               initisinitk3? K_NUM:
               ACCIDENT; //mark accidental write
    end

reg init_we;

always@(posedge clk)
    begin
    init_we <= initisinitx2
               | initisinitz2
               | initisinitx3
               | initisinitz3
               | initisinita24 
               | initisinitps2
               | initisinitk3;
    end

reg [AWID-1:0] init_ra;

always@(posedge clk)
    begin
    init_ra <= initisinitk1? K_NUM:
               initisinitk2? ZRRAM:
               ZRRAM; 
    end

//ALU interface
assign init_carry = 1'b0;
assign init_opcode = 4'b0100; //P //X255 //FA

reg    init_auen;

always@(posedge clk)
    begin
    if(rst)
        begin
        init_auen <= 1'b0;
        end
    else
        begin
        if(initisinitk1)
            begin
            init_auen <= 1'b1;
            end
        else
            begin
            init_auen <= 1'b0;
            end
        end
    end

endmodule 
