// Divider Module
module signed_divider
(
	input CLOCK, START,					
	input [15:0] Dividend, 				
	input [7:0] Divisor,					
							
	output [7:0] Quotient, Remainder,
	output DONE	
);
	logic [15:0] signed_Dividend;										
	logic [8:0] alu_out, Out_MUX, In_MUX, R_out;					
	logic [7:0] Q_out, D_out, signed_SDivisor;					
	logic Rload, Qload, Dload, Rshift, Qshift, AddSub, Qbit;	
   logic [15:0] inverted_Dividend;
   logic [7:0] inverted_Divisor;
    // Inverting the bits if MSB is 1 and adding 1 for twos complement
    always_comb begin
        inverted_Dividend = ~Dividend;
        inverted_Divisor = ~Divisor;
        signed_Dividend = Dividend[15] ? (inverted_Dividend + 1) : Dividend;
        signed_SDivisor = Divisor[7] ? (inverted_Divisor + 1) : Divisor;
    end
    // Assigning Remainder and preparing MUX input
    always_comb begin
        Remainder = R_out[7:0];
        In_MUX = {1'b0, signed_Dividend[15:8]};
    end
    // Computing Quotient
    always_comb begin
        if (Dividend[15] != Divisor[7]) 
            Quotient = ~Q_out + 1; // Inverting Q_out and adding 1 if MSB of Dividend and Divisor are different
        else 
            Quotient = Q_out;
    end
	mux_Nbit #(9) Mux1 (.A(alu_out), .B(In_MUX), .S(Qload), .Y(Out_MUX));
	shiftreg 	#(9) Rreg (.D(Out_MUX), .Q(R_out), .CLK(CLOCK), .LD(Rload), .SH(Rshift), .SerIn(Q_out[7]));				// Register R
	shiftreg 	#(8) Qreg (.D(signed_Dividend[7:0]), .Q(Q_out), .CLK(CLOCK), .LD(Qload), .SH(Qshift), .SerIn(Qbit));	// Register Q
	shiftreg 	#(8) Dreg (.D(signed_SDivisor), .Q(D_out), .CLK(CLOCK), .LD(Dload), .SH(1'b0), .SerIn(1'b0));			// Register D
	alu 			#(8)	AdSb (.A(R_out), .B(D_out), .Sel(AddSub), .Result(alu_out));
	dcontrol DivCtrl (.Clock(CLOCK), .Start(START), .Rsign(alu_out[8]), .AddSub(AddSub), .Dload(Dload), .Rload(Rload), .Qload(Qload), .Rshift(Rshift), 
	.Qshift(Qshift), .DONE(DONE), .Qbit(Qbit));

endmodule