module SPIslave_key(input[7:0]Nk, input clk, input reset,
				  input mosi, input cs,
				  output reg miso, output reg[255:0] key);
	
	reg[8:0] counter;
	reg state;
	
	parameter IDLE=0;
	parameter RECEIVEKEY = 1;
	
	wire[8:0] keySize;
	assign keySize = (Nk == 8'b00001000) ? 256:((Nk == 8'b00000110) ? 196:128);
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
				state = IDLE;
				counter = 0;
		end
		else begin
			case(state)
				IDLE: begin
					if (cs == 0)
						state = RECEIVEKEY;
					else
						state = IDLE;
				end
				
				RECEIVEKEY: begin
					if (counter < keySize) begin
						key[counter] = mosi;
						counter = counter + 1;
						state = RECEIVEKEY;
					end
					else
						state = IDLE;
				end
			endcase
		end
	end
	
	always @(negedge clk) begin
		case(state)
			IDLE: miso = 1'bz;
			RECEIVEKEY: miso = 0;
		endcase
	end
	
endmodule
