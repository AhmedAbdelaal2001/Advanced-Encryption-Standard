`timescale 1 ns / 10 ps

module tester();
	
	localparam period = 10;
	
	reg[127:0] plainText;
	reg[255:0] cipherKey;
	reg[7:0] Nk;
	reg clk;
	reg keyExpansionReset;
	reg cipherReset;
	reg decipherReset;
	
	wire[1919:0] keySchedule;
	wire[127:0] cipherText;
	wire[127:0] originalText;
	wire keyExpansionDone;
	wire cipherDone;
	wire decipherDone;
	
	
	KeyExpansion expandKey(clk, keyExpansionReset, cipherKey, Nk, keySchedule, keyExpansionDone);
	Cipher encryptionBlock(clk, cipherReset, Nk, plainText, keySchedule, cipherText, cipherDone);
	Decipher decryptionBlock(clk, decipherReset, Nk, cipherText, keySchedule, originalText, decipherDone);

	always
		#(period/2) clk = ~clk;
	
	always @(posedge keyExpansionDone, posedge cipherDone, posedge decipherDone) begin
		if (keyExpansionDone) 
			cipherReset = 0;
		if (cipherDone)
			decipherReset = 0;
		if (decipherDone)
			$finish;
	end
	
	
	initial begin
		
		clk = 0;
		keyExpansionReset = 1;
		cipherReset = 1;
		decipherReset = 1;
		
		Nk = 8'b00000100;
		plainText = 128'h00112233445566778899aabbccddeeff;
		cipherKey = 128'h000102030405060708090a0b0c0d0e0f;
		
		#(period);
		
		keyExpansionReset = 0;
	end
//	wire[7:0] Nk;
//	wire[127:0] cipherText;
//	wire[1919:0] keySchedule;
//	
//	reg resetKeySchedule;
//	reg resetCipher;
//	reg[127:0] plainText = 128'h00112233445566778899aabbccddeeff;
//	reg[255:0] cipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
//	reg[7:0] counter;
//	
//	assign Nk = 8'b00001000;
//	assign correctFlag = (cipherText == plainText) ? 1:0;
//	KeyExpansion expandKey(clk, resetKeySchedule, cipherKey, Nk, keySchedule);
//	Cipher encryptionBlock(clk, resetCipher, Nk, plainText, keySchedule, cipherText);
//	
//	always @(posedge clk, posedge reset) begin
//		if (reset) begin
//			counter = 0;
//			resetKeySchedule = 1;
//			resetCipher = 1;
//		end
//		else begin
//			if (counter < 73)
//				resetKeySchedule = 0;
//			else if (counter < 87) begin
//				resetCipher = 0;
//			end
//			counter = counter + 1;
//		end
//	end
endmodule
