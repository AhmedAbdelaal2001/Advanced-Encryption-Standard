//Applies the matrix multiplication shown in section 5.1.3 to a single column.

module Mix_SingleColumn(input[31:0] currentColumn, output[31:0] newColumn);
	
	wire[7:0] two_firstByte; 
	wire[7:0] three_firstByte;
	wire[7:0] two_secondByte;
	wire[7:0] three_secondByte;
	wire[7:0] two_thirdByte;
	wire[7:0] three_thirdByte;
	wire[7:0] two_fourthByte;
	wire[7:0] three_fourthByte;
	
	MultiplierGF multiplier1(currentColumn[31:24], 8'h02, two_firstByte);
	MultiplierGF multiplier2(currentColumn[23:16], 8'h03, three_secondByte);
	MultiplierGF multiplier3(currentColumn[23:16], 8'h02, two_secondByte);
	MultiplierGF multiplier4(currentColumn[15:8], 8'h03, three_thirdByte);
	MultiplierGF multiplier5(currentColumn[15:8], 8'h02, two_thirdByte);
	MultiplierGF multiplier6(currentColumn[7:0], 8'h03, three_fourthByte);
	MultiplierGF multiplier7(currentColumn[31:24], 8'h03, three_firstByte);
	MultiplierGF multiplier8(currentColumn[7:0], 8'h02, two_fourthByte);

	assign newColumn[31:24] = two_firstByte ^ three_secondByte ^ currentColumn[15:8] ^ currentColumn[7:0];
	assign newColumn[23:16] = currentColumn[31:24] ^ two_secondByte ^ three_thirdByte ^ currentColumn[7:0];
	assign newColumn[15:8] = currentColumn[31:24] ^ currentColumn[23:16] ^ two_thirdByte ^ three_fourthByte;
	assign newColumn[7:0] = three_firstByte ^ currentColumn[23:16] ^ currentColumn[15:8] ^ two_fourthByte;

endmodule
