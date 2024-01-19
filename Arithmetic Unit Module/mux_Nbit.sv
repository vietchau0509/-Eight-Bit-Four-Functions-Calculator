module mux_Nbit #(parameter N = 8) (
    input [N-1:0] A, B,  //N-bit inputs
    output [N-1:0] Y,    //N-bit output
    input S              //select signal
);
    assign Y = (S == 0) ? A : B;
endmodule
