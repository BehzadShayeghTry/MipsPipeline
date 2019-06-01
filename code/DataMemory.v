module DataMemory(input [31:0] Rpoint, input [31:0] writeData, input write, output reg[31:0] outR);
    reg [31:0] Registers [0:1023];
    
    integer i;
    initial begin
        for (i=0; i<1023; i=i+1) begin
            Registers[i] = i;
        end
    // initial begin
    	// Registers[7] = 54;
    // 	// Registers[999] = 5;
    // 	// Registers[1000] = 3;
    // 	// Registers[1001] = 5;
    // 	// Registers[1002] = 8;
    // 	// Registers[1003] = 7;
    // 	// Registers[1004] = 6;
        Registers[0] = 1;
        Registers[4] = -2;
        Registers[8] = 4;
    end
    always@(*) begin
        outR = Registers[Rpoint];
        if (write) Registers[Rpoint] = writeData;
    end
endmodule
