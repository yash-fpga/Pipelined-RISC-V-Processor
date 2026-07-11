    module tb_RISC();
    reg clk;
    reg reset;
    wire [31:0]current_pc;
    wire [31:0]instruction;
    wire [31:0] alu_result;

    top_Pipelined_RISC dut(.clk(clk),.reset(reset),.current_pc(current_pc),.instruction(instruction),.Alu_result(alu_result));

    always #5 clk= ~clk;

    initial begin
        $dumpfile("tb_RISC.vcd");
        $dumpvars(0,tb_RISC);
    end

    initial begin 
        dut.dm_inst.memory[25] = 32'd30;
        clk=0;
        reset=1;

        #10 reset=0;
        #200;


        for (integer i = 0;i<=31 ;i=i+1 ) begin
        $display("x%0d=%0d",i, dut.regfile_inst.registers[i]); 
        end

        $display("mem[100]=%0d",dut.dm_inst.memory[153]);
        $finish;
    end
        initial begin
        $monitor("t=%0t PC=%h Instr=%h ALU=%h",$time,current_pc,instruction,alu_result);
        
        end
    endmodule