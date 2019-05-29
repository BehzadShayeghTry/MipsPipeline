module PC(input clk, input [4:0] in,output reg [4:0] out);
	initial out = 0;
	always @(posedge clk) begin
		out <= in;
	end
endmodule


