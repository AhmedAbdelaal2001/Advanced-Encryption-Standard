module TB_MixColumns();
	reg enable;
	reg[127:0] currentState;
	reg[127:0] correctOutput;
	wire[127:0] newState;
	wire flag;
	
	MixColumns testUnit(currentState, enable, newState);
	assign flag = correctOutput == newState;
	
	initial begin
		enable = 1;
		currentState = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
		correctOutput = 128'h046681e5e0cb199a48f8d37a2806264c;
		#100;
		
		enable = 0;
		#100;
		enable = 1;
		#100;
		
		currentState = 128'h49db873b453953897f02d2f177de961a;
		correctOutput = 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5;
		#100;
		
		currentState = 128'hacc1d6b8efb55a7b1323cfdf457311b5;
		correctOutput = 128'h75ec0993200b633353c0cf7cbb25d0dc;
		#100;
	end
endmodule
