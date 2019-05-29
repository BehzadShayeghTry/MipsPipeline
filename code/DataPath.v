module DataPath(input clk);

///////////////////////////////////////////////////IF
    wire [31:0] pcPlus, pcOutput, instructionIF, pcInput;
///////////////////////////////////////////////////ID
    wire WB_ID, writeEnable, jumpSel;
    wire [2:0] aluSigID;
    wire [4:0] writeRegPoint;
    wire [31:0] instructionID, pcID, pcJumped, pcJumpedCond, adrExtended, adrShifted;
    wire [7:0] writeData, R1ID, R2ID;
///////////////////////////////////////////////////EX
    wire WB_EX, MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2, jumpCondSel, equal;
    wire [2:0] aluSigEX;
    wire [4:0] rdEX, rsEX, rtEX;
    wire [7:0] R1EX, R2EX, resultEX, aluR1, aluR2;
///////////////////////////////////////////////////MM
    wire WB_MM;
    wire [4:0] rdMM;
    wire [7:0] resultMM;
///////////////////////////////////////////////////MM






///////////////////////////////////////////////////IF
    assign pcInput = jumpSel ? pcJumped : jumpCondSel ? pcJumpedCond : pcPlus;
    PC pc(clk, pcInput, pcOutput);
    Adder pcplus(pcOutput, 4, pcPlus);
    InsMemory im(pcOutput, instructionIF);

    IFID ifid(clk, instructionIF, pcPlus, instructionID, pcID);
///////////////////////////////////////////////////ID
    Controller clt(instructionID[31:26], instructionID[5:0], equal, aluSigID, WB_ID, jumpSel, jumpCondSel);
    RegisterFile rf(clk, instructionID[25:21], instructionID[20:16], writeRegPoint, writeData, writeEnable, R1ID, R2ID);
    Jumper jumper(pcID, instructionID[25:0], pcJumped);
    assign equal = (R1ID == R2ID);
    SignExtend se(instructionID[15:0], adrExtended);
    ShiftLeftII slii(adrExtended, adrShifted);
    Adder jcAdder(adrShifted, pcID, pcJumpedCond);

    IDEX idex(clk, aluSigID, WB_ID, R1ID, R2ID, instructionID[15:11], instructionID[25:21], instructionID[20:16],
        aluSigEX, WB_EX, R1EX, R2EX, rdEX, rsEX, rtEX);
///////////////////////////////////////////////////EX
    assign aluR1 = MM_sel_R1 ? resultMM : (IF_sel_R1) ? writeData : R1EX;
    assign aluR2 = MM_sel_R2 ? resultMM : (IF_sel_R2) ? writeData : R2EX;
    ALU alu(aluR1, aluR2, aluSigEX, resultEX);
    ForwardingUnit fu(rsEX, rtEX, rdMM, writeRegPoint, WB_MM, writeEnable, MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2);

    MEMWB memwb(clk, WB_EX, resultEX, rdEX, WB_MM, resultMM, rdMM);
///////////////////////////////////////////////////MM
    //

    EXMEM exmem(clk, WB_MM, resultMM, rdMM, writeEnable, writeData, writeRegPoint);
///////////////////////////////////////////////////MM

endmodule