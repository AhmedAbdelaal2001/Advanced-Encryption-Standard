module Inverse_Mix_SingleColumn(input[31:0] currentColumn, output[31:0] newColumn);
	
		  wire[7:0] e_firstByte;
        wire[7:0] nine_firstByte;
        wire[7:0] d_firstByte;
        wire[7:0] b_firstByte;

        wire[7:0] e_secondByte;
        wire[7:0] nine_secondByte;
        wire[7:0] d_secondByte;
        wire[7:0] b_secondByte;

        wire[7:0] e_thirdByte;
        wire[7:0] nine_thirdByte;
        wire[7:0] d_thirdByte;
        wire[7:0] b_thirdByte;

        wire[7:0] e_fourthByte;
        wire[7:0] nine_fourthByte;
        wire[7:0] d_fourthByte;
        wire[7:0] b_fourthByte;
	

	
		  MultiplierGF multiplier1(currentColumn[31:24], 8'h0e, e_firstByte);
        MultiplierGF multiplier2(currentColumn[31:24], 8'h09, nine_firstByte);
        MultiplierGF multiplier3(currentColumn[31:24], 8'h0d, d_firstByte);
        MultiplierGF multiplier4(currentColumn[31:24], 8'h0b, b_firstByte);

        MultiplierGF multiplier5(currentColumn[23:16], 8'h0e, e_secondByte);
        MultiplierGF multiplier6(currentColumn[23:16], 8'h09, nine_secondByte);
        MultiplierGF multiplier7(currentColumn[23:16], 8'h0d, d_secondByte);
        MultiplierGF multiplier8(currentColumn[23:16], 8'h0b, b_secondByte);

        MultiplierGF multiplier9(currentColumn[15:8], 8'h0e, e_thirdByte);
        MultiplierGF multiplier10(currentColumn[15:8], 8'h09, nine_thirdByte);
        MultiplierGF multiplier11(currentColumn[15:8], 8'h0d, d_thirdByte);
        MultiplierGF multiplier12(currentColumn[15:8], 8'h0b, b_thirdByte);

        MultiplierGF multiplier13(currentColumn[7:0], 8'h0e, e_fourthByte);
        MultiplierGF multiplier14(currentColumn[7:0], 8'h09, nine_fourthByte);
        MultiplierGF multiplier15(currentColumn[7:0], 8'h0d, d_fourthByte);
        MultiplierGF multiplier16(currentColumn[7:0], 8'h0b, b_fourthByte);




	

	assign newColumn[31:24] = e_firstByte ^ b_secondByte ^ d_thirdByte ^ nine_fourthByte;

	assign newColumn[23:16] = nine_firstByte ^ e_secondByte ^ b_thirdByte ^ d_fourthByte;

	assign newColumn[15:8] = d_firstByte ^ nine_secondByte ^ e_thirdByte ^ b_fourthByte;

	assign newColumn[7:0] = b_firstByte ^ d_secondByte ^ nine_thirdByte ^ e_fourthByte;

endmodule