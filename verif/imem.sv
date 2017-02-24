module imem (
	input logic [31:0] a,
	output logic [31:0] rd
	);
	logic [31:0] RAM [63:0];
	// Hardcoded version of the instruction memory in HDL Example 7.15
	// The instructions are from Figure 7.60
	assign RAM [0] = 32'hE04F000F ; //SUB R0, R15, R15   R0=0
	assign RAM [1] = 32'hE2802005 ;//ADD R2, R0, #5   R2=5
	assign RAM [2] = 32'hE280300C ;//ADD R3, R0, #12   R3=12
	assign RAM [3] = 32'hE2437009 ;//SUB R7, R3 #9
	assign RAM [4] = 32'hE1874002 ; // ORR R4, R7, R2
	assign RAM [5] = 32'hE0035004 ; // AND R5, R3, R4
	assign RAM [6] = 32'hE0855004 ; //AND R5, R5, R4
	assign RAM [7] = 32'hE0558007 ; //SUBS R8, R5, R7
	assign RAM [8] = 32'h0A00000C ; //BEQ END    NOT TAKEN
	assign RAM [9] = 32'hE0538004 ; //SUBS R8, R3, R4 
	assign RAM [10] = 32'hAA000000 ;// BGE AROUND 
	assign RAM [11] = 32'hE2805000 ;// ADD R5, R0 #0
	assign RAM [12] = 32'hE0578002 ; // SUBS R8, R7, R2
	assign RAM [13] = 32'hB2857001 ;// ADDLT R7, R5, #1
	assign RAM [14] = 32'hE0477002 ;// SUB R7,R7,R2
	assign RAM [15] = 32'hE5837054 ;// STR R7, [R3, #84] 
	assign RAM [16] = 32'hE5902060 ; //LDR R2, [R0, #96]
	assign RAM [17] = 32'hE08FF000 ; //ADD R15, R15, R0
	assign RAM [18] = 32'hE280200E ; //ADD R2, R0 #14
	assign RAM [19] = 32'hEA000001 ; //B END
	assign RAM [20] = 32'hE280200D ; //ADD R2, R0, #13
	assign RAM [21] = 32'hE280200A ; //ADD R2, R0 #10
	assign RAM [22] = 32'hE5802064 ; //STR R2, [R0, #100] 
	assign rd = RAM[a [31:2]]; // word aligned
endmodule
