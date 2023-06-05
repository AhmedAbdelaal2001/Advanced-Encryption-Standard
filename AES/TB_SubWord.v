module TB_SubWord();
	reg[31:0] inputWord;
	wire[31:0] outputWord;
	
	SubWord testUnit(inputWord, outputWord);
	
	initial begin
		inputWord = 32'h52e99f00;
		#100;
	end
endmodule
