module CLA
(
	input [3:0] A_in, B_in,
	input C_in,
	output [3:0] Sum,
	output Cout,OVR
);

	wire p0, p1, p2, p3, g0, g1, g2, g3, c0, c1, c2, c3, c4;

	// Propagate and generate signals
	assign p0 = A_in[0] ^ B_in[0];
	assign p1 = A_in[1] ^ B_in[1];
	assign p2 = A_in[2] ^ B_in[2];
	assign p3 = A_in[3] ^ B_in[3];

	assign g0 = A_in[0] & B_in[0];
	assign g1 = A_in[1] & B_in[1];
	assign g2 = A_in[2] & B_in[2];
	assign g3 = A_in[3] & B_in[3];

	// Carry computation
	assign c0 = C_in;
	assign c1 = g0 | (p0 & C_in);
	assign c2 = g1 | (p1 & g0) | (p1 & p0 & C_in);
	assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p1 & p1 & p0 & C_in);
	assign c4 = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & C_in);

	// Sum computation
	assign Sum[0] = p0 ^ c0;
	assign Sum[1] = p1 ^ c1;
	assign Sum[2] = p2 ^ c2;
	assign Sum[3] = p3 ^ c3;

	assign Cout = c4;
	assign OVR= c3 ^ c4;

endmodule
