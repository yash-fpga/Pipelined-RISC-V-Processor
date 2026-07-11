module REGFILE(
    input [4:0]rs1,
    input [4:0]rs2,
    input [4:0]rd,
    input RegWrite,
    input clk,
    input reset,
    input [31:0] wd,
    output [31:0] data1,
    output [31:0] data2
);
reg [31:0] registers [31:0];
integer i;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        for(i=0;i<32;i=i+1)
            registers[i] <= 0;
    end
    else begin
        registers[0] <= 0;
        if(RegWrite && rd!=0)
            registers[rd] <= wd;
    end
end


// Replace the two assign statements with:
assign data1 = (RegWrite && rd != 0 && rd == rs1) ? wd : registers[rs1];
assign data2 = (RegWrite && rd != 0 && rd == rs2) ? wd : registers[rs2];


endmodule