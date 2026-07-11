module HAZARD_DETECTION_UNIT(
    input [4:0]if_id_rs1,
    input [4:0]if_id_rs2,
    input [4:0]id_ex_rd,
    input id_ex_memRead,
    output reg if_id_write,
    output reg pc_write,
    output reg controlmux_sel
);
always @(*) begin
        if_id_write=1;
        pc_write=1;
        controlmux_sel=0;

    if (id_ex_memRead&&id_ex_rd!=0 &&((if_id_rs1==id_ex_rd) || (if_id_rs2 == id_ex_rd))) begin
            if_id_write=0;
            pc_write=0;
            controlmux_sel=1;
        end
    end
endmodule