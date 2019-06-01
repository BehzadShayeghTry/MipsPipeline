module IFID(input clk, input [31:0] ins_in, input[31:0] pc_in,
			output reg [31:0] ins_out, output reg [31:0] pc_out, input flush, jump);
	initial {ins_out, pc_out} = 33'b 0;
	always @(posedge clk) begin
		if(!flush) begin
			ins_out = ins_in;
			pc_out = pc_in;
		end
		if(jump) ins_out = 0;
	end
endmodule