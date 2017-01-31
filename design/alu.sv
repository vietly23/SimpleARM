module alu (input logic [31:0] a, b,
	input logic [1:0] opcode,
	output logic [31:0] c,
	output logic [3:0] flags);

`define ADD 2'b00
`define SUB 2'b01
`define AND 2'b10
`define ORR 2'b11

// From 0 to 3, negative, zero, carry, overflow in that respective order

logic [31:0] temp;


always_comb
	case(opcode)
		`ADD:
		begin
			{flags[2],temp} <= a + b;
			if (a[31] & b[31] & ~c[31])
				flags[3] <= 1'b1;
			else if (~a[31] & ~b[31] & c[31])
				flags[3] <= 1'b1;
			else 
				flags[3] <= 1'b0;
		end

		`SUB:
		begin
			{flags[2],temp} <= (a + (~b)) + 1;
			if (a[31] & ~b[31] & ~c[31])
				flags[3] <= 1'b1;
			else if (~a[31] & b[31] & c[31])
				flags[3] <= 1'b1;
			else 
				flags[3] <= 1'b0;
		end

		`AND:
		begin
			temp <= a & b;
			flags[2] <= 1'b0;
			flags[3] <= 1'b0;
		end

		`ORR:
		begin
			temp <= a | b;
			flags[2] <= 1'b0;
			flags[3] <= 1'b0;
		end
	endcase

always_comb
	if(temp == 0)
		flags[1] <= 1'b1;
	else
		flags[1] <= 1'b0;

always_comb
	flags[0] <= temp[31];
always_comb
	c <= temp;
endmodule
