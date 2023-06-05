`timescale 1 ns / 10 ps

module selfCheckingTB_simulator();
	
	localparam period = 10;
	
	reg clk;
	reg reset;
	
	wire[3:0] encryptionCorrect;
	wire[3:0] decryptionCorrect;
	
	selfCheckingTB wrapperUnit(clk, reset, encryptionCorrect, decryptionCorrect);
	
	always
		#(period/2) clk = ~clk;
		
	always @(posedge clk) begin
		if (decryptionCorrect == 4'b1111) begin
			
			#(100*period);
			reset = 1;
			
			#(100*period);
			reset = 0;
		end
	end
	initial begin
		clk = 0;
		reset = 1;
		
		#(10*period);
		
		reset = 0;
	end
endmodule
