//Edge detector circuit
module EdgeDetect (
    input in, clock,
    output out
);

    reg in_delay;

    always @ (posedge clock) begin
        in_delay <= in;
    end

    assign out = in & ~in_delay;

endmodule
