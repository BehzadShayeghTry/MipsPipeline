module MEMWB(input clk, input WB_in, WMEM_in, load_in, input [31:0] result_in, wdMem_in, input [4:0] rd_in,
			output reg WB_out, WMEM_out, load_out, output reg [31:0] result_out, wdMem_out, output reg [4:0] rd_out);
	initial {WB_out, result_out, rd_out, WMEM_out, load_out, wdMem_out} = 72'b 0;
	always @(posedge clk) begin
		WB_out = WB_in;
		result_out = result_in;
		rd_out = rd_in;
		WMEM_out = WMEM_in;
		load_out = load_in;
		wdMem_out = wdMem_in;
	end
endmodule