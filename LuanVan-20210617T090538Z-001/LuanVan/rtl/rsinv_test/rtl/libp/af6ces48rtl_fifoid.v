////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : at6rtl_fifoid.v
// Description  : .
//
// Author       : nvcuong@HW-NVCUONG
// Created On   : Wed Mar 04 14:29:58 2009
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module af6ces48rtl_fifoid
    (clk,
     rst,

     // Write FIFO
     ffwr,
     ffwrid,
     fffull,

     // Read FIFO
     ffrd,
     ffrdid,
     ffnemp,
     rdlen,
     
     // Flush
     flush,

     // Connect memory
     write,
     wraddr,
     read,
     rdaddr
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter ADD = 8;
parameter LEN = 256;
parameter ADDCH = 7;   
parameter NUMCH = 128; // 128 channel

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input                   clk,
                        rst;

     // Write interface 
input                   ffwr;
input [ADDCH-1:0]       ffwrid;
output [NUMCH-1:0]      fffull;

     // Read interface 
input                   ffrd;
input [ADDCH-1:0]       ffrdid;
output [NUMCH-1:0]      ffnemp;
output [ADD:0]          rdlen;

    // Flush
input                   flush;

    // Connect memory
output                  write,
                        read;
output [ADD+ADDCH-1:0]  wraddr,
                        rdaddr;


////////////////////////////////////////////////////////////////////////////////
// Output declarations


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg                 flush1 = {1{1'b1}}; 
reg                 flush2 = {1{1'b1}}/*synthesis preserve*/; 

always @ (posedge clk)
    begin
    if (rst)
        begin
        flush1 <= 1'b1;
        flush2 <= 1'b1;
        end
    else
        begin
        flush1 <= flush;
        flush2 <= flush1;
        end
    end

reg [ADD-1:0]   wrcnt [NUMCH-1:0];
reg [ADD:0]     fifolen [NUMCH-1:0];
reg [NUMCH-1:0] fffull = {NUMCH{1'b0}},ffnemp = {NUMCH{1'b0}};
wire [ADD:0]    wrlen,rdlen,inclen,declen;
wire            read,write,notempty;

integer         i;

assign          wrlen = fifolen[ffwrid];

assign          rdlen = fifolen[ffrdid];

assign          inclen = wrlen + 1'b1;

assign          declen = rdlen - 1'b1;

assign          notempty = |declen;

assign          write = ffwr & !wrlen[ADD];

assign          read = ffrd & (|rdlen);

always @ (posedge clk)
    begin
    if (flush2)          
        begin
        for (i=0;i<NUMCH;i=i+1) 
            begin
            wrcnt[i] <= {ADD{1'b0}};
            fifolen[i] <= {(ADD+1){1'b0}};
            fffull[i] <= 1'b0;
            ffnemp[i] <= 1'b0;
            end
        end
    else 
        begin
        // Write count
        if (write)  
            begin
            wrcnt[ffwrid] <= wrcnt[ffwrid] + 1'b1;
            end
        
        // Fifo length
        case ({write,read})
            2'b10:      
                begin
                fifolen[ffwrid] <= inclen;
                fffull[ffwrid] <= inclen[ADD] | (&inclen[ADD-1:0]);
                ffnemp[ffwrid] <= 1'b1;
                end
            2'b01:      
                begin
                fifolen[ffrdid] <= declen;
                ffnemp[ffrdid] <= notempty;
                fffull[ffrdid] <= 1'b0;
                end
            2'b11:
                begin
                if (ffwrid != ffrdid)
                    begin
                    fifolen[ffwrid] <= inclen;
                    fffull[ffwrid] <= inclen[ADD] | (&inclen[ADD-1:0]);
                    ffnemp[ffwrid] <= 1'b1;
                    fifolen[ffrdid] <= declen;
                    ffnemp[ffrdid] <= notempty;
                    fffull[ffrdid] <= 1'b0;
                    end
                end
            default:;
        endcase  
        end
    end


////////////////////////////////////////////////////////////////////////////////
// Read write mem outside
wire [ADD+ADDCH-1:0]    wraddr,rdaddr;
wire [ADD-1:0]          crdcnt,cwrcnt;

assign                  crdcnt = wrcnt[ffrdid] - rdlen[ADD-1:0];
assign                  cwrcnt = wrcnt[ffwrid]; 
assign                  wraddr = {ffwrid,cwrcnt};
assign                  rdaddr = {ffrdid,crdcnt};

////////////////////////////////////////////////////////////////////////////////
// Debug
`ifdef RTL_DEBUG
wire [ADD:0]            fifolen0,fifolen1,fifolen2,fifolen3,fifolen4,fifolen5,fifolen6,fifolen7;
assign                  fifolen0 = fifolen[0];
assign                  fifolen1 = fifolen[1];
assign                  fifolen2 = fifolen[2];
assign                  fifolen3 = fifolen[3];
assign                  fifolen4 = fifolen[4];
assign                  fifolen5 = fifolen[5];
assign                  fifolen6 = fifolen[6];
assign                  fifolen7 = fifolen[7];
`endif
endmodule 
