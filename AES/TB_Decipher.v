`timescale 1 ns / 10 ps

module TB_Decipher();
	
	localparam period = 10;
	
	reg clk;
	reg resetKeySchedule;
	reg resetDecipher;
	reg[7:0] Nk;
	reg[127:0] cipherText;
	reg[255:0] cipherKey;
	
	wire[127:0] originalText;
	wire[1919:0] keySchedule;
	wire keyExpansionDone;
	wire decipherDone;
	
	KeyExpansion expandKey(clk, resetKeySchedule, cipherKey, Nk, keySchedule, keyExpansionDone);
	Decipher decryptionBlock(clk, resetDecipher, Nk, cipherText, keySchedule, originalText, decipherDone);
	
	always
		#(period/2) clk = ~clk;
	
	always @(posedge keyExpansionDone, posedge decipherDone) begin
		if (keyExpansionDone) 
			resetDecipher = 0;
		if (decipherDone)
			$finish;
	end
	
	initial begin
		
		clk = 0;
		resetKeySchedule = 1;
		resetDecipher = 1;
		
		Nk = 8'b00000100;
		cipherText = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		cipherKey = 256'h000102030405060708090a0b0c0d0e0f;
		
		//Nk = 8'b00000110;
		//cipherText = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
		//cipherKey = 256'h000102030405060708090a0b0c0d0e0f1011121314151617;
		
		//Nk = 8'b00001000;
		//cipherText = 128'h8ea2b7ca516745bfeafc49904b496089;
		//cipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
		
		#(period);
		
		resetKeySchedule = 0;
	end
endmodule
