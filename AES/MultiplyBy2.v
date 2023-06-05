//Takes in an input byte and multiplies it by 2 in the field GF(2^8).
//This is equivalent to polynomial multiplication, then taking the
//remainder upon division by x^8+x^4+x^3+x+1, where the coefficients
//belong to GF(2).

module MultiplyBy2(input[7:0] inputByte, output[7:0] outputByte);
	
	wire[7:0] shiftedInput;
	wire[7:0] subtractedValue;
	
	assign subtractedValue = (inputByte[7] == 1'b1)?8'b100011011:8'b00000000;
	assign shiftedInput = inputByte << 1;
	assign outputByte = shiftedInput ^ subtractedValue;
	
endmodule
