module Jumper(input [31:0] pc, input [25:0] adress, output [31:0] pc_out);
    assign pc_out = {pc[31:28], adress};
endmodule