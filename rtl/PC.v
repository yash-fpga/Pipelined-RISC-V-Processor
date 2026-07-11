module PC(
    input [31:0]next_pc,
    input reset,
    input clk,
    input pc_write,
    output reg [31:0]current_pc
);
    always @(posedge clk)begin
    if (reset)begin
        current_pc<=0;
    end
    else if (pc_write)begin
        current_pc<=next_pc;
    end
    end
endmodule