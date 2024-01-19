//^^
module CU (
    input Clock,Enter, Add, Sub, Mult, Div, Start, ClearEntry, ClearAll, 
    output logic Ahigh_in, Alow_in, LoadB, LoadResult, LoadOU, IU_AU,
    output logic [1:0] Op
);

    logic enterOut, addOut, subOut, MultOut, divOut,ClearEntryOut, startOut, clkOut;
    logic [3:0] State;

    parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101;

    clock_div #(.DIV(100000)) clockDivider (
        .clk(Clock), 
        .reset(~ClearAll), 
        .clk_out(clkOut)
    );
	 
	 EdgeDetect ClearEntry_D (
        .in(ClearEntry), 
        .clock(clkOut), 
        .out(ClearEntryOut)
    );
	 
    EdgeDetect ENT_D (
        .in(Enter), 
        .clock(clkOut), 
        .out(enterOut)
    );
	 
	 EdgeDetect STR_D (
        .in(Start), 
        .clock(clkOut), 
        .out(startOut)
    );
	 
	 
    EdgeDetect ADD_D (
        .in(Add), 
        .clock(clkOut), 
        .out(addOut)
    );
    EdgeDetect SUB_D (
        .in(Sub), 
        .clock(clkOut), 
        .out(subOut)
    );
    EdgeDetect MultT_D (
        .in(Mult), 
        .clock(clkOut), 
        .out(MultOut)
    );
    EdgeDetect DIV_D (
        .in(Div), 
        .clock(clkOut), 
        .out(divOut)
    );

	 


initial State = S0;

always @(posedge clkOut, negedge ClearAll) begin
    if (!ClearAll) begin
        State <= S0;
        Op <= 0;
    end else begin
        // Reset control signals by default at each clock cycle
        Ahigh_in = 0; Alow_in = 0; LoadB = 0; LoadResult = 0; LoadOU = 0; IU_AU = 0;

        case (State)
            S0: begin
                State <= S1;
            end
            S1: if (enterOut) begin
                Ahigh_in = 1;Alow_in = 1; LoadOU = 1;
                State <= S2;
            end

            S2: begin
                if (addOut) Op <= 2'b00;
                else if (subOut) Op <= 2'b01;
                else if (MultOut) Op <= 2'b10;
                else if (divOut) Op <= 2'b11;
                // Move to the next state only if any of the operations are selected
                if (addOut || subOut || MultOut || divOut) State <= S3;
            end
            S3: if (enterOut) begin
                LoadB = 1; LoadOU = 1;
                State <= S4;
            end
            S4: if (startOut) begin
                LoadResult = 1; IU_AU = 1;
                State <= S5;
            end
            S5: begin
                LoadResult = 1; LoadOU = 1; IU_AU = 1;
            end
        endcase
    end
end

endmodule
