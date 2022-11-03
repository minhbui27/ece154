// ucsbece154a_rf.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement Register File
module ucsbece154a_rf (
    input               clk,
    input         [4:0] a1_i, a2_i, a3_i,
    output wire  [31:0] rd1_o, rd2_o,
    input               we3_i,
    input        [31:0] wd3_i
);

// **PUT YOUR CODE HERE**
reg [31:0] rf [31:0];
always_ff@(posedge clk) begin
	if(we3_i) begin
		if(a3_i != 0) rf[a3_i] <= wd3_i;
		else rf[a3_i] <= 0;
	end
end
assign rd1_o = (a1_i != 0) ? rf[a1_i] : 0;
assign rd2_o = (a2_i != 0) ? rf[a2_i] : 0;
`ifdef SIM
// **FILL DEBUG SIGNALS HERE**
wire [31:0] zero = rf[0];
wire [31:0] at = rf[1];
wire [31:0] v0 = rf[2];
wire [31:0] v1 = rf[3];
wire [31:0] a0 = rf[4];
wire [31:0] a1 = rf[5];
wire [31:0] a2 = rf[6];
wire [31:0] a3 = rf[7];
wire [31:0] t0 = rf[8];
wire [31:0] t1 = rf[9];
wire [31:0] t2 = rf[10];
wire [31:0] t3 = rf[11];
wire [31:0] t4 = rf[12];
wire [31:0] t5 = rf[13];
wire [31:0] t6 = rf[14];
wire [31:0] t7 = rf[15];
wire [31:0] s0 = rf[16];
wire [31:0] s1 = rf[17];
wire [31:0] s2 = rf[18];
wire [31:0] s3 = rf[19];
wire [31:0] s4 = rf[20];
wire [31:0] s5 = rf[21];
wire [31:0] s6 = rf[22];
wire [31:0] s7 = rf[23];
wire [31:0] t8 = rf[24];
wire [31:0] t9 = rf[25];
wire [31:0] k0 = rf[26];
wire [31:0] k1 = rf[27];
wire [31:0] gp = rf[28];
wire [31:0] sp = rf[29];
wire [31:0] fp = rf[30];
wire [31:0] ra = rf[31];
`endif

endmodule
