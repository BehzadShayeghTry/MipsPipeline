module EXMEM(input clk, input WB_in, input [7:0] result_in, input [4:0] rd_in,
			output reg WB_out, output reg [7:0] result_out, output reg [4:0] rd_out);
	initial {WB_out, result_out, rd_out} = 14'b 0;
	always @(posedge clk) begin
		WB_out = WB_in;
		result_out = result_in;
		rd_out = rd_in;
	end
endmodule