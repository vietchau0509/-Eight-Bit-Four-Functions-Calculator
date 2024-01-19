//Binary to Seven Segment Decoder - Active Low

module binary2seven (
input [3:0] BIN, //declare inputs
input SEL,
output logic [0:6] SEV); //declare outputs
	always_comb //check for input change
	if (SEL ==0)
				case ({BIN[3:0]}) //convert binary to seven segment
			4'b0000: {SEV[0:6]} = 7'b1111111;//0
			4'b0001: {SEV[0:6]} = 7'b1001111;//1
			4'b0010: {SEV[0:6]} = 7'b0010010;//2
			4'b0011: {SEV[0:6]} = 7'b0000110;//3
			4'b0100: {SEV[0:6]} = 7'b1001100;//4
			4'b0101: {SEV[0:6]} = 7'b0100100;//5
			4'b0110: {SEV[0:6]} = 7'b0100000;//6
			4'b0111: {SEV[0:6]} = 7'b0001111;//7
			4'b1000: {SEV[0:6]} = 7'b0000000;//8
			4'b1001: {SEV[0:6]} = 7'b0001100;//9
			4'b1010: {SEV[0:6]} = 7'b1111111;//A
			4'b1011: {SEV[0:6]} = 7'b1111111;//b
			4'b1100: {SEV[0:6]} = 7'b1111111;//C
			4'b1101: {SEV[0:6]} = 7'b1111111;//d
			4'b1110: {SEV[0:6]} = 7'b1111111;//E
			4'b1111: {SEV[0:6]} = 7'b1111111;//F
	endcase
	
	else
			case ({BIN[3:0]}) //convert binary to seven segment
			4'b0000: {SEV[0:6]} = 7'b0000001;//0
			4'b0001: {SEV[0:6]} = 7'b1001111;//1
			4'b0010: {SEV[0:6]} = 7'b0010010;//2
			4'b0011: {SEV[0:6]} = 7'b0000110;//3
			4'b0100: {SEV[0:6]} = 7'b1001100;//4
			4'b0101: {SEV[0:6]} = 7'b0100100;//5
			4'b0110: {SEV[0:6]} = 7'b0100000;//6
			4'b0111: {SEV[0:6]} = 7'b0001111;//7
			4'b1000: {SEV[0:6]} = 7'b0000000;//8
			4'b1001: {SEV[0:6]} = 7'b0001100;//9
			4'b1010: {SEV[0:6]} = 7'b1111110;//A
			4'b1011: {SEV[0:6]} = 7'b1111110;//b
			4'b1100: {SEV[0:6]} = 7'b1111110;//C
			4'b1101: {SEV[0:6]} = 7'b1111110;//d
			4'b1110: {SEV[0:6]} = 7'b1111110;//E
			4'b1111: {SEV[0:6]} = 7'b1111110;//F
	endcase

	
endmodule 