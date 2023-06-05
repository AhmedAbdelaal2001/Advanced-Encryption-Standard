module TB_ShiftRows();
	reg[127:0] currentState;
	reg[127:0] correctOutput;
	wire[127:0] newState;
	wire flag;
	
	ShiftRows testUnit(currentState, newState);
	assign flag = newState == correctOutput;
	
	//Test cases can be found in Appendix B - Cipher Example.
	initial begin
		currentState = 128'hd42711aee0bf98f1b8b45de51e415230;
		correctOutput = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
		#100;
		
		currentState = 128'h49ded28945db96f17f39871a7702533b;
		correctOutput = 128'h49db873b453953897f02d2f177de961a;
		#100;
		
		currentState = 128'hac73cf7befc111df13b5d6b545235ab8;
		correctOutput = 128'hacc1d6b8efb55a7b1323cfdf457311b5;
		#100;
	end
endmodule
