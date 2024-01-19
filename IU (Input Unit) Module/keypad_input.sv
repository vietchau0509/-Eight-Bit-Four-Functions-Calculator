module keypad_input // Depends: keypad_base(clock_div, keypad_fsm, keypad_decoder), shift_reg
    #(parameter DIGITS = 4) (
    input clk,
    input reset,
    input [3:0] row,
    output [3:0] col,
    output [(DIGITS*4)-1:0] out,
    // Debug
    output [3:0] value,
    output trig
);

    // Instance of keypad_base
    keypad_base keypad_base(
        .clk(clk),
        .row(row),
        .col(col),
        .value(value),
        .valid(trig)
    );

    // Instance of shift_reg
    shift_reg #(.COUNT(DIGITS)) shift_reg(
        .trig(trig),
        .in(value),
        .out(out),
        .reset(reset)
    );

endmodule
