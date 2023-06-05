module TB_MultiplierGF();
	reg[7:0] inputNum;
	reg[7:0] factor;
	wire[7:0] result;
	
	MultiplierGF testUnit(inputNum, factor, result);
	
	initial begin
			
		inputNum = 8'h57;
		factor = 8'h02;
		//Expected Output: ae
		#100;
		
		factor = 8'h03;
		//Expected Output: f9
		#100;
		
		factor = 8'h09;
		//Expected Output: d9
		#100;
		
		factor = 8'h0b;
		#100;
		
		factor = 8'h0d;
		#100;
		
		factor = 8'h0e;
		#100;
		
	end

endmodule
