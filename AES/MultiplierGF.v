//This module multiplies 2 numbers: inputNum and factor, in the field GF(2^8).
//The inputNum can only be multiplied by certain factors, which
//are the numbers used in the MixColumns procedure.

module MultiplierGF(input[7:0] inputNum, input[7:0] factor, 
						  output reg[7:0] result);
	
	wire[7:0] double;
	wire[7:0] fourTimes;
	wire[7:0] eightTimes;
	
	//Input is multiplied by 2.
	MultiplyBy2 multiplier1(inputNum, double);
	
	//Input is multiplied by 4.
	MultiplyBy2 multiplier2(double, fourTimes);
	
	//Input is multiplied by 8.
	MultiplyBy2 multiplier3(fourTimes, eightTimes);
	
	always @(*)
	begin: multiplier
		case (factor)
			8'h02: result = double;
			8'h03: result = double ^ inputNum; //3 = 2 XOR 1.
			8'h09: result = eightTimes ^ inputNum; //9 = 8 XOR 1
			8'h0b: result = eightTimes ^ double ^ inputNum; //11 = 8 XOR 2 XOR 1
			8'h0d: result = eightTimes ^ fourTimes ^ inputNum; //13 = 8 XOR 4 XOR 1
			8'h0e: result = eightTimes ^ fourTimes ^ double; //14 = 8 XOR 4 XOR 2
			default: result = 8'h00;
		endcase
	end
	
endmodule
