module TB_ShiftWordLeft();
	reg[31:0] inputWord;
	reg[1:0] shiftSize;
	wire[31:0] shiftedWord;
	
	ShiftWordLeft testUnit(inputWord, shiftSize, shiftedWord);
	initial begin
		//Shift the input by 1 byte.
		inputWord = 32'h27bfb441;
		shiftSize = 1;
		#100;
		
		//Shift the input by 2 bytes.
		inputWord = 32'hdedb3902;
		shiftSize = 2;
		#100;
		
		//Shift the input by 3 bytes.
		inputWord = 32'h73c1b523;
		shiftSize = 3;
		#100;
	end
endmodule
