module IDEX(input clk, input [2:0] aluSig_in, input WB_in, input [7:0] R1_in, R2_in, input [4:0] rd_in, rs_in, rt_in,
			output reg [2:0] aluSig_out, output reg WB_out, output reg [7:0] R1_out, R2_out, output reg [4:0] rd_out, rs_out, rt_out);
	initial {aluSig_out, WB_out, R1_out, R2_out, rd_out, rs_out, rt_out} = 35'b 0;
	always @(posedge clk) begin
		aluSig_out = aluSig_in;
		WB_out = WB_in;
		R1_out = R1_in;
		R2_out = R2_in;
		rd_out = rd_in;
		rs_out = rs_in;
		rt_out = rt_in;
	end
endmodule