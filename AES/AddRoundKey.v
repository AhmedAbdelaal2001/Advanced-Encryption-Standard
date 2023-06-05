//This module is responsible for adding/XORing the round key to the state matrix.
//The state is a two dimnesional array of bytes which stores the current state of the data being encrypted.
//The round key consists of 4 words (each word is 32 bits long) from the key schedule.
//This module will be used in the encryption and decryption steps, it will be called within each iteration/round.

module AddRoundKey(input[127:0] state, input[127:0] roundKey,
						 output[127:0] updatedState);
	//State: 4*4 matrix of bytes.
	//roundKey: An array of size 4, where each element is 4 bytes.
	//updatedState: The new state matrix after adding the round key.
	
	assign updatedState = state ^ roundKey;
	
endmodule
	