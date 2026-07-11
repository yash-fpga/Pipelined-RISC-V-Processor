    module FORWARDING_UNIT (
        input [4:0]id_ex_rs1,
        input [4:0]id_ex_rs2,
        input [4:0]ex_mem_rd,
        input [4:0]mem_wb_rd,
        input ex_mem_RegWrite,
        input mem_wb_RegWrite,
        output reg [1:0]ForwardA,
        output reg [1:0]ForwardB
    );
        always@(*)begin
            ForwardA=2'b00;
            ForwardB=2'b00;

    if (ex_mem_RegWrite==1 && ex_mem_rd!=0 && id_ex_rs1==ex_mem_rd) 
        ForwardA=2'b01;

    else if (mem_wb_RegWrite==1 && mem_wb_rd!=0 && id_ex_rs1==mem_wb_rd)
        ForwardA=2'b10;
    if (ex_mem_RegWrite==1 && ex_mem_rd!=0 && id_ex_rs2==ex_mem_rd) 
        ForwardB=2'b01;

    else if (mem_wb_RegWrite==1 && mem_wb_rd!=0 && id_ex_rs2==mem_wb_rd)
        ForwardB=2'b10;
        end
    endmodule