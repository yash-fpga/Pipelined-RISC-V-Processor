module top_Pipelined_RISC(
    input clk,
    input reset,
    // output are being initiase only for debugging purpose
    output [31:0]current_pc,
    output [31:0]instruction,
    output [31:0] Alu_result

);
//IF stage ports
wire [31:0] next_pc;
wire [31:0]if_id_instruction;
wire [31:0]if_id_pc;

//ID stage ports
wire [6:0]opcode;
wire [4:0]rs2;
wire [4:0]rs1;
wire [4:0]rd;
wire [6:0]funct7;
wire [2:0]funct3;

wire [31:0]id_data1;
wire [31:0]id_data2;
wire [31:0]wd;
wire [31:0]immediate;

wire [31:0]id_ex_pc;
wire [31:0]id_ex_data1;
wire [31:0]id_ex_data2;
wire [31:0]id_ex_immediate;
wire [3:0]id_ex_ALU_Control ;
wire [4:0]id_ex_rd;
wire [4:0]id_ex_rs1;
wire [4:0]id_ex_rs2;
wire id_ex_RegWrite;
wire id_ex_AluSrc;
wire id_ex_Branch;
wire id_ex_memRead;
wire id_ex_memWrite;
wire id_ex_MemtoReg;

// EX STAGE ports
wire [31:0] alusrc_out;
wire zero;

wire [31:0]alu_in1;
wire [31:0] alu_temp_in2;
wire[31:0] ex_mem_Alu_result;
wire[31:0] ex_mem_data2;
wire[4:0] ex_mem_rd;
wire ex_mem_RegWrite;
wire ex_mem_memRead;
wire ex_mem_memWrite;
wire ex_mem_MemtoReg;

//MEM STAGE ports
wire [31:0] read_data;

wire[4:0] mem_wb_rd;
wire[31:0] mem_wb_Alu_result;
wire[31:0] mem_wb_data;
wire mem_wb_RegWrite;
wire mem_wb_MemtoReg;

// CONTROL SIGNALS

wire [3:0]ALU_Control;
wire RegWrite;
wire [1:0]AluOp;
wire AluSrc;
wire Branch;
wire memRead;
wire memWrite;
wire MemtoReg;

// BRANCHING UNIT
wire [31:0]pc_plus4;
wire [31:0] branch_target;
wire branch_taken;
wire flush;

// FORWARDING UNIT
wire [1:0]ForwardA;
wire [1:0]ForwardB;

//STALLING UNIT
wire if_id_write;
wire pc_write;
wire controlmux_sel;

assign funct7=if_id_instruction[31:25];
assign rs2=if_id_instruction[24:20];
assign rs1=if_id_instruction[19:15];
assign funct3=if_id_instruction[14:12];
assign rd=if_id_instruction[11:7];
assign opcode=if_id_instruction[6:0];

assign branch_taken=zero&&id_ex_Branch;
assign pc_plus4=current_pc+32'd4;
assign flush = branch_taken;
// IF stage

PC pc_inst(next_pc,reset,clk,pc_write,current_pc);
INSTRUCTION_MEMORY imem_inst(current_pc,instruction);
IF_ID_REGISTER ifid_inst(clk,reset,flush,current_pc,instruction,if_id_write,if_id_pc,if_id_instruction); // add reset here later

// ID stage
REGFILE regfile_inst(rs1,rs2,mem_wb_rd,mem_wb_RegWrite,clk,reset,wd,id_data1,id_data2);
MAIN_CONTROL mcu_inst(opcode,controlmux_sel,RegWrite,AluOp, AluSrc, Branch, memRead, memWrite, MemtoReg);
IMMGEN immg_inst(if_id_instruction,immediate);
ALU_CONTROL acu_inst(AluOp,opcode,funct7,funct3,ALU_Control);
ID_EX_REGISTER idex_inst(clk,reset,flush,if_id_pc,id_data1,id_data2,immediate,rd,rs1,rs2, RegWrite,ALU_Control, AluSrc, Branch, memRead, memWrite, MemtoReg,id_ex_pc,id_ex_data1,id_ex_data2,id_ex_immediate,id_ex_rd,id_ex_rs1,id_ex_rs2,id_ex_RegWrite,id_ex_ALU_Control,id_ex_AluSrc,id_ex_Branch,id_ex_memRead,id_ex_memWrite,id_ex_MemtoReg);

//EX stage 
ALU alu_inst(alu_in1,alusrc_out,id_ex_ALU_Control,zero,Alu_result);
MUX alusrc_mux(alu_temp_in2,id_ex_immediate,id_ex_AluSrc,alusrc_out);
EX_MEM_REGISTER exmem_inst(clk,reset,Alu_result,alu_temp_in2,id_ex_rd,id_ex_RegWrite,id_ex_memRead,id_ex_memWrite,id_ex_MemtoReg,ex_mem_Alu_result,ex_mem_data2,ex_mem_rd,ex_mem_RegWrite,ex_mem_memRead,ex_mem_memWrite,ex_mem_MemtoReg);

//MEM stage
DATA_MEMORY dm_inst(ex_mem_Alu_result,ex_mem_data2,clk,ex_mem_memRead,ex_mem_memWrite,read_data);
MEM_WB_REGISTER mweb_inst(clk,reset,ex_mem_rd,read_data,ex_mem_Alu_result,ex_mem_RegWrite,ex_mem_MemtoReg,mem_wb_rd,mem_wb_Alu_result,mem_wb_data,mem_wb_RegWrite,mem_wb_MemtoReg);
//WB stage
MUX memtoreg_mux(mem_wb_Alu_result,mem_wb_data,mem_wb_MemtoReg,wd);

//FORWARDING UNIT
FORWARDING_UNIT funit_inst(id_ex_rs1,id_ex_rs2,ex_mem_rd,mem_wb_rd,ex_mem_RegWrite,mem_wb_RegWrite,ForwardA,ForwardB);
FORWARDING_MUX frwd_mux1(id_ex_data1,ex_mem_Alu_result,wd,ForwardA,alu_in1);
FORWARDING_MUX frwd_mux2(id_ex_data2,ex_mem_Alu_result,wd,ForwardB,alu_temp_in2);

//STALLING UNIT
HAZARD_DETECTION_UNIT hdec_inst(rs1,rs2,id_ex_rd,id_ex_memRead,if_id_write,pc_write,controlmux_sel);

// BRANCHING UNIT
ADDER branch_adder(id_ex_pc,id_ex_immediate,branch_target);
MUX pcsrc_mux(pc_plus4,branch_target,branch_taken,next_pc);

endmodule