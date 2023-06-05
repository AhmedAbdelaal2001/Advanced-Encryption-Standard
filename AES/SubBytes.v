//Applies the subsitution (multiplicative inverse followed by an affine transformation)
//to each byte in the state.

module SubBytes(input[127:0] currentState, output[127:0] newState);

	//Generate 16 substitution blocks, each of which is responsible for transforming 1 byte.
	genvar i;
	generate
		for (i = 0; i<16; i = i + 1) 
		begin: transformState
			sBox transformer(currentState[8*i+7-:8], newState[8*i+7-:8]);
		end
	endgenerate

endmodule
