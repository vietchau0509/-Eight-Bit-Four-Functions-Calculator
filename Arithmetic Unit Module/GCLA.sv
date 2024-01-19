module GCLA
(
	input [7:0] A_in,      // 8-bit input A
	input [7:0] B_in,      // 8-bit input B
	input C_in,            // Carry input
	
	output logic Cout, OVR, ZERO, NEG,  // Flags
	output logic [7:0] Sum  // 8-bit sum
);

	logic c4, OVR1, OVR2;  // Internal signals
	logic [7:0] B_xor_Cin; 

	// XOR B_in with C_in
	always_comb begin
		for(int i = 0; i < 8; i++) 
			B_xor_Cin[i] = B_in[i] ^ C_in;
	end

	// First 4-bit CLA
	CLA CLA0 (
		.A_in(A_in[3:0]), .B_in(B_xor_Cin[3:0]), .C_in(C_in), 
		.Cout(c4), .Sum(Sum[3:0]), .OVR(OVR1)
	);

	// Second 4-bit CLA using carry-out of first
	CLA CLA1 (
		.A_in(A_in[7:4]), .B_in(B_xor_Cin[7:4]), .C_in(c4), 
		.Cout(Cout), .Sum(Sum[7:4]), .OVR(OVR2)
	);

	// Assign flags
	assign OVR = OVR2;
	assign ZERO = (Sum == 0) ? 1'b1 : 1'b0;
	assign NEG = Sum[7];
	
endmodule
