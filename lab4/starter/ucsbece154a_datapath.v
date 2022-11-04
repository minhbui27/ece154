// ucsbece154a_datapath.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement datapath
module ucsbece154a_datapath (
    input              clk,
    reset,
    //rf
    input              RegWrite_i,
    //rf
    input              RegDst_i,
    //mux for SrcB going to ALU
    input              ALUSrc_i,
    //for PCSrc
    input              Branch_i,
    //rf
    input              MemToReg_i,
    //alu
    input       [ 2:0] ALUControl_i,
    //for pc_o
    input              Jump_i,
    //For ori
    input              BranchZero_i,
    //For bne
    input              ZeroExtImm_i,
    output reg  [31:0] pc_o,
    input       [31:0] instr_i,
    //output of the alu
    output wire [31:0] aluout_o,
    //WD for data memory
    writedata_o,
    //comes from dmem
    input       [31:0] readdata_i
);

  `include "ucsbece154a_defines.vh"

  // **PUT YOUR CODE HERE**

  //Declaring wires to connect between rf and alu.
  wire [31:0] Rd1, Rd2, PCBranch, PCPlus4;
  wire [27:0] JumpShift;
  wire AluZero;
  //JumpShift is immediate multiplied by 4 for j
  assign JumpShift = instr_i[27:0] << 2;
  //This is PCJump in the graph
  assign PCPlus4 = pc_o + 4;
  assign PCBranch = (({{16{instr_i[15]}}, instr_i[15:0]}) << 2) + PCPlus4;
  assign writedata_o = Rd2;
  always @(posedge clk) begin
    if (reset) pc_o <= 0;
	//if j instruction, pc_next = 4 bits from PCPlus4 and the sll 2 28-bit
	//immediate
    else if (Jump_i) pc_o <= {{PCPlus4[31:28]}, {JumpShift}};
    else begin
      if ((!BranchZero_i & (Branch_i & AluZero)) || (BranchZero_i & !AluZero)) pc_o <= PCBranch;
      else pc_o <= PCPlus4;
    end
  end
  ucsbece154a_rf rf (
      /*FILL*/
      .clk  (clk),
      .a1_i (instr_i[25:21]),
      .a2_i (instr_i[20:16]),
      .a3_i (RegDst_i ? instr_i[15:11] : instr_i[20:16]),
      .rd1_o(Rd1),
      .rd2_o(Rd2),
      .we3_i(RegWrite_i),
      .wd3_i(MemToReg_i ? readdata_i : aluout_o)
  );

  ucsbece154a_alu alu (
      /*FILL*/
      .a_i(Rd1),
	  .b_i(ALUSrc_i ? (ZeroExtImm_i ? {{16{1'b0}}, instr_i[15:0]} : {{16{instr_i[15]}}, instr_i[15:0]}) : Rd2),
      .f_i(ALUControl_i),
      .y_o(aluout_o),
      .zero_o(AluZero)
  );

endmodule
