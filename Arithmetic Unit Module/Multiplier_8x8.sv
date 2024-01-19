// 8x8 Signed Multiplier
module Multiplier_8x8 (
    input Clock, START, Reset, // Control signals
    input [7:0] Multiplicand, Multiplier, // Operands
    output reg [15:0] Product, // Result
    output Halt // Completion flag
);
    reg [7:0] RegQ, RegM; // Operand registers
    reg [8:0] RegA; // Auxiliary register
    reg [3:0] Count; // Iteration counter
    wire C0, Start, Add, Shift; // Control flags
    reg signed_1; // Result sign

    // Product sign handling
    always_comb
        Product = signed_1 ? -{RegA[7:0],RegQ} : {RegA[7:0],RegQ};

    // Iteration counter
    always @(posedge Clock)
        if (Start) Count <= 4'b0000;
        else if (Shift) Count <= Count + 1;

    assign C0 = Count[3]; // Final iteration check

    // Sign, load, shift registers
    always @(posedge Clock) begin
        if (Start) begin
            signed_1 <= Multiplicand[7] ^ Multiplier[7];
            RegM <= Multiplicand[7] ? -Multiplicand : Multiplicand;
            RegQ <= Multiplier[7] ? -Multiplier : Multiplier;
        end
        else if (Shift) 
            RegQ <= {RegA[0], RegQ[7:1]};
    end

    // Accumulator operations
    always @(posedge Clock)
        if (Start) RegA <= 9'b000000000;
        else if (Add) RegA <= RegA + RegM;
        else if (Shift) RegA <= RegA >>> 1;

    // Control unit
    MultController_8x8 Ctrl (
        Clock, 
        START, 
        RegQ[0], 
        C0, 
        Start, 
        Add, 
        Shift, 
        Halt
    );

endmodule
