module alu(input [31:0] a, b, input [2:0] f, output [31:0] y, output zero); 

	reg [31:0] out;
	reg z;
	assign y = out;
	assign zero = z;

	always@(*) begin 
	case (f)
            3'b000: out = a & b; // AND
            3'b001: out = a | b; // OR
            3'b010: out = a + b; // ADD
            3'b110: out = a - b; // SUB
            3'b111: if (a < b) // SLT
			out = 32'b1;
		    else
			out = 32'b0; 
	    default: out = 0;
        endcase

	if (y == 32'b0)
		z = 1;
	else
		z = 0;

	end
endmodule
