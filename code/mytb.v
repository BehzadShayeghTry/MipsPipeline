`timescale 1ns/1ns
module TB ();
	reg clk = 0;
	CA_CA3 ca(clk);
	always #73 clk = ~clk;
	initial begin
		#10700 $stop;
	end
endmodule