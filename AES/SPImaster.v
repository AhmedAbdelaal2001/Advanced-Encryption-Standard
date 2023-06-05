module SPImaster(

input [7:0] Nk,
input [127:0] message,
input [255:0] key,
input clk,
input reset,
input miso,
input keyExpansionDone,
input encryptionDone,
input decryptionDone,
output reg [2:0] cs,
output reg mosi,
output reg resetKeyExpansion,
output reg resetCipher,
output reg resetDecipher,
output reg[127:0] data,
output reg storingEncryptedData,
output reg storingDecryptedData
);

	reg [255:0] keyRegister;   // Received data
	reg [2:0] state=3'b000;
	reg [3:0] round;
	reg [8:0] counter;

	parameter IDLE=0;
	parameter TRANSMITKEY = 1;
	parameter TRANSMITENC=2;
	parameter RECEIVEENC=3;
	parameter TRANSMITDEC=4;
	parameter RECEIVEDEC=5;

	wire[8:0] keySize;
	assign keySize = (Nk == 8'b00001000) ? 256:((Nk == 8'b00000110) ? 196:128);
	
	always @(posedge clk or posedge reset) begin

		if(reset) begin
			cs = 3'b111;
			state = IDLE;
			round = 0;
			counter = 0;
			keyRegister = key;
			data = message;
			resetKeyExpansion = 1;
			resetCipher = 1;
			resetDecipher = 1;
			storingEncryptedData = 0;
			storingDecryptedData = 0;
		end
		else begin
			case(state) 
				
				IDLE:
					begin
						counter = 0;
						
						case (round)
							
							0: begin
								cs = 3'b110;
								state = TRANSMITKEY;
							end
							
							1: begin
								resetKeyExpansion = 0;
								if (keyExpansionDone) begin
									cs = 3'b101;
									state = TRANSMITENC;
								end
								else
									state = IDLE;
							end
							
							2: begin
								resetCipher = 0;
								if (encryptionDone) begin
									cs = 3'b101;
									round = round + 1;
									state = IDLE;
								end
							end
							
							3: begin
								state = IDLE;
								round = round + 1;	
							end
							
							4: state = RECEIVEENC;
							
							5: begin
								storingEncryptedData = 1;
								cs = 3'b011;
								state = TRANSMITDEC;
							end
							
							6: begin
								resetDecipher = 0;
								if (decryptionDone) begin
									cs = 3'b011;
									round = round + 1;
									state = IDLE;
								end
							end
							
							7: begin
								state = IDLE;
								round = round + 1;
							end
							
							8: state = RECEIVEDEC;
							
							default: begin
								storingDecryptedData = 1;
								state = IDLE;
							end
						endcase
					end
				
				
				TRANSMITKEY:
					begin
						if (counter < keySize) begin
							state = TRANSMITKEY;
							counter = counter + 1;
						end
						else begin
							cs = 3'b111;
							state = IDLE;
							round = round + 1;
						end
					end
				
				
				TRANSMITENC: begin
					if (counter < 128) begin
						state = TRANSMITENC;
						counter = counter + 1;
					end
					else begin
						cs = 3'b111;
						state = IDLE;
						round = round + 1;
					end
				end
				
				
				RECEIVEENC: begin
					if (counter < 128) begin
						data[counter] = miso;
						state = RECEIVEENC;
						counter = counter + 1;
					end
					else begin
						cs = 3'b111;
						state = IDLE;
						round = round + 1;
					end
				end
				
				TRANSMITDEC: begin
					if (counter < 128) begin
						state = TRANSMITDEC;
						counter = counter + 1;
					end
					else begin
						cs = 3'b111;
						state = IDLE;
						round = round + 1;
					end
				end
				
				RECEIVEDEC: begin
					if (counter < 128) begin
						data[counter] = miso;
						state = RECEIVEDEC;
						counter = counter + 1;
					end
					else begin
						cs = 3'b111;
						state = IDLE;
						round = round + 1;
					end
				end
			endcase
		end
	end
	
	
	always @(negedge clk) begin
	
		case (state)
			TRANSMITKEY: mosi = keyRegister[counter - 1];
			TRANSMITENC: mosi = data[counter - 1];
			RECEIVEENC: mosi = 0;
			TRANSMITDEC: mosi = data[counter - 1];
			RECEIVEDEC: mosi = 0;
		endcase

	end
	
endmodule 