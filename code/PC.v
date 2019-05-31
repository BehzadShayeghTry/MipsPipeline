module PC(input clk, input [31:0] in, output reg [31:0] out, input flush);
	initial out = 0;
	always @(posedge clk) begin
		if(!flush) out <= in;
	end
endmodule


