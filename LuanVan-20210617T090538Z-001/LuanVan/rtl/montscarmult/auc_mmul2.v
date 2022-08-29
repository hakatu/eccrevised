////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : auc_mmul.v
// Description  : Montgomery multiplication
// Python code https://github.com/hakatu/rfc7748/blob/master/python/curves.py
// basically k*xP, k from ram
// Author       : hungnt@HW-NTHUNG
// Created On   : Wed April 03 13:35:57 2019
// History (Date, Changed By)
// 33% done, so much logic :((
////////////////////////////////////////////////////////////////////////////////

module auc_mmul
    (
     clk,
     rst,
     
     // Input
     mmul_en,//controller

     //from ALU
     mmul_auvld,
     mmul_audat,
     
     // Output
     mmul_done,//done

     //to ALU
     mmul_opcode,
     mmul_auen,
     mmul_carry,
     
     // RAM control
     mmul_radd,
     mmul_rdat,//for swap
     mmul_wadd,
     mmul_wen,
     mmul_wdat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           WID   = 256;
parameter           CURWID = 255;//curve width is only 255
parameter           AWID  = 5;
parameter           OPWID = 4;

localparam          INIT   = 0;
localparam          X25519 = 9;
localparam          A24    = 256'd121665;
localparam          EXP_K  = 256'd19; //2^255 mod 2^255-19
localparam          EXP_2K = 256'd361;//2^(255*2) mod 2^255-19

//Block RAM address table

localparam          X_G     = 0;
localparam          Y_G     = 1;
localparam          X_3G    = 2;
localparam          Y_3G    = 3;
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
localparam          X_KG    = 15;   //KKG KG same
localparam          HASH    = 16;
localparam          PKEY    = 17;
localparam          ZRRAM   = 18;   // NEED FIX
localparam          ONERAM  = 19;   // NEED FIX //May be init when reset

localparam          TEMP0   = 20;
localparam          TEMP1   = 21;
localparam          TEMP2   = 22;
localparam          TEMP3   = 23;
localparam          TEMP4   = 24;
localparam          TEMP5   = 25;
localparam          TEMP6   = 26;   
localparam          TEMP7   = 27;
localparam          TEMP8   = 28;
//
//TEMP CHANGE NAME FOR USAGE in comp
localparam          X_2   = 20;
localparam          Z_2   = 21;
localparam          X_3   = 22;
localparam          Z_3   = 23;
localparam          A     = 24;
localparam          DA    = 24;
localparam          B     = 25;
localparam          CB    = 25;
localparam          AA    = 26;
localparam          C     = 26;
localparam          DACBS = 26; //DA-CB
localparam          BB    = 27;
localparam          Z2TEMP= 27;
localparam          D     = 27;
localparam          DACB  = 27; //DA+CB
localparam          E     = 28;
localparam          DACB2 = 28;
localparam          U255  = 30;//blank
localparam          A24   = 31;//blank
//

//TEMP CHANGE NAME FOR USAGE in EXPO final
localparam          X_2   = 20;
localparam          Z_2   = 21;
localparam          X_3   = 22;
localparam          Z_3   = 23;
localparam          E     = 24;
localparam          TY    = 25;
localparam          POWZ  = 26;
//

localparam          S_RP    = 29;
localparam          S_RPH   = 30;
localparam          BLNK    = 31;
//


//VALUE INITlocalparam          X2VL   = 1;
localparam          Z2VL   = 0;
localparam          X3VL   = X25519;
localparam          Z3VL   = 1;

//main statemachine 
localparam          IDLE    = 2'b00;
localparam          INIT    = 2'b01;//init first xz
localparam          COMP    = 2'b10;//compute for
localparam          FINAL   = 2'b11;//final rslt calculation

//init statemachine
localparam          ISWID    = 3;
localparam          I_IDLE   = 3'b000;
localparam          I_INITX2 = 3'b001;//INIT X2
localparam          I_INITZ2 = 3'b010;//INIT Z2
localparam          I_INITX3 = 3'b011;//INIT X3
localparam          I_INITZ3 = 3'b100;//INIT Z3
localparam          I_INITA24= 3'b101;//INIT A24
localparam          I_INITU  = 3'b110;//INIT U255



//final statemachine
localparam          FSWID       = 5;
localparam          F_IDLE      = 5'b00000;
localparam          F_SWAPZ2    = 5'b00001;//SWAP read z2
localparam          F_SWAPZ3    = 5'b00010;//SWAP read z3 //enable swap //waitvld
localparam          F_SWAPX2    = 5'b00011;//SWAP read x2 //write z2
localparam          F_SWAPX3    = 5'b00100;//SWAP read x3 //enable swap //wait
localparam          F_SWAPL     = 5'b00101;//write x2
localparam          F_FINALEK   = 5'b00110;//write E = EXP_K
localparam          F_MPTY1     = 5'b00111;//read z_2 //para EXP_2K //enable mul //wait vld
localparam          F_MPTY2     = 5'b01000;//write TY //enable counter
//loop i 0 -> 254
localparam          F_EETY      = 5'b01001;//read E
//if binary p_2(i) = 1
localparam          F_EETY2     = 5'b01010;//read TY //enable mult // wait vld
//normal
localparam          F_TYTY1     = 5'b01011;//write TY //read TY
localparam          F_TYTY2     = 5'b01100;//read TY //enable mult //wait vld
//loop
//i finish end loop
localparam          F_POWZ1     = 5'b01101;//read 1
localparam          F_POWZ2     = 5'b01110;//read E //enable mult //wait vld
localparam          F_RSLT1     = 5'b01111;//write POWZ //read x_2
localparam          F_RSLT2     = 5'b10000;//read POWZ //enable mult //wait vld
//back to idle, calculation done

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input     clk;
input     rst;
     
// Input
input     mmul_en;//controller

//from ALU
input [WID-1:0] mmul_audat;
input           mmul_auvld;

// Output
output          mmul_done;//done

//to ALU
output [OPWID-1:0] mmul_opcode;
output             mmul_auen;
output             mmul_carry;//for sub

// RAM control
output [AWID-1:0]  mmul_radd;
output [AWID-1:0]  mmul_wadd;
output             mmul_wen;
output [WID-1:0]   mmul_wdat;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

//Main FSM
//minor state done flag
reg                init_done;
reg                comp_done;
reg                final_done;

reg [1:0]          main;

wire      mainisidle;

assign    mainisidle = main == IDLE;

wire      mainenidle;

assign    mainenidle = mainisidle & mmul_en;//mmul_en not main_en

reg       main_en;//to enable module fsm

wire      mainisinit;

assign    mainisinit = main == INIT;

wire      maineninit;

assign    maineninit = mainisinit & main_en;

wire      mainiscomp;

assign    mainiscomp = main == COMP;

wire      mainencomp;

assign    mainencomp = mainiscomp & main_en;

wire      mainisfinal;

assign    mainisfinal = main == FINAL;

wire      mainenfinal;

assign    mainenfinal = mainisfinal & main_en;

always@(posedge clk)
    begin
    if(rst)
        begin
        main <= IDLE;
        main_en <= 1'b0;
        end
    else
        begin
        if(mainenidle)
            begin
            main <= INIT;
            main_en <= 1'b1;
            end
        else if(maindoneinit)//lack
            begin
            main <= COMP;
            main_en <= 1'b1;
            end
        else if(maindonecomp)//lack
            begin
            main <= FINAL;
            main_en <= 1'b1;
            end
        else if(maindonefinal)//lack
            begin
            main <= IDLE;
            main_en <= 1'b0;
            end
        else
            begin
            main <= main;
            main_en <= 1'b0;
            end
        end
    end



//FINAL FSM
reg [FSWID-1:0] final_state;

wire      finalisidle; 

assign    finalisidle = final == F_IDLE;

wire      finalisidlevld; 

assign    finalisidlevld = finalisidle & mmul_auvld;

always@(posedge clk)
    begin
    if(rst)
        begin
        final_state <= F_IDLE;
        final_done <= 1'b0;//declared
        end
    else
        begin
        if(mainenfinal & finalisidle)
            begin
            final_state <= F_SWAPZ2;
            final_done <= 1'b0;
            end
        else if(finalisswapz2)
            begin
            final_state <= F_SWAPZ3;
            final_done <= 1'b0;
            end
        else if(finalisswapz3vld)
            begin
            final_state <= F_SWAPX2;
            final_done <= 1'b0;
            end
        else if(finalisswapx2)
            begin
            final_state <= F_SWAPX3;
            final_done <= 1'b0;
            end
        else if(finalisswapx3vld)
            begin
            final_state <= F_SWAPL;
            final_done <= 1'b0;
            end
        else if(finalisswapl)
            begin
            final_state <= F_FINALEK;
            final_done <= 1'b0;
            end
        else if(finalisfinalek)
            begin
            final_state <= F_MPTY1;
            final_done <= 1'b0;
            end
        else if(finalismpty1)
            begin
            final_state <= F_MPTY2;
            final_done <= 1'b0;
            end
        else if(finalismpty2)
            begin
            final_state <= F_EETY;
            final_done <= 1'b0;
            end
        else if(finaliseety)
            begin
            final_state <= F_EETY2;
            final_done <= 1'b0;
            end
        else if(finaliseety2)
            begin
            final_state <= F_TYTY1;
            final_done <= 1'b0;
            end
        else if(finalistyty1)
            begin
            final_state <= F_TYTY2;
            final_done <= 1'b0;
            end
        else if(finalistyty2)
            begin
            final_state <= F_POWZ1;
            final_done <= 1'b0;
            end
        else if(finalispowz1)
            begin
            final_state <= F_POWZ2;
            final_done <= 1'b0;
            end
        else if(finalispowz2)
            begin
            final_state <= F_RSLT1;
            final_done <= 1'b0;
            end
        else if(finalisrslt1)
            begin
            final_state <= F_RSLT2;
            final_done <= 1'b0;
            end
        else if(finalisrslt2)
            begin
            final_state <= F_IDLE;
            final_done <= 1'b0;
            end
        else
            begin
            final_state <= final_state;
            final_done <= 1'b0;
            end
        end
    end
endmodule 