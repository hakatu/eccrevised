`define INPUTSIZE 257		//set the input size n
`define GROUPSIZE 8		//set the group size = 1, 2, 4 or 8

module brent_kung_adder257(A,B,S);

	input	[`INPUTSIZE - 1:0]	A;
	input	[`INPUTSIZE - 1:0]	B;
	output	[`INPUTSIZE:0]		S;
	
	wire	[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]	r_temp;
	wire	[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]	r;
	wire	[`INPUTSIZE / `GROUPSIZE:0]		cin;
	wire	[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]	q;
	
	assign cin[0] = 1'b0;
	
	generate
	genvar i;
	for(i = 0;i < `INPUTSIZE / `GROUPSIZE;i = i + 1) begin: parallel_FA_CLA_prefix
		group_q_generation #(.Groupsize(`GROUPSIZE))
		f(.a(A[`GROUPSIZE * (i + 1) - 1:`GROUPSIZE * i]),
		  .b(B[`GROUPSIZE * (i + 1) - 1:`GROUPSIZE * i]),
		  .cin(cin[i]),
		  .s(S[`GROUPSIZE * (i + 1) - 1:`GROUPSIZE * i]),
		  .qg(q[i * 2 + 1:i * 2]));
	end

	parallel_prefix_tree_first_half #(.Treesize(`INPUTSIZE / `GROUPSIZE))
	t1(.q(q[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]),
	   .r(r_temp[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]));
	parallel_prefix_tree_second_half #(.Treesize(`INPUTSIZE / `GROUPSIZE))
	t2(.q(r_temp[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]),
	   .r(r[`INPUTSIZE / `GROUPSIZE * 2 - 1:0]));
	
	for(i = 0;i < `INPUTSIZE / `GROUPSIZE;i = i + 1) begin: cin_generation
		cin_generation_logic f(.r(r[2 * i + 1:2 * i]),
							   .c0(1'b0),
							   .cin(cin[i + 1]));
	end
	
	assign S[`INPUTSIZE] = cin[`INPUTSIZE / `GROUPSIZE];
	
	endgenerate
	
endmodule

module parallel_prefix_tree_first_half #(parameter Treesize = `INPUTSIZE / `GROUPSIZE)(q,r);

	input	[Treesize * 2 - 1:0]	q;
	output	[Treesize * 2 - 1:0]	r;
	
	generate
	genvar i;
	if(Treesize == 2) begin: trival_case
		assign r[1:0] = q[1:0];
		prefix_logic f(.ql(q[1:0]),
					   .qh(q[3:2]),
					   .r(r[3:2]));
	end
	else begin: recursive_case
		wire	[Treesize * 2 - 1:0]	r_temp;
		parallel_prefix_tree_first_half #(.Treesize(Treesize / 2))
		recursion_lsbh(.q(q[Treesize - 1:0]),
					   .r(r_temp[Treesize - 1:0]));
		parallel_prefix_tree_first_half #(.Treesize(Treesize / 2))
		recursion_msbh(.q(q[Treesize * 2 - 1:Treesize]),
					   .r(r_temp[Treesize * 2 - 1:Treesize]));
		for(i = 0;i < Treesize * 2;i = i + 2) begin: parallel_stitch_up
			if(i != Treesize * 2 - 2) begin: parallel_stitch_up_pass
				assign r[i + 1:i] = r_temp[i + 1:i];
			end
			else begin: parallel_stitch_up_produce
				prefix_logic f(.ql(r_temp[Treesize - 1:Treesize - 2]),
							   .qh(r_temp[Treesize * 2 - 1:Treesize * 2 - 2]),
							   .r(r[Treesize * 2 - 1:Treesize * 2 - 2]));
			end
		end
	end
	endgenerate
	
endmodule

module parallel_prefix_tree_second_half #(parameter Treesize = `INPUTSIZE / `GROUPSIZE)(q,r);

	input	[Treesize * 2 - 1:0]	q;
	output	[Treesize * 2 - 1:0]	r;
	
	wire	[Treesize * 2 * ($clog2(Treesize) - 1) - 1:0]	r_temp;
	
	assign r_temp[Treesize * 2 - 1:0] = q[Treesize * 2 - 1:0];
	
	generate
	genvar i, j;
	for(i = 0;i < $clog2(Treesize) - 2;i = i + 1) begin: second_half_level
		assign r_temp[Treesize * 2 * (i + 1) + ((Treesize / (2 ** i)) - 1 - 2 ** ($clog2(Treesize / 4) - i)) * 2 - 1:Treesize * 2 * (i + 1)] = r_temp[Treesize * 2 * i + ((Treesize / (2 ** i)) - 1 - 2 ** ($clog2(Treesize / 4) - i)) * 2 - 1:Treesize * 2 * i];
		for(j = (Treesize / (2 ** i)) - 1 - 2 ** ($clog2(Treesize / 4) - i);j < Treesize;j = j + 2 ** ($clog2(Treesize / 2) - i)) begin: second_half_level_logic
			prefix_logic f(.ql(r_temp[Treesize * 2 * i + (j - 2 ** ($clog2(Treesize / 4) - i)) * 2 + 1:Treesize * 2 * i + (j - 2 ** ($clog2(Treesize / 4) - i)) * 2]),
						   .qh(r_temp[Treesize * 2 * i + j * 2 + 1:Treesize * 2 * i + j * 2]),
						   .r(r_temp[Treesize * 2 * (i + 1) + j * 2 + 1:Treesize * 2 * (i + 1) + j * 2]));
			if(j != Treesize - 1 - 2 ** ($clog2(Treesize / 4) - i)) begin: second_half_level_direct_connect
				assign r_temp[Treesize * 2 * (i + 1) + (j + 2 ** ($clog2(Treesize / 2) - i)) * 2 - 1:Treesize * 2 * (i + 1) + j * 2 + 2] = r_temp[Treesize * 2 * i + (j + 2 ** ($clog2(Treesize / 2) - i)) * 2 - 1:Treesize * 2 * i + j * 2 + 2];
			end
		end
		assign r_temp[Treesize * 2 * (i + 2) - 1:Treesize * 2 * (i + 2) - (2 ** ($clog2(Treesize / 4) - i)) * 2] = r_temp[Treesize * 2 * (i + 1) - 1:Treesize * 2 * (i + 1) - (2 ** ($clog2(Treesize / 4) - i)) * 2];
	end
	assign r[1:0] = r_temp[Treesize * 2 * ($clog2(Treesize) - 2) + 1:Treesize * 2 * ($clog2(Treesize) - 2)];
	for(i = 1;i < Treesize;i = i + 2) begin: final_r_odd
		assign r[i * 2 + 1:i * 2] = r_temp[Treesize * 2 * ($clog2(Treesize) - 2) + i * 2 + 1:Treesize * 2 * ($clog2(Treesize) - 2) + i * 2];
	end
	for(i = 2;i < Treesize;i = i + 2) begin: final_r_even
		prefix_logic f(.ql(r_temp[Treesize * 2 * ($clog2(Treesize) - 2) + i * 2 - 1:Treesize * 2 * ($clog2(Treesize) - 2) + i * 2 - 2]),
					   .qh(r_temp[Treesize * 2 * ($clog2(Treesize) - 2) + i * 2 + 1:Treesize * 2 * ($clog2(Treesize) - 2) + i * 2]),
					   .r(r[i * 2 + 1:i * 2]));
	end
	endgenerate
	
endmodule

module group_q_generation #(parameter Groupsize = `GROUPSIZE)(a,b,cin,s,qg);

	input	[Groupsize - 1:0]	a;
	input	[Groupsize - 1:0]	b;
	input				cin;
	output	[Groupsize - 1:0]	s;
	output	[1:0]			qg;
	
	wire	[2 * Groupsize - 1:0]	q;
	wire	[Groupsize - 1:0]	c;
	
	assign c[0] = cin;
	
	generate
	genvar i;
	for(i = 0;i < Groupsize;i = i + 1) begin: parallel_FA_CLA_prefix
		FA_CLA_prefix f(.a(a[i]),
						.b(b[i]),
						.cin(c[i]),
						.s(s[i]),
						.q(q[i * 2 + 1:i * 2]));
		if(i != Groupsize - 1)begin: special_case
			assign c[i + 1] = q[i * 2 + 1] | q[i * 2] & c[i];
		end
	end
	
	//group q generation based on the Groupsize
	if(Groupsize == 1) begin: case_gs1
		assign qg[1] = q[1];
		assign qg[0] = q[0];
	end
	else if(Groupsize == 2) begin: case_gs2
		assign qg[1] = q[3] | (q[1] & q[2]);
		assign qg[0] = q[2] & q[0];
	end
	else if(Groupsize == 4) begin: case_gs4
		assign qg[1] = q[7] | (q[5] & q[6]) | (q[3] & q[6] & q[4]) | (q[1] & q[6] & q[4] & q[2]);
		assign qg[0] = q[6] & q[4] & q[2] & q[0];
	end
	else if(Groupsize == 8) begin: case_gs8
		assign qg[1] = q[15] | (q[13] & q[14]) | (q[11] & q[14] & q[12]) | (q[9] & q[14] & q[12] & q[10]) | (q[7] & q[14] & q[12] & q[10] & q[8]) | (q[5] & q[14] & q[12] & q[10] & q[8] & q[6]) | (q[3] & q[14] & q[12] & q[10] & q[8] & q[6] & q[4]) | (q[1] & q[14] & q[12] & q[10] & q[8] & q[6] & q[4] & q[2]);
		assign qg[0] = q[14] & q[12] & q[10] & q[8] & q[6] & q[4] & q[2] & q[0];
	end
	endgenerate
	
endmodule
//Cin_generation_logic
module cin_generation_logic(r,c0,cin);

	input	[1:0]	r;
	input		c0;
	output		cin;
	
	assign cin = (r[0] & c0) | r[1];
	
endmodule

//basic_logic
module prefix_logic(ql,qh,r);
	
	input	[1:0]	ql;
	input	[1:0]	qh;
	output	[1:0]	r;
	
	assign r[0] = qh[0] & ql[0];
	assign r[1] = (qh[0] & ql[1]) | qh[1];
	
endmodule

//FA_cell_CLA
module FA_CLA_prefix(a,b,cin,s,q);

	input 		a;
	input 		b;
	input 		cin;
	output 		s;
	output	[1:0]	q;
	
	assign q[0] = a ^ b;
	assign s = q[0] ^ cin;
	assign q[1] = a & b;

endmodule