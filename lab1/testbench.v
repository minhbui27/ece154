module alu_testbench();

	// 8 bits hex translates to 32 bits binary, and there are 5*21 = 105 cells
	reg [31:0] data [0:104];  
	integer i;
	reg [31:0] expectedY;
	reg expectedZero;

	
	// inputs and outputs
	reg [2:0] f;
	reg [31:0] a, b;
	wire [31:0] aluY;
	wire aluZero;

	alu a1(.a(a), .b(b), .f(f), .y(aluY), .zero(aluZero));

	initial $readmemh("alu.tv", data);
	initial begin
		for (i=0; i < 104; i=i+5) begin
			f = data[i];
			a = data[i+1];
			b = data[i+2];
			expectedY = data[i+3];
			expectedZero = data[i+4];
			$display("f: %d, a: %h, b: %h, yexpected: %h, zeroexpected: %d", f, a, b, expectedY, expectedZero);
			#20;
		end
		$stop;
	end
	 
endmodule
