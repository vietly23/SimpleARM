module mux4 #(parameter WIDTH = 8) (
	input logic [WIDTH-1:0] d0,d1,d2, d3,
	input logic [1:0] s,
	output logic [WIDTH-1:0] y);

	always @* begin
	case(opcode)
		2'b00:
			assign y = d0;
		2'b01: 
			assign y = d1;
		2'b10:	
			assign y = d2;
		2'b11:
			assign y = d3;
endmodule
