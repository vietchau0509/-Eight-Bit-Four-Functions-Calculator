// Multiplier Controller
module MultController_8x8 (
    input Clock, START, Q0, C0, // Inputs
    output reg Start, Add, Shift, Halt // Outputs
);
    reg [4:0] state; // State register
    // States
    parameter StartS=5'b00001, TestS=5'b00010, AddS=5'b00100, ShiftS=5'b01000, HaltS=5'b10000;
    reg [2:0] Counter; // Iteration counter
	 initial state = StartS; //******************************************************************************
    // State transition logic
    always @(posedge Clock)
    begin
            case (state)
                StartS: begin
                    state <= TestS; // Next state
                    Counter <= 3'b000; // Initialize counter
                end
                TestS: 
                    state <= Q0 ? AddS : ShiftS; // Determine next state based on Q0
                AddS: state <= ShiftS; // Next state
                ShiftS: begin
                    if (Counter == 3'b111 || C0) // End condition 
                        state <= HaltS; 
                    else begin
                        state <= TestS; // Loop back
                        Counter <= Counter + 1; // Update counter
                    end
                end
                HaltS: if(START) state<=StartS; else state <= HaltS; // Maintain state
            endcase
      
    end

    // Output assignments
    assign Start = state[0]; // Start signal
    assign Add = state[2]; // Add signal
    assign Shift = state[3]; // Shift signal
    assign Halt = state[4]; // Halt signal

endmodule
