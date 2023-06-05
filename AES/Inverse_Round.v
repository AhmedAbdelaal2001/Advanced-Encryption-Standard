module Inverse_Round(input[127:0] currentState, input[127:0] roundKey, input enableMixColumns,
				 output[127:0] newState);
	
	wire[127:0] postInverse_SubBytes;
	wire[127:0] postInverse_ShiftRows;
	wire[127:0] postAddRoundKey;


	Inverse_ShiftRows shiftBlock(currentState, postInverse_ShiftRows);
	Inverse_SubBytes subBlock(postInverse_ShiftRows, postInverse_SubBytes);
   AddRoundKey keyBlock(postInverse_SubBytes, roundKey, postAddRoundKey);
	Inverse_MixColumns mixingBlock(postAddRoundKey, enableMixColumns, newState);
	
	
	
endmodule