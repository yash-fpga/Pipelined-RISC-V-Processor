module MEM_WB_REGISTER(
    input clk,
    input reset,
    input [4:0] rd,
    input [31:0]data,
    input [31:0]Alu_result,

    input RegWrite,
    input MemtoReg,

    output reg [4:0] mem_wb_rd,
    output reg [31:0] mem_wb_Alu_result,
    output reg [31:0] mem_wb_data,

    output reg mem_wb_RegWrite,
    output reg mem_wb_MemtoReg
);

    always @(posedge clk) begin
        if (reset)begin
        mem_wb_rd <= 0;
        mem_wb_Alu_result <= 0;
        mem_wb_data <= 0;
        mem_wb_RegWrite <= 0;
        mem_wb_MemtoReg <= 0;
        end
        else begin
        mem_wb_rd <= rd;
        mem_wb_Alu_result <= Alu_result;
        mem_wb_data <= data;
        mem_wb_RegWrite <= RegWrite;
        mem_wb_MemtoReg <= MemtoReg;
        end
    end

endmodule