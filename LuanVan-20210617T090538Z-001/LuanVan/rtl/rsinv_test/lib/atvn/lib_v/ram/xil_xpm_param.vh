localparam	sDEPA= 1<<ADRA;
localparam  iDEPA= (sDEPA > DEPA) ? DEPA : sDEPA;
localparam  SIZE= iDEPA*WIDA;
/*
initial
    begin
    $display("%m, ADRA %d, WIDA %d, DEPA %d, iSIZE %d, SIZE %d",
             ADRA,WIDA,DEPA,iSIZE,SIZE);
    end
*/
