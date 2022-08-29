module atmux1 (a, b, sela, o);

input   a,
        b,
        sela;

output  o;

// K-micro mux instant

wire    o;
assign  o = sela ? a : b;

endmodule