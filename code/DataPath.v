module DataPath(input cll);

///////////////////////////////////////////////////IF
    wire [4:0] pcInput, pcOutput;
    wire [31:0] instructionIF;
///////////////////////////////////////////////////ID
    wire WB_ID, writeEnable;
    wire [2:0] aluSigID;
    wire [4:0] writeRegPoint;
    wire [31:0] instructionID;
    wire [7:0] writeData, R1ID, R2ID;
///////////////////////////////////////////////////EX
    wire WB_EX;
    wire [2:0] aluSigEX;
    wire [4:0] rdEX;
    wire [7:0] R1EX, R2EX, resultEX;
///////////////////////////////////////////////////MM
    wire WB_MM;
    wire [4:0] rdMM;
    wire [7:0] resultMM;
///////////////////////////////////////////////////MM






///////////////////////////////////////////////////IF
    PC pc(clk, pcInput, pcOutput);
    Adder pcPluc(pcOutput, 1, pcInput);
    InstructionMemory im(pcOutput, instructionIF);

    IFID ifid(clk, instructionIF, instructionID);
///////////////////////////////////////////////////ID
    Controller clt(instructionID[31:26], instructionID[5:0], aluSigID, WB_ID);
    RegisterFile rf(clk, instructionID[25:21], instructionID[20:16], writeRegPoint, writeData, writeEnable, R1ID, R2ID);

    IDEX idex(clk, aluSigID, WB_ID, R1ID, R2ID, instructionID[15:11], aluSigEX, WB_EX, R1EX, R2EX, rdEX);
///////////////////////////////////////////////////EX
    ALU alu(R1EX, R2EX, aluSigEX, resultEX);

    MEMWB memwb(clk, WB_EX, resultEX, rdEX, WB_MM, resultMM, rdMM);
///////////////////////////////////////////////////MM
    //

    EXMEM exmem(clk, WB_MM, resultMM, rdMM, writeEnable, writeData, writeRegPoint);
///////////////////////////////////////////////////MM

endmodule