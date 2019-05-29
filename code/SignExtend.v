module SignExtend(input [15:0] in, output [31:0] out);
	assign out = {8'b0, in[7:0]};
endmodule