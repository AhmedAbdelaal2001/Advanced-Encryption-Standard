`timescale 1 ns / 10 ps

module Wrapper();
	
	localparam period = 10;
	
	reg[7:0] Nk;
	reg[127:0] message;
	reg[255:0] key;
	reg clk;
	reg reset;
	
	wire resetKeyExpansion;
	wire resetCipher;
	wire resetDecipher;
	wire miso;
	wire mosi;
	wire keyExpansionDone;
	wire encryptionDone;
	wire decryptionDone;
	wire[2:0] cs;
	wire[255:0] key_outSlave;
	wire[1919:0] keySchedule;
	wire[127:0] dataToEncryption;
	wire[127:0] dataFromEncryption;
	wire[127:0] dataToDecryption;
	wire[127:0] dataFromDecryption;
	wire[127:0] masterData;
	wire masterStoringEncrypted;
	wire masterStoringDecrypted;
	
	SPImaster master(Nk, message, key, clk, reset, miso, keyExpansionDone, encryptionDone, decryptionDone, cs, mosi, resetKeyExpansion, resetCipher, resetDecipher, masterData, masterStoringEncrypted, masterStoringDecrypted);
	SPIslave_key slave_key(Nk, clk, reset, mosi, cs[0], miso, key_outSlave);
	KeyExpansion expandKey(clk, resetKeyExpansion, key_outSlave, Nk, keySchedule, keyExpansionDone);
	SPIslave encryptionSlave(clk, reset, mosi, cs[1], dataFromEncryption, miso, dataToEncryption);
	Cipher encryptionModule(clk, resetCipher, Nk, dataToEncryption, keySchedule, dataFromEncryption, encryptionDone);
	SPIslave decryptionSlave(clk, reset, mosi, cs[2], dataFromDecryption, miso, dataToDecryption);
	Decipher decryptionModule(clk, resetDecipher, Nk, dataToDecryption, keySchedule, dataFromDecryption, decryptionDone);
	
	always
		#(period/2) clk = ~clk;
	
	initial begin
		clk = 0;
		reset = 1;
		message = 128'h00112233445566778899aabbccddeeff;
		key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
		Nk = 8'b00001000;
		//key = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
		//Nk = 8'b00000110;
		//key = 128'h000102030405060708090a0b0c0d0e0f;
		//Nk = 8'b00000100;
		#(period);
		
		reset = 0;
	end
	
endmodule
