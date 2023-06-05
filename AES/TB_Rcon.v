module TB_Rcon();
	wire[31:0] power;
	Rcon testUnit(59/8, power);
	
	initial begin
		#100;
	end
	
endmodule
