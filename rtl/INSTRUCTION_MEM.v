module INSTRUCTION_MEMORY(
    input [31:0]address,
    output [31:0]instruction
);
    reg [31:0] memory[255:0];
    initial begin
        $readmemh("program.mem",memory);
    end



    assign instruction = memory[address>>2];
endmodule