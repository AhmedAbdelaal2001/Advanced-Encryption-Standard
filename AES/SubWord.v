//Uses the S-Box to transform a word (32 bits).
//Subsitution happens one byte at a time.
module SubWord(input[31:0] inputWord, output[31:0] outputWord);
	
	genvar i;
	generate
		for (i = 0; i<4; i = i + 1)
		begin: substituteWord
			sBox substitute(inputWord[31-8*i-:8], outputWord[31-8*i-:8]);
		end
	endgenerate
	
endmodule
