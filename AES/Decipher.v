module Decipher (input clk, input reset, input[7:0] Nk,
					  input[127:0] cipherText, input[1919:0] keySchedule,
					  output[127:0] originalText, output reg doneFlag);
	
	wire[127:0] initialState;
	wire[127:0] nextState;
	wire[3:0] totalRoundNumber;
	wire[9:0] startingPoint;
	
	reg[127:0] currentState;
	reg[127:0] keyScheduleElement;
	reg[3:0] roundCounter;
	reg enableMixColumns;
	
	assign totalRoundNumber = (Nk == 8'b00000100) ? 9:((Nk == 8'b00000110) ? 11:13);
	assign startingPoint = (Nk == 8'b00000100) ? 512:((Nk == 8'b00000110) ? 256:0);
	AddRoundKey applyKey_start(cipherText, keySchedule[(127 + startingPoint) -: 128], initialState);
	Inverse_Round decryptionRoundBlock(currentState, keyScheduleElement, enableMixColumns, nextState);
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			roundCounter <= 0;
			enableMixColumns <= 1;
			currentState <= initialState;
			keyScheduleElement <= keySchedule[(255 + startingPoint) -: 128];
			doneFlag = 0;
		end
		else begin
			if (roundCounter < totalRoundNumber) begin
				currentState = nextState;
				keyScheduleElement = keySchedule[(383+(roundCounter*128) + startingPoint) -: 128];
				roundCounter = roundCounter + 1;
			end
			else if (roundCounter == totalRoundNumber) begin
					enableMixColumns = 0;
					roundCounter = roundCounter + 1;
			end
			else
				doneFlag = 1;
		end
	end
	
	assign originalText = nextState;
endmodule

