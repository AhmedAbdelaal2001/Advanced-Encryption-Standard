module selfCheckingTB(input clk, input reset,
							 output reg[3:0] encryptionCorrect, output reg[3:0] decryptionCorrect);

	localparam idle = 0;
	localparam test = 1;
	
	wire miso;
	wire mosi;
	
	wire keyExpansionDone;
	wire encryptionDone;
	wire decryptionDone;
	
	wire resetKeyExpansion;
	wire resetCipher;
	wire resetDecipher;
	
	wire masterStoringEncrypted;
	wire masterStoringDecrypted;
	
	wire[2:0] cs;
	wire[127:0] masterData;
	
	wire[127:0] dataToEncryption;
	wire[127:0] dataFromEncryption;
	wire[127:0] dataToDecryption;
	wire[127:0] dataFromDecryption;
	
	wire[255:0] key_outSlave;
	wire[1919:0] keySchedule;
	
	reg SPIreset;
	reg state;
	//reg firstClock;
	reg[7:0] counter;
	reg[7:0] Nk;
	reg[127:0] message;
	reg[255:0] key;
	reg[127:0] correctEncryptedData;

	SPImaster master(Nk, message, key, clk, SPIreset, miso, keyExpansionDone, encryptionDone, decryptionDone, cs, mosi, resetKeyExpansion, resetCipher, resetDecipher, masterData, masterStoringEncrypted, masterStoringDecrypted);
	
	SPIslave_key slave_key(Nk, clk, SPIreset, mosi, cs[0], miso, key_outSlave);
	KeyExpansion expandKey(clk, resetKeyExpansion, key_outSlave, Nk, keySchedule, keyExpansionDone);
	
	SPIslave encryptionSlave(clk, SPIreset, mosi, cs[1], dataFromEncryption, miso, dataToEncryption);
	Cipher encryptionModule(clk, resetCipher, Nk, dataToEncryption, keySchedule, dataFromEncryption, encryptionDone);
	
	SPIslave decryptionSlave(clk, SPIreset, mosi, cs[2], dataFromDecryption, miso, dataToDecryption);
	Decipher decryptionModule(clk, resetDecipher, Nk, dataToDecryption, keySchedule, dataFromDecryption, decryptionDone);
	
	always @(posedge clk, posedge reset) begin
		
		if (reset) begin
			SPIreset = 1;
			counter = 0;
			//firstClock = 0;
			encryptionCorrect = 0;
			decryptionCorrect = 0;
			state = idle;
		end
		else begin
			case (state) 
				idle: begin
						SPIreset = 1;
						case(counter)
							
							0: begin
								message = 128'h3243f6a8885a308d313198a2e0370734;
								key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
								correctEncryptedData = 128'h3925841d02dc09fbdd118597196a0b32;
								Nk = 8'b00000100;
								state = test;
								counter = counter + 1;
							end
							
							1: begin
								message = 128'h00112233445566778899aabbccddeeff;
								key = 128'h000102030405060708090a0b0c0d0e0f;
								correctEncryptedData = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
								Nk = 8'b00000100;
								state = test;
								counter = counter + 1;
							end
							
							2: begin
								message = 128'h00112233445566778899aabbccddeeff;
								key = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
								correctEncryptedData = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
								Nk = 8'b00000110;
								state = test;
								counter = counter + 1;
							end
							
							3: begin
								message = 128'h00112233445566778899aabbccddeeff;
								key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
								correctEncryptedData = 128'h8ea2b7ca516745bfeafc49904b496089;
								Nk = 8'b00001000;
								state = test;
								counter = counter + 1;
							end
							
							default: state = idle;
						
						endcase
					end
					
					test: begin
						SPIreset = 0;
						if (masterStoringDecrypted) begin
							if(masterData == message)
								decryptionCorrect[counter - 1] = 1;
							state = idle;
						end
						else if (masterStoringEncrypted)
							if (masterData == correctEncryptedData)
								encryptionCorrect[counter - 1] = 1;
					end
			endcase
		end
	end
endmodule
