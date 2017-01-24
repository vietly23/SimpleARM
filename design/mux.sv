module mux(a,b,c,code)
parameter WIDTH = 8;
input  logic [WIDTH-1:0] a;
input  logic [WIDTH-1:0] b;
output logic [WIDTH-1:0] c;

case(code)
	1'b0:
		assign c = a;
	1'b1:
		assign c = b;
endcase
endmodule
