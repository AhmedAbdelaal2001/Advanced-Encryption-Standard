module Rotate #(parameter n = 8) ( input [31:0] input_word,output [31:0] output_word);

 assign output_word = {input_word[n-1:0], input_word[31:n]};


endmodule