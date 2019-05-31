module DataMemory(input [31:0] Rpoint, input [31:0] writeData, input write, output reg[31:0] outR);
    reg [31:0] Registers [0:1023];
    initial begin
    	// Registers[7] = 54;
    	Registers[0] = 12;
    	Registers[1] = 21;
    end
    always@(*) begin
        outR = Registers[Rpoint];
        if (write) Registers[Rpoint] = writeData;
    end
endmodule
