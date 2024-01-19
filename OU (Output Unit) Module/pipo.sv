// parallel in - parallel out
module pipo #(parameter N = 4) (
    input [N-1:0] D,
    input clock, clear,
    output reg [N-1:0] Q
);

always @(negedge clock, negedge clear) begin
    if (clear == 1'b0) 
        Q <= 0;
    else if (clock == 1'b0) 
        Q <= D;
end

endmodule
