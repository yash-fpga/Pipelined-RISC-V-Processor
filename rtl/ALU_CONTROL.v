module ALU_CONTROL(
    input [1:0]ALUOp,
    input [6:0]opcode,
    input [6:0]funct7,
    input [2:0]funct3,
    output reg [3:0]ALU_Control
);

always@(*)begin
    case (ALUOp)
        2'b00: ALU_Control=4'b0010; 
        2'b01: ALU_Control=4'b0110; 

        2'b10:begin
            case (funct3)

            3'b000: begin
                if (opcode==7'b0110011 && funct7==7'b0100000)
                    ALU_Control=4'b0110; 
                else ALU_Control=4'b0010; 
                end

                3'b111: ALU_Control=4'b0000;
                3'b110: ALU_Control=4'b0001;

                default: ALU_Control=4'bxxxx;
            endcase
        end

        default: ALU_Control=4'bxxxx;
    endcase
end

endmodule