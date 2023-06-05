module TB_MultiplyBy2();
	reg[7:0] inputValue;
	wire[7:0] outputValue;
	
	MultiplyBy2 testUnit(inputValue, outputValue);
	
	initial begin
		inputValue = 8'h57;
		#100;
		
		inputValue = 8'hae;
		#100;
		
		inputValue = 8'h47;
		#100;
		
		inputValue = 8'h8e;
		#100;
	end
	
endmodule
