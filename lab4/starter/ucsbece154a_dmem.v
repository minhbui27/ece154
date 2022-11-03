// ucsbece154a_dmem.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement dmem
module ucsbece154a_dmem (
    input              clk,
    we_i,
    input       [31:0] a_i,
    input       [31:0] wd_i,
    output wire [31:0] rd_o
);

  reg [31:0] RAM[0:63];

  // **PUT YOUR CODE HERE**
  // a_i[31:2] because the input is byte addressed and the data memory is word
  // addresed
  assign rd_o = RAM[a_i[7:2]];
  always_ff @(posedge clk) if (we_i) RAM[a_i[7:2]] <= wd_i;
endmodule
