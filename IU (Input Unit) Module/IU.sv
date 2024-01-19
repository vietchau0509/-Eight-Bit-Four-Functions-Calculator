// Input Unit Module ^^
module IU (
    input Clock, Clear,
    input [3:0] rows,
    output Add, Sub, Mult, Div, Start,
    output [3:0] cols,
    output [15:0] Out,
    output [0:6] SEV0, SEV1, SEV2, SEV3
);

    logic [15:0] decimal, binary, keyOut;
    logic [3:0] Set;

    always @(*) begin
        if (keyOut[15:12] == 4'b1110 || keyOut[15:12] == 4'b1011) 
            decimal = keyOut[11:0];
        else 
            decimal = keyOut;
    end

    always @(*) begin
        if (keyOut[15:12] == 4'b1110 || keyOut[15:12] == 4'b1011) 
            Out = -binary[11:0];
        else 
            Out = binary;
    end

    always @(*) begin
		  Start = (Set == 4'b1111);
        Add = (Set == 4'b1010);
        Sub = (Set == 4'b1011);
        Mult = (Set == 4'b1100);
        Div = (Set == 4'b1101);
        
    end

    keypad_input KeyPad (
        .clk(Clock), 
        .reset(Clear), 
        .row(rows),
        .col(cols), 
        .out(keyOut), 
        .value(Set)
    );

    BCD2BinarySM #(16) BinaryConv (
        .BCD(decimal), 
        .binarySM(binary)
    );

    binary2seven(.BIN(Out[3:0]), .SEV(SEV0));
    binary2seven(.BIN(Out[3:0]), .SEV(SEV1));
    binary2seven(.BIN(Out[3:0]), .SEV(SEV2));
    binary2seven(.BIN(Out[3:0]), .SEV(SEV3));

endmodule
