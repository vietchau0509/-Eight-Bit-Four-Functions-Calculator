
module binary2bcd (
    input [15:0] A, // 16-bit input signal
    output [3:0] ONES, TENS, HUNDREDS, THOUSANDS, // 4-bit output signals
    output [1:0] TENTHOUSANDS // 2-bit output signal
);

    wire [3:0] c[1:29]; 
    wire [3:0] d[1:29]; 

    // Assignments for splitting the input and carrying over the additions
    assign d[1] = {1'b0, A[15:13]};
    assign d[2] = {c[1][2:0], A[12]};
    assign d[3] = {c[2][2:0], A[11]};
    assign d[4] = {c[3][2:0], A[10]};
    assign d[5] = {c[4][2:0], A[9]};
    assign d[6] = {c[5][2:0], A[8]};
    assign d[7] = {c[6][2:0], A[7]};
    assign d[8] = {c[7][2:0], A[6]};
    assign d[9] = {c[8][2:0], A[5]};
    assign d[10] = {c[9][2:0], A[4]};
    assign d[11] = {c[10][2:0], A[3]};
    assign d[12] = {c[11][2:0], A[2]};
    assign d[13] = {c[12][2:0], A[1]};
    assign d[14] = {c[15][2:0], c[12][3]};
    assign d[15] = {c[16][2:0], c[11][3]};
    assign d[16] = {c[17][2:0], c[10][3]};
    assign d[17] = {c[18][2:0], c[9][3]};
    assign d[18] = {c[19][2:0], c[8][3]};
    assign d[19] = {c[20][2:0], c[7][3]};
    assign d[20] = {c[21][2:0], c[6][3]};
    assign d[21] = {c[22][2:0], c[5][3]};
    assign d[22] = {c[23][2:0], c[4][3]};
    assign d[23] = {1'b0, c[1][3], c[2][3], c[3][3]};
    assign d[24] = {c[25][2:0], c[15][3]};
    assign d[25] = {c[26][2:0], c[16][3]};
    assign d[26] = {c[27][2:0], c[17][3]};
    assign d[27] = {c[28][2:0], c[18][3]};
    assign d[28] = {c[22][3], c[21][3], c[20][3], c[19][3]};
    assign d[29] = {c[28][3], c[27][3], c[26][3], c[25][3]};
    assign ONES = {c[13][2:0], A[0]};
    assign TENS = {c[14][2:0], c[13][3]};
    assign HUNDREDS = {c[24][2:0], c[14][3]};
    assign THOUSANDS = {c[29][2:0], c[24][3]};
    assign TENTHOUSANDS = {c[23][3], c[29][3]};

    // Instantiations of add3 modules using a generate block
    genvar i;
    generate
        for (i = 1; i <= 29; i = i + 1) begin : gen_add3
            add3 m(d[i], c[i]);
        end
    endgenerate

endmodule
