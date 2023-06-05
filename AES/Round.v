module Round(input[127:0] currentState, input[127:0] roundKey, input enableMixColumns,
				 output[127:0] newState);
	
	wire[127:0] postSubBytes;
	wire[127:0] postShiftRows;
	wire[127:0] postMixColumns;
	
	SubBytes subBlock(currentState, postSubBytes);
	ShiftRows shiftBlock(postSubBytes, postShiftRows);
	MixColumns mixingBlock(postShiftRows, enableMixColumns, postMixColumns);
	AddRoundKey keyBlock(postMixColumns, roundKey, newState);
	
	
endmodule
