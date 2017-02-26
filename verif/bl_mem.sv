
module bl_mem (
	input logic [31:0] a,
	output logic [31:0] rd
	);
	logic [31:0] RAM [63:0];
	//Test program for testing data processing intructs.
	//Exercises the new ALU ops, flag setting & branching based on flags
	//Can include branching, but not BL
	assign RAM [0] = 32'hEB000000 ; //BL 1
	assign RAM [1] = 32'hE2800008 ; //ADD R0, R0, #8
	assign RAM [2] = 32'hE0411001 ; //SUB R1, R1, R1
	assign RAM [3] = 32'hE2400008 ; //SUB R0, R0, #8
	assign RAM [4] = 32'hEA000000 ; // B 2
	assign RAM [5] = 32'hE2811000 ; // ADD R1, R1, #0
	assign RAM [6] = 32'hE2811008 ; // ADD R1, R1, #8
	assign RAM [7] = 32'hE2811008 ; // ADD R1, R1, #8
	assign RAM [8] = 32'hE2411008 ; // SUB R1, R1, #8
	
	
	
	
	assign rd = RAM[a [31:2]]; // word aligned
endmodule
