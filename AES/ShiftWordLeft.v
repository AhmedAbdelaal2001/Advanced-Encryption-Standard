//Rotates a block of 32 bits to the left.
//The rotation is shiftSize*8 bits. 
module ShiftWordLeft(input[31:0] inputWord, input[1:0] shiftSize, 
							output[31:0] shiftedWord);
	
	assign shiftedWord[31:24] = inputWord[(31-8*shiftSize)%32-:8];
	assign shiftedWord[23:16] = inputWord[(23-8*shiftSize)%32-:8];
	assign shiftedWord[15:8] = inputWord[(15-8*shiftSize)%32-:8];
	assign shiftedWord[7:0] = inputWord[(7-8*shiftSize)%32-:8];
		
endmodule
