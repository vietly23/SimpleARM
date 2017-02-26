module arm( 
	input logic clk, reset, 
	output logic [31:0] PC, 
	input logic [31:0] Instr, 
	output logic MemWrite, 
	output logic [31:0] ALUResult, 
	output logic [31:0] WriteData, 
	input logic [31:0] ReadData,
	output logic [3:0] be);

logic [3:0] ALUFlags, ALUControl; 
logic RegWrite, linkSelect, ALUSrc, MemtoReg, PCSrc, storedCarry, registerShift; 
logic [1:0] RegSrc, ImmSrc;
logic [2:0] shiftOp;
controller c(clk, reset, Instr[31:4], ALUFlags, RegSrc, RegWrite, ImmSrc, ALUSrc, linkSelect,
			ALUControl, MemWrite, MemtoReg, PCSrc, storedCarry,shiftOp, registerShift, be); 
datapath dp(clk, reset, RegSrc, RegWrite, ImmSrc, ALUSrc, linkSelect, ALUControl, MemtoReg, 
			PCSrc, ALUFlags, PC, Instr, ALUResult, WriteData, ReadData,storedCarry,
			shiftOp, registerShift); 

endmodule
