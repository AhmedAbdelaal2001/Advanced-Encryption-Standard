module TB_SubBytes();
	reg[127:0] currentState;
	wire[127:0] newState;
	reg[127:0] correctOutput;
	wire flag;
	
	SubBytes testUnit(currentState, newState);
	assign flag = (newState == correctOutput)?1:0;
	
	//Test cases can be found in Appendix B - Cipher Example.
	initial begin
		currentState = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
		correctOutput = 128'hd42711aee0bf98f1b8b45de51e415230;
		#100;
		
		currentState = 128'ha49c7ff2689f352b6b5bea43026a5049;
		correctOutput = 128'h49ded28945db96f17f39871a7702533b;
		#100;
		
		currentState = 128'haa8f5f0361dde3ef82d24ad26832469a;
		correctOutput = 128'hac73cf7befc111df13b5d6b545235ab8;
		#100;
	end
endmodule
