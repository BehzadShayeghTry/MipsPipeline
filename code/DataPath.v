module DataPath(input clk);

///////////////////////////////////////////////////IF
    wire [31:0] pcPlus, pcOutput, insIF, pcInput;
///////////////////////////////////////////////////ID
    wire WB_ID, writeEnable, jumpSel, extendForMemID, WMEM_ID, loadID, flush;
    wire [2:0] aluSigID;
    wire [4:0] writeRegPoint;
    wire [31:0] insID, pcID, pcJumped, pcJumpedCond, adrExtended, adrShifted, writeData, R1ID, R2ID, R1ofRf;
///////////////////////////////////////////////////EX
    wire WB_EX, MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2, jumpCondSel, equal, WMEM_EX, loadEX, extendForMemEX;
    wire [2:0] aluSigEX;
    wire [4:0] rdEX, rsEX, rtEX, writeRegEX;
    wire [31:0] R1EX, R2EX, resultEX, aluR1, aluR2, wdMemEx, pureRs;
///////////////////////////////////////////////////MM
    wire WB_MM, WMEM_MM, loadMM;
    wire [4:0] writeRegMM;
    wire [31:0] resultMM, resultMemoryMM, writeDataMem;
///////////////////////////////////////////////////WB
    wire load;
    wire [31:0] resultMemoryWB, resultWB;





///////////////////////////////////////////////////IF
    assign pcInput = jumpSel ? pcJumped : jumpCondSel ? pcJumpedCond : pcPlus;
    PC pc(clk, pcInput, pcOutput, flush);
    Adder pcplus(pcOutput, 4, pcPlus);
    InsMemory im(pcOutput, insIF);

    IFID ifid(clk, insIF, pcPlus, insID, pcID, flush);
///////////////////////////////////////////////////ID
    Controller clt(insID[31:26], insID[5:0], equal, aluSigID, WB_ID, jumpSel, jumpCondSel, extendForMemID, WMEM_ID, loadID);
    RegisterFile rf(clk, insID[25:21], insID[20:16], writeRegPoint, writeData, writeEnable, R1ofRf, R2ID);
    Jumper jumper(pcID, insID[25:0], pcJumped);
    assign equal = (R1ID == R2ID);
    SignExtend se(insID[15:0], adrExtended);
    ShiftLeftII slii(adrExtended, adrShifted);
    Adder jcAdder(adrShifted, pcID, pcJumpedCond);
    assign R1ID = extendForMemID ? adrExtended : R1ofRf;
    HazzardUnit hu(insID[25:21], insID[20:16], rsEX, loadEX, flush);

    IDEX idex(clk, aluSigID, WB_ID, extendForMemID, WMEM_ID, loadID, R1ID, R2ID, R1ofRf, insID[15:11], insID[25:21], insID[20:16],
        aluSigEX, WB_EX, extendForMemEX, WMEM_EX, loadEX, R1EX, R2EX, pureRs, rdEX, rsEX, rtEX, flush);
///////////////////////////////////////////////////EX
    assign aluR1 = extendForMemEX ? R1EX : MM_sel_R1 ? resultMM : IF_sel_R1 ? writeData : R1EX;
    assign aluR2 = MM_sel_R2 ? resultMM : IF_sel_R2 ? writeData : R2EX;
    ALU alu(aluR1, aluR2, aluSigEX, resultEX);
    ForwardingUnit fu(rsEX, rtEX, writeRegMM, writeRegPoint, WB_MM, writeEnable, MM_sel_R1, MM_sel_R2, IF_sel_R1, IF_sel_R2);
    assign writeRegEX = extendForMemEX ? rsEX : rdEX;
    assign  wdMemEx = MM_sel_R1 ? resultMM : IF_sel_R1 ? writeData : pureRs;
    
    MEMWB memwb(clk, WB_EX, WMEM_EX, loadEX, resultEX, wdMemEx, writeRegEX, WB_MM, WMEM_MM, loadMM, resultMM, writeDataMem, writeRegMM);
///////////////////////////////////////////////////MM
    DataMemory dm(resultMM, writeDataMem, WMEM_MM, resultMemoryMM);

    EXMEM exmem(clk, WB_MM, loadMM, resultMM, resultMemoryMM, writeRegMM, writeEnable, load, resultWB, resultMemoryWB, writeRegPoint);
///////////////////////////////////////////////////WB
    assign writeData = load ? resultMemoryWB : resultWB;

endmodule