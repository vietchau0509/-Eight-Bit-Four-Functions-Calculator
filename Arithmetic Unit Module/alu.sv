module alu #(parameter N = 8) (
    input [N:0] A,           //N+1 bit operand
    input [N-1:0] B,         //N bit operand
    output [N:0] Result,     //N+1 bit result (includes carry)
    input Sel                //Sel = 0 for add, 1 for sub
);

    assign Result = (Sel == 0) ? (A + B) : (A - B);

endmodule
