module TB_Mix_SingleColumn();
	reg[31:0] currentColumn;
	wire[31:0] newColumn;
	
	Mix_SingleColumn testUnit(currentColumn, newColumn);
	
	initial begin
		currentColumn = 32'hd4bf5d30;
		//Expected Output: 046681e5
		#100;
		
		currentColumn = 32'he0b452ae;
		//Expected Output: e0cb199a
		#100;
		
		currentColumn = 32'hb84111f1;
		//Expected Output: 48f8d37a
		#100;
	end
endmodule
