module shifter (input logic[31:0] a,
		input logic[2:0] opcode,
		input logic[4:0] shift,
		output logic[31:0] a_out);
always @* begin
case(opcode)
	// LSL
	3'b000: a_out = a << shift;
	// LSR
	3'b001: a_out = a >> shift;
	//ROR
	3'b010: a_out = (a << shift) | (a >> ~shift);
	// ASR
	3'b011: begin
		if (a[31]) 
			a_out = (a >> shift);// | (32'hFFFFFFFF << ~shift);
		else 
			a_out = a >> shift;
	end
	default a_out = 32'h000000;
endcase
end
endmodule
