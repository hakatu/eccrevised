////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : iarray2223_2r2w_spx.v
// Description  : .
//
// Author       : lqcuong@HW-LQCUONG
// Created On   : Mon Feb 05 16:41:47 2007
// History (Date, Changed By)
//  Thu Jul 28, ndtu, add parameter MAXDEPTH for better resource usage
//
////////////////////////////////////////////////////////////////////////////////

module iarray2223_2r2w_spx
    (
     testdi,
     clk2x,
     rst2x_,
     
     rst1x_,
     clk1x,
     wa1x1,
     we1x1,
     di1x1,
     re1x1,
     ra1x1,
     do1x1,         //2-clock delay
     wa1x2,
     we1x2,
     di1x2,
     re1x2,
     ra1x2,
     do1x2,         //3-clock delay
     test,
     mask
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter ADDRBIT   = 11;
parameter DEPTH     = 2048;
parameter WIDTH     = 8;
parameter TYPE      = "AUTO";        //This parameter is for synthesis only (Do not remove)
parameter MAXDEPTH = 0;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

input               testdi;
input               clk2x;
input               rst2x_;

input               rst1x_;
input               clk1x;

input [ADDRBIT-1:0] wa1x1;
input               we1x1;
input [WIDTH-1:0]   di1x1;
input               re1x1;
input [ADDRBIT-1:0] ra1x1;
output [WIDTH-1:0]  do1x1;

input [ADDRBIT-1:0] wa1x2;
input               we1x2;
input [WIDTH-1:0]   di1x2;
input               re1x2;
input [ADDRBIT-1:0] ra1x2;
output [WIDTH-1:0]  do1x2;  

input               test;
input               mask;

////////////////////////////////////////////////////////////////////////////////
// Output declarations

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

//                      _____       _____       _____       _____       _____       _____       _____       _____       _____
// clk2x          _____|     |_____|     |_____|     |_____|     |_____|     |_____|     |_____|     |_____|     |_____|     |
//                            ___________             _____|_____             _____|_____             ___________             __    
// clk1x          ___________|           |___________|           |___________|           |___________|           |___________|
//                            ___________             _____|_____            |_____|_____             ___________
// phase_one_1x   ___________|           |___________|           |___________|           |___________|           |___________|  
//                _____             ___________            |___________      |     |___________      |       ___________
// phase1x             |___________|           |___________|           |___________|           |___________|           |_______ 
//                            _________________|_____      |                       |           |     |
//Read_bus_1x_1              |_______________________|     |                 |     |           
//                                             |           |                       |           |     |  
//                            _________________|_____      |                       |                 
//Read_bus_1x_2              |_______________________|     |                 |     |           |     |  
//                            _________________|_____      |                 |     |                   
//Write_bus_1x_1             |_______________________|     |                       |           |     |  
//                            _________________|_____      |                 |     |                   
//Write_bus_1x_2             |_______________________|     |                       |           |     |
//                                             |___________|___________      |     |                 
//di_2x                                        |_______________________|                       |     |  
//                                              ___________ ___________      |     |                 
//spwe2x                                       |    we1    |   we2     |                       |     |
//                                              ___________|___________      |     |                   
//ra_2x                                        |_______________________|                       |     |
//                                              ___________|___________      |     |                   
//re_2x                                        |                       |                       |     |
//                                              ___________|___________      |                       
//spre2x                                       |     re1   |     re2   |                       |     |
//                                              ___________ ___________      |                        
//spra2x                                       |_____ra1___|_____ra2___|                       |     |
//                                                          ___________ ___________              
//predo2x                                                  |____do1 ___|____do2____|           |     |
//                                                                      _____|_________________   
//predo2x1_r                                                           |___________do1_________|  
//                                                                                  _______________________   
//predo2x2_r                                                                       |___________do2_________|
//                                                                           |_______________________|
//do1x1                                                                      |_______________________|
//                                                                                                   |______________________
//do1x2                                                                                              |______________________|



wire                phase_one_1xr;

phasedet_ck1x   phasedet_ck1xi
    (
     .rst1x_    (rst1x_),
     .rst2x_    (rst2x_),
     .clk2x     (clk2x),
     .clk1x     (clk1x),

     .scanmode  (test),

     .phaseout  (phase_one_1xr)
     );

// clk1x signal is muxed with test pin in scanmode
//wire    phase1x;
//phasemux ckphase (.ckin(clk1x), .testdi(testdi), .testmode(test), .ophase(phase1x));

//Pipe line input data with clk2x
reg [ADDRBIT-1:0]   ra2x2;
reg                 re2x2;

always @(posedge clk2x or negedge rst2x_)
    begin
    if(!rst2x_)
        begin
        ra2x2   <= {ADDRBIT{1'b0}};
        re2x2   <= 1'b0;
        end
    else if(phase_one_1xr)
        begin
        ra2x2   <= ra1x2;
        re2x2   <= re1x2;
        end
    end

reg [ADDRBIT-1:0]   wa2x2;
reg                 we2x2;
reg [WIDTH-1:0]     di2x2;

always @(posedge clk2x or negedge rst2x_)
    begin
    if(!rst2x_)
        begin
        wa2x2   <= {ADDRBIT{1'b0}};
        di2x2   <= {WIDTH{1'b0}};
        we2x2   <= 1'b0;
        end
    else if(phase_one_1xr)
        begin
        wa2x2   <= wa1x2;
        di2x2   <= di1x2;
        we2x2   <= we1x2;
        end
    end

//Generate signals ramrwp
reg                 re2x;
reg                 we2x;
reg [ADDRBIT-1:0]   ra2x;
reg [ADDRBIT-1:0]   wa2x;
reg [WIDTH-1:0]     di2x;

always @ (posedge clk2x or negedge rst2x_)
    begin
    if(!rst2x_)
        begin
        re2x    <= 1'b1;
        ra2x    <= {ADDRBIT{1'b0}};
        we2x    <= 1'b1;
        wa2x    <= {ADDRBIT{1'b0}};
        di2x    <= {WIDTH{1'b0}};
        end
    else if(phase_one_1xr)
        begin
        re2x    <= test | (!(re1x1 | mask));
        ra2x    <= ra1x1;
        we2x    <= test | (!we1x1);
        wa2x    <= wa1x1;
        di2x    <= di1x1;
        end
    else 
        begin
        re2x    <= test | (!(re2x2 | mask));
        ra2x    <= ra2x2;
        we2x    <= test | (!we2x2);
        wa2x    <= wa2x2;
        di2x    <= di2x2;
        end
    end

//Output data
wire [WIDTH-1:0]    predo2x;
reg [WIDTH-1:0]     predo2x2_r;
reg [WIDTH-1:0]     predo2x1_r;
always @(posedge clk2x or negedge rst2x_)
    begin
    if(!rst2x_)
        begin
        predo2x1_r  <= {WIDTH{1'b0}};
        predo2x2_r  <= {WIDTH{1'b0}};
        end
    else if(phase_one_1xr)
        begin
        predo2x1_r  <= predo2x;
        end
    else
        begin
        predo2x2_r  <= predo2x;
        end
    end

reg [WIDTH-1:0]     do1x1;
reg [WIDTH-1:0]     do1x2;
always @(posedge clk1x or negedge rst1x_)
    begin
    if(!rst1x_)
        begin
        do1x1   <= {WIDTH{1'b0}};
        do1x2   <= {WIDTH{1'b0}};
        end
    else
        begin
        do1x1   <= predo2x1_r;
        do1x2   <= predo2x2_r;
        end
    end


////////////////////////////////////////////////////////////////////////////////
//read write port ram, dual clock instantiation
iramrwpx #(ADDRBIT,DEPTH,WIDTH) ram (clk2x,wa2x,!we2x,di2x,clk2x,ra2x,!re2x,predo2x,test,mask);

/*
iramrwpx #(ADDRBIT,DEPTH,WIDTH) mem
    (
     .wrclk (clk2x),
     .wa    (wa2x),
     .we    (we2x),
     .di    (di2x),
     .rdclk (clk2x),
     .ra    (ra2x),
     .do    (predo2x),
     .re    (re2x)
     );
*/

endmodule 
