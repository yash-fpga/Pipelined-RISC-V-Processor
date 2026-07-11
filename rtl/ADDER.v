module ADDER(
    input [31:0]pc,
    input [31:0]in,
    output [31:0]next_pc
);
    assign next_pc=pc+in;
endmodule