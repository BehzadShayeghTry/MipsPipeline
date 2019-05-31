module IDEX(input clk, input [2:0] aluSig_in, input WB_in, extendForMem_in, WMEM_in, load_in,
			input [31:0] R1_in, R2_in, wdMem_in,
			input [4:0] rd_in, rs_in, rt_in,
			output reg [2:0] aluSig_out,
			output reg WB_out, extendForMem_out, WMEM_out, load_out,
			output reg [31:0] R1_out, R2_out, wdMem_out,
			output reg [4:0] rd_out, rs_out, rt_out,
			input flush);

	initial {aluSig_out, WB_out, R1_out, R2_out, rd_out, rs_out, rt_out, extendForMem_out, WMEM_out, load_out, wdMem_out} = 118'b 0;
	always @(posedge clk) begin
		aluSig_out = aluSig_in;
		WB_out = WB_in;
		R1_out = R1_in;
		R2_out = R2_in;
		rd_out = rd_in;
		rs_out = rs_in;
		rt_out = rt_in;
		extendForMem_out = extendForMem_in;
		WMEM_out = WMEM_in;
		load_out = load_in;
		wdMem_out = wdMem_in;
		if(flush) begin
			WMEM_out = 0;
			WB_out = 0;
		end
	end
endmodule