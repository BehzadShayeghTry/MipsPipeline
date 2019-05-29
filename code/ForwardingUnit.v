module ForwardingUnit(input [4:0] rs_Ex, rt_Ex, rd_MM, rd_IF, input WB_MM, WB_IF,
					output reg MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2);
	initial {MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2} = 4'b 0;
	always @(*) begin
		MM_sel_R1 = (rs_Ex == rd_MM) & WB_MM;
		MM_sel_R2 = (rt_Ex == rd_MM) & WB_MM;
		IF_sel_R1 = (rs_Ex == rd_IF) & WB_IF;
		IF_sel_R2 = (rt_Ex == rd_IF) & WB_IF;
	end
endmodule