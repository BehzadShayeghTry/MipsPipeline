module IFID(input clk, input [31:0] ins_in, input[31:0] pc_in,
			output reg [31:0] ins_out, output reg [31:0] pc_out);
	initial {ins_out, pc_out} = 2'b 0;
	always @(posedge clk) begin
		ins_out = ins_in;
		pc_out = pc_in;
	end
endmodule