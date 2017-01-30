module alu (input logic [31:0] a, b,
	input logic [1:0] opcode,
	output logic [31:0] c,
	output logic zero,
	output logic negative,
	output logic carry,
	output logic overflow);

`define ADD 2'b00
`define SUB 2'b01
`define AND 2'b10
`define ORR 2'b11

logic [1:0] is_overflow;

case(opcode)
	`ADD:
	begin
		assign {carry,c} = a + b;
		if (a[31] & b[31] & ~c[31])
			overflow <= 1'b1;
		else if (~a[31] & ~b[31] & c[31])
			overflow <= 1'b1;
		else 
			overflow <= 1'b0;
	end
	`SUB:
	begin
		assign {carry,c} = (a + (~b)) + 1;
		if (a[31] & ~b[31] & ~c[31])
			overflow <= 1'b1;
		else if (~a[31] & b[31] & c[31])
			overflow <= 1'b1;
		else 
			overflow <= 1'b0;
	end
	`ORR:
		assign c = a | b;
		carry <= 1'b0;
		overflow <= 1'b0;
	`AND:
		assign c = a & b;
		carry <= 1'b0;
		overflow <= 1'b0;
endcase

if(c == 0)
	zero <= 1'b1;
else
	zero <= 1'b0;

negative <= c[31];


end module
