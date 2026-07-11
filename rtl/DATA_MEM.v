module DATA_MEMORY(
    input [31:0]address,
    input [31:0]wd,
    input clk,
    input memRead,
    input memWrite,
    output reg [31:0]read_data
);
    reg [31:0] memory[255:0];

    always@(*)begin
    if (memRead)read_data=memory[address>>2];
    else begin
        read_data=32'b0;
    end
    end

    always@(posedge clk)begin
        if (memWrite)begin
            memory[address>>2]<=wd;
        end
    end

endmodule