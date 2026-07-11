module EX_MEM_REGISTER(
    input clk,
    input reset,
    input [31:0]Alu_result,
    input [31:0]data2,
    input [4:0]rd,

    input RegWrite,
    input memRead,
    input memWrite,
    input MemtoReg,

    output reg [31:0] ex_mem_Alu_result,
    output reg [31:0] ex_mem_data2,
    output reg [4:0] ex_mem_rd,

    output reg ex_mem_RegWrite,
    output reg ex_mem_memRead,
    output reg ex_mem_memWrite,
    output reg ex_mem_MemtoReg

);
always @(posedge clk) begin
        if (reset)begin
        ex_mem_Alu_result <= 0;
        ex_mem_data2 <= 0;
        ex_mem_rd<= 0;

        ex_mem_RegWrite<= 0;
        ex_mem_memRead <= 0;
        ex_mem_memWrite <= 0;
        ex_mem_MemtoReg <= 0;
        end
        else begin
        ex_mem_Alu_result <= Alu_result;
        ex_mem_data2 <= data2;
        ex_mem_rd<= rd;

        ex_mem_RegWrite<= RegWrite;
        ex_mem_memRead <= memRead;
        ex_mem_memWrite <= memWrite;
        ex_mem_MemtoReg <= MemtoReg;
        end
end


    
endmodule