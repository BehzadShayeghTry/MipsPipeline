module IFID(input clk, input [31:0] ins_in,
			output reg [31:0] ins_out);
	initial ins_out = 0;
	always @(posedge clk) begin
		ins_out <= ins_in;
	end
endmodule


