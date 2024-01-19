module shiftreg #(parameter N = 8) (
    input [N-1:0] D,       //parallel inputs
    output reg [N-1:0] Q,  //register outputs
    input CLK,             //clock (active high)
    input LD,              //synchronous load select
    input SH,              //synchronous shift select
    input SerIn            //serial shift input
);

always @(posedge CLK)
begin
    if (LD == 1'b1)
        Q = D;                  //synchronous load
    else if (SH == 1'b1)
        Q = {Q[N-2:0], SerIn};  //synchronous left shift
    else
        Q = Q;                  //default hold state
end

endmodule
