module DataMemory(input [9:0] Rpoint, input [15:0] writeData, input write, read, output reg[15:0] outR);
    reg [15:0] Registers [0:1023];
    always@(*) begin
        if (write) Registers[Rpoint] = writeData;
        if (read) outR = Registers[Rpoint];
    end
endmodule
