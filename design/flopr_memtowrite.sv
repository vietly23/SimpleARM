module flopr_memtowrite #(parameter WIDTH = 8)
				(input logic clk, reset,
				input logic PCSrcM,
                input logic RegWriteM,
                input logic MemtoRegM,
                input logic [WIDTH-1:0] RD,
                input logic ALUOutM,
                input logic [3:0] WA3M,
                output logic PCSrcW,
                output logic RegWriteW,
                output logic MemtoRegW,
                output logic ReadDataW,
                output logic ALUOutW,
                output WA3M
				);

	always_ff @(posedge clk, posedge reset)
		if () ;
		else ;
endmodule