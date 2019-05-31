module HazzardUnit(input [4:0] rs_ID, rt_ID, rs_EX, input loadEx, output reg flush);
	initial flush = 0;
	always @(*) begin
		if(loadEx & (rs_ID == rs_EX | rt_ID == rs_EX)) flush = 1;
		else flush = 0;
	end
endmodule