module Controller(input [3:0] opcode, input clk,
                output reg selImm, selMemOut, beq, jump, winUpdate,
                output reg writeFR, writeDM, readDM);
    initial {selImm, selMemOut, beq, jump, writeFR, writeDM, readDM, winUpdate} = 8'b 0;

    always @(opcode) begin
        {selImm, selMemOut, beq, jump, writeFR, writeDM, readDM, winUpdate} = 8'b 0;

        case (opcode)
            4'b 0000: begin
                readDM = 1;
                selMemOut = 1;
                writeFR = 1;
            end
            4'b 0001: begin
                writeDM = 1;
            end
            4'b 0010: begin
                jump = 1;
            end
            4'b 0100: begin
                beq = 1;
            end
            4'b 1000: begin
                writeFR = 1;
                winUpdate = 1;
            end
            default: begin
                selImm = 1;
                writeFR = 1;
            end
        endcase
    end
endmodule