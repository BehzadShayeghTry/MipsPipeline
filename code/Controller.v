module Controller(input [5:0] opcode, func, input equal,
                output reg [2:0] aluSig, output reg WB, jumpSel, jumpCondSel, extendForMem, WMEM, load);

    initial {aluSig, WB, jumpSel, jumpCondSel, extendForMem, WMEM, load} = 9'b 0;

    always @(*) begin
        {aluSig, WB, jumpSel, jumpCondSel, extendForMem, WMEM, load} = 9'b 0;

        case (opcode)
            6'b 000000: begin
                WB = (func == 6'b 100000 | func == 6'b 100010 | func == 6'b 100100 | func == 6'b 100101 | func == 6'b 101010) ? 1 : 0;
                aluSig = (func == 6'b 100000) ? 0 :
                        (func == 6'b 100010) ? 1 :
                        (func == 6'b 100100) ? 2 :
                        (func == 6'b 100101) ? 3 :
                        (func == 6'b 101010) ? 4 : 0;
            end
            6'b 000010: begin
                jumpSel = 1;
            end
            6'b 000100: begin
                jumpCondSel = equal ? 1 : 0;
            end
            6'b 000101: begin
                jumpCondSel = equal ? 0 : 1;
            end
            6'b 100011: begin
                extendForMem = 1;
                load = 1;
                WB = 1;
            end
            6'b 101011: begin
                WMEM = 1;
                extendForMem = 1;
            end
            default : begin
                WB = 0;
                WMEM = 0; 
            end
        endcase
    end
endmodule