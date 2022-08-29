////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : auc_montinit.v
// Description  : .
//
// Author       : PC@DESKTOP-9FI2JF9
// Created On   : Sun May 05 12:21:38 2019
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module auc_montinit
    (

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
localparam          X_KG    = 15;
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

//comp statemachine (loop 254 to 0) 255 iterations
localparam          CSWID    = 6;
localparam          C_IDLE     = 6'b000000;
localparam          C_PREKT1   = 6'b000001; //read K
localparam          C_PREKT2   = 6'b000010; //read 0 //enable fa //wait vld
localparam          C_SWAPX2   = 6'b000011;//get swap^=k>>i & 1 //read x2
localparam          C_SWAPX3   = 6'b000100;//SWAP read x3 //enable swap //waitvld
localparam          C_SWAPZ2   = 6'b000101;//write x2 //read z2
localparam          C_SWAPZ3   = 6'b000110;//read z3 //enable swap //waitvld //write x3
localparam          C_SWAPHZ2  = 6'b000111;//write z2 //read x2
localparam          C_GETA1    = 6'b001000;//write z3 //read z2 //enable fa //waitvld
localparam          C_GETA2    = 6'b001001;//write A //read A
localparam          C_GETAA    = 6'b001010;//read A //enable mul //waitvld
localparam          C_GETB1    = 6'b001011;//write AA //read x2
localparam          C_GETB2    = 6'b001100;//read z2 //enable fa & carry(sub) //waitvld
localparam          C_GETBB    = 6'b001101;//write B //read B
localparam          C_GETBB2   = 6'b001110;//read B //enable mul //waitvld
localparam          C_GETE1    = 6'b001111;//write BB //read AA
localparam          C_GETE2    = 6'b010000;//read BB //enable fa & carry(sub) //waitvld
localparam          C_GETX21   = 6'b010001;//write E //read AA
localparam          C_GETX22   = 6'b010010;//read BB //enable mul //waitvld
localparam          C_GETZ21   = 6'b010011;//write x2 //read E
localparam          C_GETZ22   = 6'b010100;//read A24 //enable mul //waitvld
localparam          C_GETZ23   = 6'b010001;//write Z2TEMP //read AA
localparam          C_GETZ24   = 6'b010010;//read Z2TEMP //enable fa //waitvld
localparam          C_GETZ25   = 6'b010011;//write Z2TEMP //read E
localparam          C_GETZ26   = 6'b010100;//read Z2TEMP //enable mul //waitvld
localparam          C_GETC1    = 6'b010101;//write z2 //read x3
localparam          C_GETC2    = 6'b010110;//read z3  //enable fa //waitvld
localparam          C_GETD1    = 6'b010111;//write C //read x3
localparam          C_GETD2    = 6'b011000;//read z3  //enable fa & carry(sub) //waitvld
localparam          C_GETCB1   = 6'b011001;//write D //read C
localparam          C_GETCB2   = 6'b011010;//read B  //enable mul  //waitvld
localparam          C_GETDA1   = 6'b011011;//write CB //read D
localparam          C_GETDA2   = 6'b011100;//read A  //enable mul  //waitvld
localparam          C_GETX31   = 6'b011101;//write DA //read CB
localparam          C_GETX32   = 6'b011110;//read DA  //enable fa  //waitvld
localparam          C_GETX33   = 6'b011111;//write DACB  //read DACB
localparam          C_GETX34   = 6'b100000;//read DACB  //enable mul  //waitvld
localparam          C_GETDACB21= 6'b100001;//write x3  //read DA
localparam          C_GETDACB22= 6'b100010;//read CB  //enable fa & carry(sub)  //waitvld
localparam          C_GETDACB23= 6'b100011;//write DACBS  //read DACBS
localparam          C_GETDACB24= 6'b100100;//read DACBS  //enable mul  //waitvld
localparam          C_GETZ31   = 6'b100101;//write DACBS //read U255
localparam          C_GETZ32   = 6'b100110;//read DACBS  //enable mul  //waitvld //counter dec
//next if if done to idle //if not done go to C_PREKT1 again


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




////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

endmodule 
