module InsMemory(input [31:0] adress, output reg[31:0] outIns);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    `define NULL 0
    
    reg [31:0] instractions [0:31];

    initial begin
      data_file = $fopen("./instructions.txt", "r");
      if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
      end
    end

    integer i;
    initial begin
      for (i=0; i<32; i=i+1) begin
        scan_file = $fscanf(data_file, "%b\n", instractions[i]); 
      end
    end

    always @(*) begin
      outIns = instractions[adress/4];
    end
    
endmodule