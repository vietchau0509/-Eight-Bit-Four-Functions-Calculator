//*********************************************************************
// Output Unit Module
module OU
(
    input IUAU, LoadOU, Clear,
    input [15:0] in, Result,
    output [0:6] SEV0, SEV1, SEV2, SEV3, SEV4, SEV5
);

    logic [15:0] selectR, twoComp, Out;
    logic [3:0] ones, tens, sign, hundreds, THOUSANDS;
    logic [1:0] TENTHOUSANDS ;

    // Select between input and result based on IUAU
    mux_Nbit #(16) outputSel (.A(in), .B(Result), .S(IUAU), .Y(selectR));

    // Register for holding the selected output
    NbitRegister #(16) (.D(selectR), .CLK(LoadOU), .CLR(Clear), .CE(1'b1), .Q(Out));
	 
    // Compute two's complement if output is negative
    assign twoComp = (Out[15] == 1'b1) ? -Out : Out;

    // Determine the sign for display
    assign sign = (Out[15] == 1'b1) ? 4'b1111 : 4'b0;

    // Convert binary to BCD for display
    binary2bcd decConv (.A(twoComp), .ONES(ones), .TENS(tens), .HUNDREDS(hundreds),.THOUSANDS(THOUSANDS),.TENTHOUSANDS(TENTHOUSANDS));

    // Display ones digit
    binary2seven HEX0 (.BIN(ones), .SEV(SEV0));
    // Display tens digit or sign based on condition
    binary2seven HEX1 (.BIN(tens), .SEV(SEV1));
    // Display hundreds digit or sign based on condition
    binary2seven HEX2 (.BIN(hundreds), .SEV(SEV2));
    // Display sign if needed
    binary2seven HEX3 (.BIN(THOUSANDS), .SEV(SEV3));
	 binary2seven HEX4 (.BIN(TENTHOUSANDS), .SEV(SEV4));
	 binary2seven HEX5 (.BIN(sign), .SEV(SEV5));


endmodule
