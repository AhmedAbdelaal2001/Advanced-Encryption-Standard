`timescale 1 ns / 10 ps

module TB_KeyExpansion();
	
	localparam period = 10;
	
	reg clk;
	reg reset;
	reg[255:0] key;
	reg[7:0] Nk;
	
	wire[1919:0] w;
	wire doneFlag;
	KeyExpansion testUnit(clk, reset, key, Nk, w, doneFlag);
	
	always
		#(period/2) clk = ~clk;
	
	initial begin
		clk = 0;
		reset = 1;
		//key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		//Nk = 8'b00000100;
		
		key = 192'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b;
		Nk = 8'b00000110;
		
		//key = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
		//Nk = 8'b00001000;
		
		#(period);
		
		reset = 0;
		
		#(61*period);
		$finish;
		
	end
endmodule
