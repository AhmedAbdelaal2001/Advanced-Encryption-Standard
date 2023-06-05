module Inverse_SubBytes(input[127:0] currentState, output[127:0] newState);

	genvar i;
	generate
		for (i = 0; i<16; i = i + 1) 
		begin: transformState
			Inverse_sBox transformByte(currentState[8*i+7-:8],newState[8*i+7-:8]);
		end
	endgenerate

endmodule