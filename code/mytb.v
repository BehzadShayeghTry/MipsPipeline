`timescale 1ns/1ns
module TB ();
	reg clk = 0;
	DataPath dp(clk);
	always #73 clk = ~clk;
	initial begin
		#10700 $stop;
	end
endmodule