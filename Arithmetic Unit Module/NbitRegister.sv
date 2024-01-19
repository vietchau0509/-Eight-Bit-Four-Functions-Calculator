////Verilog Model of an N-bit register with active-low clear and clock enable
module NbitRegister #(parameter N=4) //declare default value for N
( input [N-1:0] D,						//declare N-bit data input
input CLK, CLR, CE, 						//declare clock, clear, and clock enable inputs
output logic [N-1:0] Q);				//declare N-bit data output

	always_ff @(posedge CLK, negedge CLR)
		begin 
			if(CLR==1'b0) Q<=0;
				else if (CLK & CE ==1'b1) Q<=D;
					else Q<=Q;
		end
endmodule
