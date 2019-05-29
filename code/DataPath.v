module DataPath(input clk, winUpdate,
                input selImm, selMemOut, beq, jump,
                input writeFR, writeDM, readDM,
                output [3:0] opcode);
    wire [9:0] pcInput, pcOutput, pcPlus, jumpTarget;
    wire [15:0] instructionOutput, rfWriteData, RiOutput, RjOutput, aluOutput, exOutput, aluInputi, dmOutput;
    wire [2:0] aluSignal;
    wire zero, beqEn;

    PC pc(clk, pcInput, pcOutput);
    InstructionMemory im(pcOutput, instructionOutput);
    assign pcPlus = pcOutput + 1;
    RegisterFile rf(clk, rfWriteData, writeFR, RiOutput, RjOutput, instructionOutput, winUpdate);
    DataMemory dm(instructionOutput[9:0], RiOutput, writeDM, readDM, dmOutput);
    assign rfWriteData = selMemOut ? dmOutput : aluOutput;
    assign exOutput = {8'b0, instructionOutput[7:0]};
    ALUController ac(instructionOutput[7:0], instructionOutput[15:12], aluSignal);
    assign aluInputi = selImm ? exOutput : RiOutput;
    ALU alu(aluInputi, RjOutput, aluSignal, aluOutput, zero);
    assign beqEn = beq & zero;
    assign jumpEn = jump | beqEn;
    assign jumpTarget = jump ? instructionOutput[9:0] : {pcPlus[9:8], instructionOutput[7:0]};
    assign pcInput = jumpEn ? jumpTarget : pcPlus;
    assign opcode = instructionOutput[15:12];

endmodule