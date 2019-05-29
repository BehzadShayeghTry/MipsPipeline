module RegisterFile(input clk, input [4:0] R1point, R2point, writeRpoint, input [7:0] writeData, input writeEnable, output reg[7:0] R1, R2);
    reg [7:0] Registers [0:32];

    integer i;
    initial begin
        for (i=0; i<32; i=i+1) begin
            Registers[i] = 8'b 0;
        end
    end

    always @(*) begin
        Registers[0] = 3;
		Registers[1] = 5;
		R1 = Registers[R1point];
		R2 = Registers[R2point];
    end

    always @(negedge clk)
		if (writeEnable) Registers[writeRpoint] = writeData;

endmodule