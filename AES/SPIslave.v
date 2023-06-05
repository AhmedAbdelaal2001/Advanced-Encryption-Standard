module SPIslave(input clk, input reset,
				  input mosi, input cs, input[127:0] dataFromModule,
				  output reg miso, output reg[127:0] dataToModule);
	
	reg[8:0] counter;
	reg[1:0] state;
	reg round;
	
	parameter IDLE=0;
	parameter RECEIVEDATA = 1;
	parameter SENDDATA = 2;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
				state = IDLE;
				counter = 0;
				round = 0;
		end
		else begin
			case(state)
				IDLE: begin
					counter = 0;
					if (cs == 0)
						if (round == 0)
							state = RECEIVEDATA;
						else if (round == 1)
							state = SENDDATA;
					else
						state = IDLE;
				end
				
				RECEIVEDATA: begin
					if (counter < 128) begin
						dataToModule[counter] = mosi;
						counter = counter + 1;
						state = RECEIVEDATA;
					end
					else begin
						state = IDLE;
						round = 1;
					end
				end
				
				SENDDATA: begin
					if (counter < 128) begin
						counter = counter + 1;
						state = SENDDATA;
					end
					else begin
						state = IDLE;
						round = 2;
					end
				end
			endcase
		end
	end
	
	always @(negedge clk) begin
		
		case (state)
			IDLE: miso = 1'bz;
			RECEIVEDATA: miso = 0;
			SENDDATA: miso = dataFromModule[counter - 1];
		endcase
	end
	
endmodule
