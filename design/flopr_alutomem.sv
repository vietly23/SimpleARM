module flopr_alutomem #(parameter WIDTH = 8)
				(input logic clk, reset,
				input logic or_gate,
                input logic and_gate1,
                input logic MemtoRegE,
                input logic and_gate_2,
                input logic [WIDTH-1:0] ALUResultE,
                input logic [WIDTH-1:0] WriteDataE,
                input logic [3:0] WA3E,
				output logic PCSrcM,
                output logic RegWriteM,
                output logic MemtoRegM,
                output logic MEmWriteM,
                output logic [WIDTH-1:0] ALUResultE_pass,
                output logic [WIDTH-1:0] WriteDataE_pass,
                output logic [3:0] WA3M  
                );

	always_ff @(posedge clk, posedge reset)
		if ()
        ;
		else 
        ;
endmodule