module ID_EX_REGISTER(
    input clk,
    input reset,
    input flush,
    input [31:0]current_pc,
    input [31:0]data1,
    input [31:0]data2,
    input [31:0] immediate,
    input [4:0]rd,
    input [4:0]rs1,
    input [4:0]rs2,

    input RegWrite,
    input [3:0]ALU_Control,
    input AluSrc,
    input Branch,
    input memRead,
    input memWrite,
    input MemtoReg,  

    output reg [31:0]id_ex_current_pc,
    output reg [31:0]id_ex_data1,
    output reg [31:0]id_ex_data2,
    output reg [31:0]id_ex_immediate,
    output reg [4:0]id_ex_rd,
    output reg [4:0]id_ex_rs1,
    output reg [4:0]id_ex_rs2,

    output reg id_ex_RegWrite,
    output reg [3:0]id_ex_ALU_Control,
    output reg id_ex_AluSrc,
    output reg id_ex_Branch,
    output reg id_ex_memRead,
    output reg id_ex_memWrite,
    output reg id_ex_MemtoReg
);

    always@(posedge clk)begin
        if (reset||flush)begin
        id_ex_current_pc   <= 0;
        id_ex_data1        <= 0;
        id_ex_data2        <= 0;
        id_ex_immediate    <= 0;

        id_ex_rd           <= 0;
        id_ex_rs1          <= 0;
        id_ex_rs2          <= 0;

        id_ex_RegWrite     <= 0;
        id_ex_ALU_Control  <= 0;
        id_ex_AluSrc       <= 0;
        id_ex_Branch       <= 0;
        id_ex_memRead      <= 0;
        id_ex_memWrite     <= 0;
        id_ex_MemtoReg     <= 0;
        end

        else begin
        id_ex_current_pc   <= current_pc;
        id_ex_data1        <= data1;
        id_ex_data2        <= data2;
        id_ex_immediate    <= immediate;

        id_ex_rd           <= rd;
        id_ex_rs1          <= rs1;
        id_ex_rs2          <= rs2;

        id_ex_RegWrite     <= RegWrite;
        id_ex_ALU_Control  <= ALU_Control;
        id_ex_AluSrc       <= AluSrc;
        id_ex_Branch       <= Branch;
        id_ex_memRead      <= memRead;
        id_ex_memWrite     <= memWrite;
        id_ex_MemtoReg     <= MemtoReg;
        end
    end    
endmodule