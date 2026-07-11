module IF_ID_REGISTER(
    input clk,
    input reset,
    input flush,
    input [31:0]current_pc,
    input [31:0]instruction,
    input if_id_write,
    output reg [31:0]if_id_pc,
    output reg [31:0]if_id_instruction
);

    always@(posedge clk)begin
        if (reset||flush)begin
        if_id_instruction<=32'b0;
        if_id_pc<=32'b0;
        end
        else if (if_id_write)begin
        if_id_instruction<=instruction;
        if_id_pc<=current_pc;
        end
    end    
endmodule