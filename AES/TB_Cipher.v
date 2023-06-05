`timescale 1 ns / 10 ps

module TB_Cipher();
	
	localparam period = 10;
	
	reg clk;
	reg resetKeySchedule;
	reg resetCipher;
	reg[7:0] Nk;
	reg[127:0] plainText;
	reg[255:0] cipherKey;
	
	wire[127:0] cipherText;
	wire[1919:0] keySchedule;
	wire keyExpansionDone;
	wire cipherDone;
	
	KeyExpansion expandKey(clk, resetKeySchedule, cipherKey, Nk, keySchedule, keyExpansionDone);
	Cipher encryptionBlock(clk, resetCipher, Nk, plainText, keySchedule, cipherText, cipherDone);
	
	always
		#(period/2) clk = ~clk;
	
	always @(posedge keyExpansionDone, posedge cipherDone) begin
		if (keyExpansionDone) 
			resetCipher = 0;
		if (cipherDone)
			$finish;
	end
	
	initial begin
		
		clk = 0;
		resetKeySchedule = 1;
		resetCipher = 1;
		
//		Nk = 8'b00000100;
//		plainText = 128'h00112233445566778899aabbccddeeff;
//		cipherKey = 128'h000102030405060708090a0b0c0d0e0f;
		
		Nk = 8'b00000110;
		plainText = 128'h00112233445566778899aabbccddeeff;
		cipherKey = 256'h000102030405060708090a0b0c0d0e0f1011121314151617;
		
		//Nk = 8'b00001000;
		//plainText = 128'h00112233445566778899aabbccddeeff;
		//cipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
		
		#(period);
		
		resetKeySchedule = 0;
	end
endmodule
