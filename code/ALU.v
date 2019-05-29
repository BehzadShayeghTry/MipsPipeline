module ALU(input [15:0] R1, R2, input [2:0] controlSignal, output reg[15:0] out);
  always @(*) begin
    case (controlSignal)
    	0: out = R1 + R2;
    	1: out = R1 - R2;
    	2: out = R1 & R2;
        3: out = R1 | R2;
    	4: out = R1 < R2;
    	default: out = R1;
    endcase
  end
endmodule