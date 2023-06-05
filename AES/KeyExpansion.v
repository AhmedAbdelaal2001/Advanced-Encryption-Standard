module KeyExpansion (input clk, input reset,
							input[255:0] key, input[7:0] Nk, 
							output reg[1919:0] w, output reg doneFlag);
	wire[4:0] Nr;
	wire[31:0] temp_ShiftWord;
	wire[31:0] temp_SubWord;
	wire[31:0] temp_Shift_SubWord;
	wire[31:0] temp_Rcon;
	wire[31:0] Xor;
	
	reg[31:0] temp;
	reg[7:0] counter;
	reg specialCasesFlag;
	
	assign Nr = (Nk == 8'b00000100) ? 4'b1010:((Nk == 8'b00000110) ? 4'b1100: 4'b1110);
	ShiftWordLeft shiftTemp(temp, 1, temp_ShiftWord);
	SubWord subTemp(temp, temp_SubWord);
	SubWord shiftSubTemp(temp_ShiftWord, temp_Shift_SubWord);
	Rcon RconTemp(counter/Nk, temp_Rcon);
	assign Xor = temp_Shift_SubWord ^ temp_Rcon;
	
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			counter = 0;
			specialCasesFlag = 0;
			doneFlag = 0;
		end
		else begin
			if (specialCasesFlag == 0)
				temp = w[1919-32*(counter-1) -: 32];
			if (counter < Nk) begin
				w[1919-(32*counter) -: 32] = key[32*(Nk-counter)-1-:32];
				counter = counter + 1;
			end
			else if (counter < 4 * (Nr + 1)) begin
				if ((counter % Nk) == 0) begin
					if (specialCasesFlag == 1)
						temp = Xor;
					specialCasesFlag = ~specialCasesFlag;
				end
				else if (Nk > 6 && ((counter % Nk) == 4)) begin
					if (specialCasesFlag == 1)
						temp = temp_SubWord;
					specialCasesFlag = ~specialCasesFlag;
				end
					
				w[1919-32*counter -: 32] = w[1919-32*(counter-Nk) -: 32] ^ temp;
				if (specialCasesFlag == 0)
					counter = counter + 1;
			end
			else
				doneFlag = 1;
		end
	end 
endmodule
