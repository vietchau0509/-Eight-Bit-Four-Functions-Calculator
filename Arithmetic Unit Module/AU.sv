// Arithmetic Unit Module ^^
module AU (
    input Ahigh_in, Alow_in, LoadB, LoadResult, Clock, ClearEntry, Clear, Start,
    input [1:0] Operations,
    input [15:0] keyOut,
    output OVR,
    output [15:0] Result, Remainder_Result
);

    logic [15:0] Reg_Mult, Reg_Sel, Mult_Op,Remainder_sel,A,D0_val,D1_val;
    logic [7:0] AHigh, ALow, B, Add_Op, Sub_Op, Reg_div, Div_Op,Remainder_De,Remainder_out;
    logic Add_Op_OVR, Div_Op_OVR, Done, Halt;
	 
	 
	 
		always @(*) begin
			 case (Operations[0])
				  0: OVR = Add_Op_OVR;
				  default: OVR = Sub_Op;
			 endcase
		end  
		
		always @(*) begin
			 if (AHigh[7] == 1) begin
				  D0_val = {8'b11111111, Add_Op};
				  D1_val = {8'b11111111, Sub_Op};
			 end else begin
				  D0_val = Add_Op;
				  D1_val = Sub_Op;
			 end
		end

		
    NbitRegister #(8) Reg_Ahigh (
        .D(keyOut[15:8]), 
        .CLK(Ahigh_in), 
        .CLR(ClearEntry), 
        .CE(1'b1), 
        .Q(AHigh)
    );

    NbitRegister #(8) Reg_ALow (
        .D(keyOut[7:0]), 
        .CLK(Alow_in), 
        .CLR(ClearEntry), 
        .CE(1'b1), 
        .Q(ALow)
    );

    NbitRegister #(8) Reg_B (
        .D(keyOut[7:0]), 
        .CLK(LoadB), 
        .CLR(ClearEntry), 
        .CE(1'b1), 
        .Q(B)
    );
	 
	     NbitRegister #(16) Reg_Multiplier (
        .D(Mult_Op), 
        .CLK(Halt), 
        .CLR(Clear), 
        .CE(1'b1), 
        .Q(Reg_Mult)
    );
	 
	 
    NbitRegister #(8) Reg_Div0 (
        .D(Div_Op), 
        .CLK(Done), 
        .CLR(Clear), 
        .CE(1'b1), 
        .Q(Reg_div)
    );
	 
   NbitRegister #(8) Remainder0 (
        .D(Remainder_De), 
        .CLK(Done), 
        .CLR(Clear), 
        .CE(1'b1), 
        .Q(Remainder_out)
    );
	 
	 
    NbitRegister #(16) Reg_R (
        .D(Reg_Sel), 
        .CLK(LoadResult), 
        .CLR(Clear), 
        .CE(1'b1), 
        .Q(Result)
    );
	 
	     NbitRegister #(16) Reg_remainder (
        .D(Remainder_sel), 
        .CLK(LoadResult), 
        .CLR(Clear), 
        .CE(1'b1), 
        .Q(Remainder_Result)
    );	 
	 
    GCLA GCLA_Add (
        .C_in(1'b0), 
        .A_in(ALow), 
        .B_in(B), 
        .OVR(Add_Op_OVR), 
        .Sum(Add_Op)
    );

    GCLA GCLA_Sub (
        .C_in(1'b1), 
        .A_in(ALow), 
        .B_in(B), 
        .OVR(Div_Op_OVR), 
        .Sum(Sub_Op)
    );


    Multiplier_8x8 Multp (
        .Clock(Clock), 
        .START(Start), 
        .Multiplicand(ALow), 
        .Multiplier(B), 
        .Product(Mult_Op), 
        .Halt(Halt)
    );



    signed_divider Div (
		  .Remainder(Remainder_De),
        .CLOCK(Clock), 
        .START(Start), 
        .Dividend({AHigh, ALow}), 
        .Divisor(B), 
        .Quotient(Div_Op), 
        .DONE(Done)
    );



		four2one #(16) MuxSel (
			 .A(Operations[0]), 
			 .B(Operations[1]),
			 .D0(D0_val), 
			 .D1(D1_val),
			 .D2(Reg_Mult), 
			 .D3(Reg_div), 
			 .Y(Reg_Sel)
		);
	 four2one #(16) Remainder_Sel (
			.A(Operations[0]), 
        .B(Operations[1]),
        .D0(0), 
        .D1(0),
        .D2(0), 
        .D3(Remainder_out), 
        .Y(Remainder_sel)
    );



endmodule
