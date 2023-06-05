module Cipher (input clk, input reset, input[7:0] Nk,
					input[127:0] plainText, input[1919:0] keySchedule,
					output[127:0] cipherText, output reg doneFlag);
	
	wire[127:0] initialState;
	wire[127:0] nextState;
	wire[3:0] totalRoundNumber;
	
	reg[127:0] currentState;
	reg[127:0] keyScheduleElement;
	reg[3:0] roundCounter;
	reg enableMixColumns;
	
	assign totalRoundNumber = (Nk == 8'b00000100) ? 9:((Nk == 8'b00000110) ? 11:13);
	AddRoundKey applyKey_start(plainText, keySchedule[1919:1792], initialState);
	Round encryptionRoundBlock(currentState, keyScheduleElement, enableMixColumns, nextState);
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			roundCounter <= 0;
			enableMixColumns <= 1;
			currentState <= initialState;
			keyScheduleElement <= keySchedule[1791:1664];
			doneFlag = 0;
		end
		else begin
			if (roundCounter < totalRoundNumber) begin
				currentState = nextState;
				keyScheduleElement = keySchedule[1663-(roundCounter*128) -: 128];
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
	
	assign cipherText = nextState;
	
//	wire[128*(Nr+2)-1:0] Rounds_States;
//	wire[128*(Nr+1)-1:0] keySchedule;
//	KeyExpansion #(Nk, Nr) generateSchedule(cipherKey, keySchedule);
//	
//	AddRoundKey applyKey_start(plainText, keySchedule[128*(Nr+1)-1-:128], Rounds_States[128*(Nr+2)-1-:128]);
//	
//	genvar round;
//	generate
//		for (round = 1; round < Nr; round = round + 1)
//		begin: executeRounds
//			Round encryptionRound(Rounds_States[128*(Nr+2-round+1)-1-:128], keySchedule[128*(Nr+1-round)-1-:128], Rounds_States[128*(Nr+2-round)-1-:128]);
//		end
//	endgenerate
//	
//	SubBytes subBlock(Rounds_States[383-:128], Rounds_States[255-:128]);
//	ShiftRows shiftBlock(Rounds_States[255-:128], Rounds_States[127:0]);
//	AddRoundKey applyKey_end(Rounds_States[127:0], keySchedule[127:0], cipherText);

endmodule
