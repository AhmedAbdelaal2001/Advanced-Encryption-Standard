module Rcon(input[7:0] index, output reg[31:0] power);
	
	always @(*)
	begin: calcPower
		case(index)
			8'h01: power = 32'h01000000;
			8'h02: power = 32'h02000000;
			8'h03: power = 32'h04000000;
			8'h04: power = 32'h08000000;
			8'h05: power = 32'h10000000;
			8'h06: power = 32'h20000000;
			8'h07: power = 32'h40000000;
			8'h08: power = 32'h80000000;
			8'h09: power = 32'h1b000000;
			8'h0a: power = 32'h36000000;
			default: power = 8'h00;
		endcase
	end
endmodule
