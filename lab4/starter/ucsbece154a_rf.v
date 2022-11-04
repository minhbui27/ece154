// ucsbece154a_rf.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement Register File
module ucsbece154a_rf (
    input              clk,
    input       [ 4:0] a1_i,
    a2_i,
    a3_i,
    output wire [31:0] rd1_o,
    rd2_o,
    input              we3_i,
    input       [31:0] wd3_i
);

  // **PUT YOUR CODE HERE**
  reg [31:0] regs[31:0];
  always @(posedge clk) begin
    if (we3_i) begin
      if (a3_i != 0) regs[a3_i] <= wd3_i;
      else regs[a3_i] <= 0;
    end
  end
  assign rd1_o = (a1_i != 0) ? regs[a1_i] : 0;
  assign rd2_o = (a2_i != 0) ? regs[a2_i] : 0;
`ifdef SIM
  // **FILL DEBUG SIGNALS HERE**
  wire [31:0] zero = regs[0];
  wire [31:0] at = regs[1];
  wire [31:0] v0 = regs[2];
  wire [31:0] v1 = regs[3];
  wire [31:0] a0 = regs[4];
  wire [31:0] a1 = regs[5];
  wire [31:0] a2 = regs[6];
  wire [31:0] a3 = regs[7];
  wire [31:0] t0 = regs[8];
  wire [31:0] t1 = regs[9];
  wire [31:0] t2 = regs[10];
  wire [31:0] t3 = regs[11];
  wire [31:0] t4 = regs[12];
  wire [31:0] t5 = regs[13];
  wire [31:0] t6 = regs[14];
  wire [31:0] t7 = regs[15];
  wire [31:0] s0 = regs[16];
  wire [31:0] s1 = regs[17];
  wire [31:0] s2 = regs[18];
  wire [31:0] s3 = regs[19];
  wire [31:0] s4 = regs[20];
  wire [31:0] s5 = regs[21];
  wire [31:0] s6 = regs[22];
  wire [31:0] s7 = regs[23];
  wire [31:0] t8 = regs[24];
  wire [31:0] t9 = regs[25];
  wire [31:0] k0 = regs[26];
  wire [31:0] k1 = regs[27];
  wire [31:0] gp = regs[28];
  wire [31:0] sp = regs[29];
  wire [31:0] fp = regs[30];
  wire [31:0] ra = regs[31];
`endif

endmodule
