module EXMEM(input clk, input WB_in, load_in, input [31:0] result_in, resM_in, input [4:0] rd_in,
			output reg WB_out, load_out, output reg [31:0] result_out, resM_out, output reg [4:0] rd_out);
	initial {WB_out, result_out, rd_out, resM_out, load_out} = 71'b 0;
	always @(posedge clk) begin
		WB_out = WB_in;
		result_out = result_in;
		rd_out = rd_in;
		resM_out = resM_in;
		load_out = load_in;
	end
endmodule
