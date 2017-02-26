module data_proc_mem (
	input logic [31:0] a,
	output logic [31:0] rd
	);
	logic [31:0] RAM [63:0];
	//Test program for testing data processing intructs.
	//Exercises the new ALU ops, flag setting & branching based on flags
	//Can include branching, but not BL
	assign RAM [0] = 32'hE0400000 ; //SUB R0, R0, R0 : R0 = 0
	assign RAM [1] = 32'hE2801004 ; //ADD R1, R0, 4 : R1 = 4
	assign RAM [2] = 32'hE2802004 ; //ADD R2, R0, 4 : R2 = 4
	assign RAM [3] = 32'hE1510002 ; //CMP R1, R2
	assign RAM [4] = 32'h0A000000 ; //BEQ : Skip next instruction
	assign RAM [5] = 32'hE5802064 ; //mem[100] = 4 : assert mem[100]!=4 in tb (this is skipped)
	assign RAM [6] = 32'hE1710002 ; //CMN R1, R2

	assign RAM[7 ] = 32'hE3A09000; // MOV R9, #0
	assign RAM[8 ] = 32'hE3A000C8; // MOV R0, #200
	assign RAM[9 ] = 32'hE3A02014; // MOV R2, #20
	assign RAM[10] = 32'hE3A03004; // MOV R3, #4
	assign RAM[11] = 32'hE3A04002; // MOV R4, #2
	assign RAM[12] = 32'hE7802103; // STR R2,[R0,R3, LSL#2]
	assign RAM[13] = 32'hE7901103; // LDR R1,[R0,R3, LSL #2]
	assign RAM[14] = 32'hE1510002; // CMP R1, R2
	assign RAM[15] = 32'h02899001; // ADDEQ R9, R9, #1 /*Increment pass counter*/
	
	
	
	assign rd = RAM[a [31:2]]; // word aligned
endmodule
