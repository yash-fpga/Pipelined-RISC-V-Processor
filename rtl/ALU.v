module ALU(
    input [31:0]in_1,
    input [31:0]in_2,
    input [3:0]ALUControl,
    output zero,
    output reg [31:0]result
);

    always@(*)begin
        case (ALUControl)
        4'b0000: result = in_1&in_2;
        4'b0001: result = in_1|in_2;
        4'b0010: result = in_1+in_2;
        4'b0110: result = in_1-in_2;
        4'b0111: result = (in_1<in_2)? 32'b1 : 32'b0;
        4'b1100: result = ~(in_1|in_2);
            default: result = 32'b0;
        endcase
    end
    assign zero = (result == 32'b0);
endmodule
