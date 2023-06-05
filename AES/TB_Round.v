module TB_Round();
	reg[127:0] currentState;
	reg[127:0] roundKey;
	reg[127:0] correctOutput;
	wire[127:0] newState;
	wire flag;
	
	Round testUnit(currentState, roundKey, newState);
	assign flag = newState == correctOutput;
	
	initial begin
		currentState = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
		roundKey = 128'ha0fafe1788542cb123a339392a6c7605;
		correctOutput = 128'ha49c7ff2689f352b6b5bea43026a5049;
		#100;
		
		currentState = 128'ha49c7ff2689f352b6b5bea43026a5049;
		roundKey = 128'hf2c295f27a96b9435935807a7359f67f;
		correctOutput = 128'haa8f5f0361dde3ef82d24ad26832469a;
		#100;
	end
endmodule
