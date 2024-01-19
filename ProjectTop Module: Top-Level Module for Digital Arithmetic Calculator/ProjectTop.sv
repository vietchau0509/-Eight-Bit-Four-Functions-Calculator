
module ProjectTop
(
    input Clock, Enter, ClearEntry, ClearAll,
    input [3:0] rows,
    output OVR_flow, Ahigh, Alow, B, OU, R, au,
    output [1:0] Operations,
    output [3:0] cols,Cat,
    output [0:6] SEV0, SEV1, SEV2, SEV3,SEV4,SEV5,SEG
);

    logic Ahigh_in, Alow_in, LoadB, LoadResult, loadOU, IU_AU, Start, Add, Sub, Mult, Div;
    logic [1:0] Op;
    logic [15:0] Key_Input, Result,Remainder;

	 
	 always @(*) begin
    Operations = Op;
    Ahigh = Ahigh_in;
    Alow = Alow_in;
    B = LoadB;
	 
    R = LoadResult;
    au = IU_AU;
	 
    OU = loadOU;

	 end
	 
	 
    
    IU IU0 (
        .Clock(Clock), .Clear(ClearEntry), .rows(rows),
        .Add(Add), .Sub(Sub), .Mult(Mult), .Div(Div), .Start(Start),
        .cols(cols), .Out(Key_Input)
    );

    
    CU CU0 (
        .Clock(Clock), .ClearEntry(ClearEntry), .ClearAll(ClearAll), .Ahigh_in(Ahigh_in), .Alow_in(Alow_in),
        .Add(Add), .Sub(Sub), .Mult(Mult), .Div(Div), .Start(Start),.Enter(Enter),.LoadB(LoadB), .LoadResult(LoadResult), 
		  .LoadOU(loadOU), .IU_AU(IU_AU), .Op(Op)
    );



    
    AU AU0 (
        .Clock(Clock), .ClearEntry(ClearEntry), .Clear(ClearAll),.Ahigh_in(Ahigh_in), 
		  .Alow_in(Alow_in), .LoadB(LoadB), .LoadResult(LoadResult),.Start(Start),.Operations(Op), 
		  .keyOut(Key_Input), .OVR(OVR_flow), .Result(Result), .Remainder_Result(Remainder)
    );

    
    OU OU0 (
        .IU_AU(IU_AU), .LoadOU(loadOU), .Clear(ClearAll), .in(Key_Input), .Result(Result),.Remainder(Remainder),.SEG(SEG),
		  .cat(Cat),.SEV0(SEV0), .SEV1(SEV1), .SEV2(SEV2), .SEV3(SEV3), .SEV4(SEV4), .SEV5(SEV5), .Clock(Clock)
		  
    );

endmodule
