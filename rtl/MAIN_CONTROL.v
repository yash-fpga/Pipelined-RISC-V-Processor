module MAIN_CONTROL(
    input [6:0]opcode,
    input controlmux_sel,
    output reg RegWrite,
    output reg [1:0]AluOp,
    output reg AluSrc,
    output reg Branch,
    output reg memRead,
    output reg memWrite,
    output reg MemtoReg
);

    always@(*) begin
    if(controlmux_sel) begin
    RegWrite = 1'b0;AluSrc= 1'b0;AluOp= 2'b00;memWrite=1'b0;memRead=1'b0;MemtoReg=1'b0;Branch= 1'b0;
    end
    else begin
    case (opcode)
    7'b0110011:begin
    RegWrite=1'b1;AluSrc=1'b0;AluOp=2'b10;memWrite=1'b0;memRead=1'b0;MemtoReg=1'b0;Branch=1'b0;
    end
    7'b0010011:begin
    RegWrite=1'b1;AluSrc=1'b1;AluOp=2'b10;memWrite=1'b0;memRead=1'b0;MemtoReg=1'b0;Branch=1'b0;
    end
    7'b0000011:begin
    RegWrite=1'b1;AluSrc=1'b1;AluOp=2'b00;memWrite=1'b0;memRead=1'b1;MemtoReg=1'b1;Branch=1'b0;
    end
    7'b0100011:begin
    RegWrite=1'b0;AluSrc=1'b1;AluOp=2'b00;memWrite=1'b1;memRead=1'b0;MemtoReg=1'bx;Branch=1'b0;
    end
    7'b1100011: begin
    RegWrite=1'b0;AluSrc=1'b0;AluOp=2'b01;memWrite=1'b0;memRead=1'b0;MemtoReg=1'bx;Branch=1'b1;
    end
    default:begin
    RegWrite = 1'b0;AluSrc= 1'b0;AluOp= 2'b00;memWrite=1'b0;memRead=1'b0;MemtoReg=1'b0;Branch= 1'b0;
    end
    endcase
    end
end
endmodule