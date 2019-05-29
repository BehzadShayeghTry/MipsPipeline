module Controller(input [5:0] opcode, func,
                output reg [2:0] aluSig, output reg WB);

    initial {aluSig, WB} = 4'b 0;

    always @(*) begin
        {aluSig, WB} = 4'b 0;

        case (opcode)
            6'b 000000: begin
                WB = 1;
                aluSig = (func == 6'b 100000) ? 0 :
                        (func == 6'b 100010) ? 1 :
                        (func == 6'b 100100) ? 2 :
                        (func == 6'b 100101) ? 3 :
                        (func == 6'b 101010) ? 4 : 0;
            end
            default :
                WB = 0;
        endcase
    end
endmodule