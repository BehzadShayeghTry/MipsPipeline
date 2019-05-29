module PC(input clk, input [31:0] in, output reg [31:0] out);
	initial out = 0;
	always @(posedge clk) begin
		out <= in;
	end
endmodule


