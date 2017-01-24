module alu (input logic signed [31:0] a, b,
	input logic [1:0] opcode,
	output logic signed [31:0] c,
	output logic zero,
	output logic negative,
	output logic carry,
	output logic overflow);

define ADD 2'b00
define SUB 2'b01
define ORR 2'b10
define AND 2'b11

logic [1:0] is_overflow;

case(opcode)
	`ADD:
	begin
		assign {carry,c} = a + b;
		if (a[31] & b[31] & ~output[31])
			overflow <= 1'b1;
		else if (~a[31] & ~b[31] & output[31])
			overflow <= 1'b1;
		else 
			overflow <= 1'b0;
	end
	`SUB:
	begin
		assign {carry,c} = a - b;
		if (a[31] & b[31] & ~output[31])
			overflow <= 1'b1;
		else if (~a[31] & ~b[31] & output[31])
			overflow <= 1'b1;
		else 
			overflow <= 1'b0;
	end
	`ORR:
		assign c = a | b;
	`AND:
		assign c = a & b;
endcase
if(c == 0)
	zero <= 1;
else
	zero <= 0;
if(c <= 0)
	negative <= 1;
else
	negative <= 0;


end module
