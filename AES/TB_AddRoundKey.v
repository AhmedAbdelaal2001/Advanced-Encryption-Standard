module TB_AddRoundKey();
	reg[127:0] state;
	reg[127:0] roundKey;
	reg[127:0] correctOutput;
	wire[127:0] updatedState;
	wire flag;

	AddRoundKey testUnit(state, roundKey, updatedState);
	assign flag = (updatedState == correctOutput)?1:0;
	
	//The following test cases can be found in Appendix B - Cipher Example in the AES document.
	initial begin
		state = 128'h3243f6a8885a308d313198a2e0370734;
		roundKey = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		correctOutput = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
		#100;
		
		state = 128'h046681e5e0cb199a48f8d37a2806264c;
		roundKey = 128'ha0fafe1788542cb123a339392a6c7605;
		correctOutput = 128'ha49c7ff2689f352b6b5bea43026a5049;
		#100;
		
		state = 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5;
		roundKey = 128'hf2c295f27a96b9435935807a7359f67f;
		correctOutput = 128'haa8f5f0361dde3ef82d24ad26832469a;
		#100;
	end
endmodule
