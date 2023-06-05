module Inverse_ShiftRows(input[127:0] currentState, output[127:0] newState);
	
	//First Row
	assign {newState[127:120], newState[95:88], newState[63:56], newState[31:24]} = {currentState[127:120], currentState[95:88], currentState[63:56], currentState[31:24]};
	
	//Second Row
	Rotate Shift1({currentState[119:112], currentState[87:80], currentState[55:48], currentState[23:16]},{newState[119:112], newState[87:80], newState[55:48], newState[23:16]});

	//Third Row
	Rotate #(.n(16)) Shift2({currentState[111:104], currentState[79:72], currentState[47:40], currentState[15:8]},{newState[111:104], newState[79:72], newState[47:40], newState[15:8]});
						
	//Fourth Row	
	Rotate #(.n(24)) Shift3({currentState[103:96], currentState[71:64], currentState[39:32], currentState[7:0]},{newState[103:96], newState[71:64], newState[39:32], newState[7:0]});

endmodule