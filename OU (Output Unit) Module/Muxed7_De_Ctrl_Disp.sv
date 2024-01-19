// Segment Display Controller
module Muxed7_De_Ctrl_Disp (
    input [3:0] Hex4, Hex3, Hex2, Hex1, // Input hex data
    input clk, rst, activate,           // Clock, reset, and activate signals
    output logic [3:0] DIG,             // Output for digits
    output logic [0:6] SGNL             // Output for segment signals
);

    wire [3:0] Inter0, Inter1, Inter2, Inter3, MuxedOut;
    wire [1:0] MuxSel;

    // Parallel-In Parallel-Out units for each hex data
    pipo Data0 (.D(Hex1), .clock(activate), .clear(rst), .Q(Inter0));
    pipo Data1 (.D(Hex2), .clock(activate), .clear(rst), .Q(Inter1));
    pipo Data2 (.D(Hex3), .clock(activate), .clear(rst), .Q(Inter2));
    pipo Data3 (.D(Hex4), .clock(activate), .clear(rst), .Q(Inter3));

    // Mux selection based on hex data
    four2one digit_position (
        .A(MuxSel[0]), .B(MuxSel[1]),
        .D0(Inter0), .D1(Inter1), .D2(Inter2), .D3(Inter3),
        .Y(MuxedOut)
    );

    // Control FSM for digit and selection
    FSM display_controller (
        .slow_clock(clk), .reset(rst), .SEL(MuxSel), .CAT(DIG)
    );

    // Binary to 7-segment display conversion
    binary2seven_hex display (.BIN(MuxedOut), .SEV(SGNL));

endmodule
