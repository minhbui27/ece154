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
    //for the imem
    input              Jump_i,
    //The zero from the Alu control alu
    input              BranchZero_i,
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


  wire [31:0] Rd1, Rd2, PCBranch;
  wire PCSrc;
  assign writedata_o = Rd2;
  assign pc_o = ;
  ucsbece154a_rf rf (
      /*FILL*/
      .clk  (clk),
      .a1_i (instr_i[25:21]),
      .a2_i (ALUSrc_i ? {{16{instr_i[15]}}, instr_i[15:0]} : instr_i[20:16]),
      .a3_i (RegDst_i ? instr_i[15:11] : instr_i[20:16]),
      .rd1_o(Rd1),
      .rd2_o(Rd2),
      .we3_i(RegWrite_i),
      .wd3_i(MemToReg_i ? readdata_i : aluout_o)
  );

  ucsbece154a_alu alu (
      /*FILL*/
      .a_i(Rd1),
      .b_i(Rd2),
      .f_i(ALUControl_i),
      .y_o(aluout_o),
      .zero_o(BranchZero_i)
  );

endmodule


