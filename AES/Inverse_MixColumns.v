module Inverse_MixColumns(input[127:0] currentState, input enable, output reg[127:0] newState);
	
	wire[127:0] mixedState;
	
	genvar i;
	generate
		for (i = 0; i<4; i = i + 1)
		begin: mixStateColumns
			Inverse_Mix_SingleColumn mixer(currentState[(127-32*i)-:32], mixedState[(127-32*i)-:32]);
		end
	endgenerate
	
	always @(*)
		if(enable == 1)
			newState = mixedState;
		else
			newState = currentState;
	
endmodule