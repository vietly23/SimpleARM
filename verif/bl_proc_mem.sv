
module data_proc_mem (
	input logic [31:0] a,
	output logic [31:0] rd
	);
	logic [31:0] RAM [63:0];
	//Test program for testing data processing intructs.
	//Exercises the new ALU ops, flag setting & branching based on flags
	//Can include branching, but not BL
	assign RAM [0] = 32'hE0810002 ; //ADD R0, R1, R2
	assign RAM [1] = 32'hE0400009 ; //SUB R0, R0, R9

	assign RAM [2] = 32'hEBFFFFFC ; //BL THERE
	/*assign RAM [3] = 32'hE1510002 ; //CMP R1, R2
	assign RAM [4] = 32'h0A000000 ; //BEQ : Skip next instruction
	assign RAM [5] = 32'hE5802064 ; //mem[100] = 4 : assert mem[100]!=4 in tb (this is skipped)
	assign RAM [6] = 32'hE1710002 ; //CMN R1, R2
	
	
	
	assign rd = RAM[a [31:2]]; // word aligned
	*/
endmodule
