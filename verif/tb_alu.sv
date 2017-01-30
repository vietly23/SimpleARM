module tb_alu();
	logic [31:0] a;
	logic [31:0] b;
	logic [31:0] output;
	logic [1:0] opcode;
	logic zero;
	logic negative;
	logic carry;
	logic overflow;

	my_alu alu(a,b,output,zero,negative,carry,overflow)
	initial
	begin
		a <= 32'h0000000A;
		b <= 32'h00000003;
		opcode <= 2'b00;
	end
	begin
		if (output === 13 & zero === 0 & negative === 0 & carry === 0 & overflow === 0)
			$display("WOW");
		else
			$display("FAIL");
		end
	end 
endmodule
	
	
