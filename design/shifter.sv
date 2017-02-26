module shifter (input logic[31:0] a,
		input logic[2:0] opcode,
		input logic carryIn,
		input logic[4:0] shift,
		output logic[31:0] a_out,
		output logic carryOut);
		
		
`define LSL 3'h0
`define LSR 3'h1
`define ASR 3'h2
`define ROR 3'h3
`define RRX 3'h4
		
always @* begin
carryOut = carryIn; //default
case(opcode)
	`LSL: a_out = a << shift;
	`LSR: begin
			if (shift === 5'b00000) a_out = 32'h00000000;
			else a_out = a >> shift;
		  end
	`ROR: a_out = (a << shift) | (a >> (32-shift));
	`ASR: begin
		if (shift === 5'b00000) a_out = 32'h00000000;
		else
		begin
			if (a[31]) 
				a_out = (a >> shift) | (32'hFFFFFFFF << ~shift);
			else 
				a_out = a >> shift;
		end
	end
	`RRX: begin
		a_out[31] = carryIn;
		a_out[30:0] = a[31:1];
		carryOut = a[0];
	end
	default a_out = a;
endcase
end
endmodule
