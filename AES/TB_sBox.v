module TB_sBox();
	reg[7:0] inputElement;
	reg[7:0] correctOutput;
	wire[7:0] transformedElement;
	wire flag;
	
	sBox testUnit(inputElement, transformedElement);
	
	assign flag = (transformedElement == correctOutput)?1:0;
	
	initial begin
		inputElement = 8'h52;
		correctOutput = 8'h00;
		#100;
		
		inputElement = 8'he9;
		correctOutput = 8'h1e;
		#100;
		
		inputElement = 8'h9f;
		correctOutput = 8'hdb;
		#100;
	end 
endmodule
